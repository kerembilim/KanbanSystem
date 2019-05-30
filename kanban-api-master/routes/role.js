var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'
router.get('/:id', function(req, res, next) {
    const pool = new Pool({
        connectionString: connectionString,
      });     
        pool.query('SELECT "name" from "Role" where id=$1',[req.params.id],(err,data)=>{
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
      pool.query('INSERT INTO "Role" ("name") values($1)',
      [req.body.name],(err,data)=>{ 
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
});

module.exports = router;
