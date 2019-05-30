var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'
router.get('/all/:userid', function(req, res, next) {//ok
    const pool = new Pool({
        connectionString: connectionString,
      });     
        pool.query('SELECT "public"."Project"."id","public"."Project"."name","public"."Project"."description","public"."User"."id" AS "userId" FROM "public"."User" LEFT OUTER JOIN "public"."Team"  ON "public"."User"."teamId" = "public"."Team"."id" LEFT OUTER JOIN "public"."TeamProject"  ON "public"."TeamProject"."teamId" = "public"."Team"."id" LEFT OUTER JOIN "public"."Project"  ON "public"."TeamProject"."projectId" = "public"."Project"."id" WHERE "public"."User"."id"=$1',
        [req.params.userid],(err,data)=>{
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
      pool.query('INSERT INTO "Project" ("name","description") values($1,$2)',
      [req.body.name,req.body.description],(err,data)=>{ 
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
      pool.query('UPDATE "Project" SET "name"=$1,"description"=$3 WHERE id=$2',
      [req.body.name,req.params.id,req.body.description],(err,data)=>{
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
      pool.query('DELETE FROM "Project" WHERE "id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
})

module.exports = router;
