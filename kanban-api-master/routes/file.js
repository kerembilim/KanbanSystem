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
        pool.query('SELECT * from getfile($1);',[req.params.id],(err,data)=>{
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
      pool.query('INSERT INTO "File" ("photoUrl") values($1)',
      [req.body.photoUrl,],(err,data)=>{ 
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
      pool.query('UPDATE "File" SET "photoUrl"=$1 WHERE id=$2',
      [req.body.photoUrl,req.params.id],(err,data)=>{
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
      pool.query('DELETE FROM "File" WHERE "id"=$1',
      [req.params.id],(err,data)=>{
        if(err)
          res.json({err})
        else
          res.json({status:"OK"})
         
      });
})

module.exports = router;
