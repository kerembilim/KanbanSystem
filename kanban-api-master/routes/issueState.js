var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'

router.get('/priority/:id',(req,res,next)=>{
    
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('SELECT "public"."IssueState"."title" FROM "public"."IssueState" INNER JOIN "public"."Priority" ON "public"."IssueState"."id" = "public"."Priority"."id" where "public"."Priority"."id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
             res.json(data.rows[0]);

      });
});
router.get('/statu/:id',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('SELECT "public"."IssueState"."title" FROM "public"."IssueState" INNER JOIN "public"."Statu" ON "public"."IssueState"."id" = "public"."Statu"."id" where "public"."Statu"."id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
             res.json(data.rows[0]);
      });
});
module.exports = router;
