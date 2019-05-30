var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'
router.get('/', function(req, res, next) {
  const pool = new Pool({
      connectionString: connectionString,
    });     
      pool.query('SELECT * from "Team"',(err,data)=>{
      if(err)
        res.json({err});
      else
        res.json(data.rows);
       
    });
});
router.get('/:id', function(req, res, next) {
    const pool = new Pool({
        connectionString: connectionString,
      });     
        pool.query('SELECT * from "Team" where id=$1',[req.params.id],(err,data)=>{
        if(err)
          res.json({err});
        else
          res.json(data.rows[0]);         
      });
});
router.put('/:teamid/:userid', function(req, res, next) {//kullaniciya takim ekler
  const pool = new Pool({
      connectionString: connectionString,
    });
     pool.query('UPDATE "User" SET "teamId" =$1 WHERE "id"=$2;',[req.params.teamid,req.params.userid],(err,data)=>{
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
      pool.query('INSERT INTO "Team" (name) values($1)',
      [req.body.name],(err,data)=>{
        if(err)
          res.json({err})
        else{
          res.json({status:"OK"});
        }

          
         
      });
});
router.post('/useradd/:userid/:teamid',(req,res,next)=>{
  const pool = new Pool({
      connectionString: connectionString,
    }); 
    pool.query('UPDATE "User" SET "teamId"=$1 where  "id"=$2',
    [req.params.teamid,req.params.userid],(err,data)=>{
      if(err)
        res.json({err})
      else{
        res.json({status:"OK"});
      }       
    });
});

router.put('/:id',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('UPDATE "Team" SET "name"=$1 WHERE id=$2',
      [req.body.name,req.params.id],(err,data)=>{
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
      pool.query('DELETE FROM "Team" WHERE "id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
})

module.exports = router;
