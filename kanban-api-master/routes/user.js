var express = require('express');
var router = express.Router();
var pg = require("pg");

/* GET users listing. */
const { Pool, Client } = require('pg')
const connectionString = 'postgresql://postgres:postgres@localhost:5432/kanban'

router.post('/register',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      }); 
      pool.query('INSERT INTO "User" (name,password) values($1,$2)',
      [req.body.name,req.body.password],(err,data)=>{
        if(err)
          res.json({err})
        else
          pool.query('SELECT * from "User" where "name"=$1',[req.body.name],(err,data)=>{
             res.json(data.rows[0]); 
          });     
           
      });
});
router.get('/getRole/:userid',(req,res)=>{
  const pool = new Pool({
    connectionString: connectionString,
  }); 
  pool.query('SELECT * from getRole($1)',
  [req.params.userid],(err,data)=>{
    if(err)
      res.json({err})
    else
      res.json(data.rows[0]);
     
  });
});
router.post('/postRole',(req,res)=>{
  let say;
  const pool = new Pool({
    connectionString: connectionString,
  }); 
  
   pool.query('SELECT count("id") from "UserRole"',(err,data)=>{
    if(err)
      res.json({err})
    else{
      say=parseInt(data.rows[0].count)+1;
      pool.query('SELECT * from postRole($1,$2,$3,$4)',
      [say,req.body.userid,req.body.roleid,req.body.projectid],(err,data)=>{
       if(err)
         res.json({err})
       else
          res.json(data.rows[0]);
     
  });
    }           
  });
  
});
router.post('/usercontrol',(req,res,next)=>{
    const pool = new Pool({
        connectionString: connectionString,
      });
      pool.query('SELECT "public"."Team"."name" AS "teamname","public"."User"."id" AS "userid","public"."User"."name","public"."User"."password","public"."User"."teamId","public"."User"."userPhotoId","public"."Team"."id","public"."Role"."name" AS "role","public"."File"."key"FROM "public"."User" LEFT OUTER JOIN "public"."Team" ON "public"."User"."teamId" = "public"."Team"."id" LEFT OUTER JOIN "public"."UserRole" ON "public"."UserRole"."userId" = "public"."User"."id" LEFT OUTER JOIN "public"."Role"  ON "public"."UserRole"."roleId" = "public"."Role"."id" LEFT OUTER JOIN "public"."File" ON "public"."User"."userPhotoId" = "public"."File"."id" Where "public"."User"."name"=$1  AND "public"."User"."password"=$2',
      [req.body.name,req.body.password],(err,data)=>{
        if(err)
        {
            res.json({err});
        }          
        else
        {
            if(data.rows[0]==null)
            {
               res.json({status:'No data.'});
            }
            else
            {
                 res.json(data.rows[0]);
            }            
        }
      });
});



module.exports = router;
