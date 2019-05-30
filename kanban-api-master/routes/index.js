var express = require('express');
var router = express.Router();
var pg = require("pg");

router.get('/', function(req, res, next) {
    res.json('çalışıyor');
  });
  router.get( '/authenticate' ,(req,res) =>{
    const{name,password} =req.body;
    const pool = new Pool({
      connectionString: connectionString,
    });     
      pool.query('SELECT * from "User" where "name"=$1 AND "password"=$2 ',[name,password],(err,data)=>{
      if(err)
        res.json({err});
      else if(data.length!=0)
      {
        res.json(data.rows);
      }
        
       
    });

  });

module.exports = router;
