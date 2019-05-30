var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'
router.get('/:issueid', function(req, res, next) {
    const pool = new Pool({
        connectionString: connectionString,
      });
        pool.query('SELECT "userId","content" from "Comment" where "issueId"=$1',[req.params.id],(err,data)=>{
        if(err)
          res.json({err});
        else
          res.json(data.rows);         
      });
});
router.post('/',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('INSERT INTO "Comment" ("issueId","userId,"content") values($1,$2,$3)',
      [req.body.userId,req.body.userId,req.body.content],(err,data)=>{ 
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
      pool.query('UPDATE "Comment" SET "userId"=$1,"issueId"=$2,"content"=$3 WHERE id=$4',
      [req.body.userId,req.body.issueId,req.body.content,req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
})
router.delete('/:id',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('DELETE FROM "Comment" WHERE "id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
});

module.exports = router;
