var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'
router.get('/userlists/:userid', function(req, res, next) {
  const pool = new Pool({
      connectionString: connectionString,
    });
      pool.query('SELECT * from "List" where "userId"=$1',[req.params.userid],(err,data)=>{
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
        pool.query('SELECT "userId","name" from "List" where id=$1',[req.params.id],(err,data)=>{
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
      pool.query('INSERT INTO "List" ("userId","name") values($1,$2)',
      [req.body.userId,req.body.name],(err,data)=>{ 
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
      pool.query('UPDATE "List" SET "userId"=$1 WHERE id=$2',
      [req.body.userId,req.params.id],(err,data)=>{
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
      pool.query('DELETE FROM "List" WHERE "id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
});

module.exports = router;
