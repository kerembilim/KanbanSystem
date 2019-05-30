var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'
router.get('/:userid', function(req, res, next) {
    const pool = new Pool({
        connectionString: connectionString,
      });     
        pool.query(' Select * from returnScore($1);',[req.params.userid],(err,data)=>{
        if(err)
          res.json({err});
        else
          res.json(data.rows[0]);         
      });
});
router.post('/',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('INSERT INTO "ScoreInProject" ("userId","projectId","score") values($1,$2,$3)',
      [req.body.userId,req.body.projectId,req.body.score],(err,data)=>{ 
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
});

router.put('/:id',(req,res,next)=>{
  const pool = new Pool({
      connectionString: connectionString,
    }); 
    pool.query('UPDATE "ScoreInProject" SET "userId"=$1,"projectId"=$2,"score"=$3 where id=$4',
    [req.body.userId,req.body.projectId,req.body.score,req.params.id],(err,data)=>{ 
      if(err)
        res.json({err})
      else
        res.json({status:"OK"})
       
    });
});

module.exports = router;
