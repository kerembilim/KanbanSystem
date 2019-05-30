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
      pool.query('SELECT "public"."Project"."name","public"."Project"."id","public"."Project"."description","public"."User"."id" AS "userId" FROM "public"."User" LEFT OUTER JOIN "public"."Team"  ON "public"."User"."teamId" = "public"."Team"."id" LEFT OUTER JOIN "public"."TeamProject"  ON "public"."TeamProject"."teamId" = "public"."Team"."id" LEFT OUTER JOIN "public"."Project"  ON "public"."TeamProject"."projectId" = "public"."Project"."id" WHERE "public"."User"."id"=$1',
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
      var today = new Date();
      var nextWeek = new Date(today.getFullYear(), today.getMonth(), today.getDate()+7);
      
      pool.query('INSERT INTO "Issue" ("title", "description",  "userId", "priorityId", "statuId", "listId","deadline","projectId") values($1,$2,$3,$4,$5,$6,$7,$8)',
      [req.body.title,req.body.description,req.body.userid,req.body.priorityid,req.body.statuid,req.body.listid,nextWeek,req.body.projectid],(err,data)=>{ 
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
      pool.query('UPDATE "Issue" SET "title"=$1,"description"=$2,"userId"=$3,"priorityId"=$4,"statuId"$5,"listId"=$6,"deadline"=$7 WHERE id=$8',
      [req.body.title,req.body.description,req.body.userid,req.body.priorityid,req.body.statuid,req.body.listid,req.body.deadline,req.params.id],(err,data)=>{
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
      pool.query('DELETE FROM "Issue" WHERE "id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
})

module.exports = router;
