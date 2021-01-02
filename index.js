const path = require('path');
const serveStatic = require('serve-static');
const express = require('express');
const server = express();
const bodyParser = require('body-parser');
const sqlite3 = require('sqlite3').verbose();
const jwt = require('jsonwebtoken');
const https = require('https');
const http = require('http');
const cors = require('cors');
const dotenv = require("dotenv");
const fs = require('fs');

dotenv.config();

let db = new sqlite3.Database('./db/0xsp.db');
server.use(bodyParser.json());
server.use(bodyParser.urlencoded({ extended: false }));
server.use(cors());

server.use(express.static(__dirname + '/public'));

server.use("/uploads", express.static(__dirname + "/uploads"));
server.use("/plugins", express.static(__dirname + "/plugins"));
server.use("/release", express.static(__dirname + "/release"));


db.once('open', function () {
  console.log('DB is ready for work!');
});

server.get('/api/postReq', function (req, res) {
  res.send("GET Method is not Supported.");
});

server.post('/api/postReq', function (req, res, next) {
  let userSql = `SELECT * FROM users WHERE username = ? AND password = ?`;
  var i;
  db.all(userSql, [req.body.username, req.body.password], (err, rows) => {
    if (err) {
      next(err);
      return;
    }
    if (!rows) {
      res.status(400);
      return
    }
    rows.forEach((row) => {
      if (row.username === req.body.username && row.password === req.body.password) {
        i = 1;
      }
      else {
        i = 2;
        db.close();
      }
    })
    if (i === 1) {
      var request = {
        output: req.body.output,
        owner: 'admin',
        category: req.body.category,
        host: req.body.host,
        created_at: new Date().toISOString().replace(/T/, ' ').replace(/\..+/, ''),
        sys: req.body.sys,
        random_val: req.body.random_string,
      };
      var sql = 'INSERT INTO outputs (output_body, output_owner, output_category,host,created_at,sys,random_val) VALUES (?,?,?,?,?,?,?)'
      db.serialize(function () {
        var stmt = db.prepare(sql);
        stmt.run(request.output, request.owner, request.category, request.host, request.created_at, request.sys, request.random_val);
        stmt.finalize();
      });
      res.json({
        message: "success",
      });
    }
    else {
      res.status(404).json({ "error": "please check username & password and try again!" });
    }
  })
});

server.post('/api/cmd_commands', function (req, res, next) {
  let userSql = `SELECT * FROM users WHERE username = ? AND password = ?`;
  var i;
  db.all(userSql, [req.body.username, req.body.password], (err, rows) => {
    if (err) {
      next(err);
      return;
    }
    if (!rows) {
      res.status(400);
      return
    }
    rows.forEach((row) => {
      if (row.username === req.body.username && row.password === req.body.password) {
        i = 1;
      }
      else {
        i = 2;
        db.close();
      }
    })
    if (i === 1) {
      var request = {
        command_output: req.body.command_output,
      };
      var sql = 'UPDATE commands SET command_output = ?'
      db.serialize(function () {
        var stmt = db.prepare(sql);
        stmt.run(request.command_output);
        stmt.finalize();
      });
      res.json({
        message: "success",
      });
    }
    else {
      res.status(404).json({ "error": "please check username & password and try again!" });
    }
  })
});

server.post('/auth', function (req, res) {
  let userSql = `SELECT * FROM users WHERE username = ? AND password = ?`;
  var i;
  db.all(userSql, [req.body.username, req.body.password], function (err, row) {
    if (err) return res.status(500).send('Server error!');
    row.forEach((user) => {
      if (user.username === req.body.username && user.password === req.body.password) {
        i = 1;
      }
      else {
        i = 2;
        db.close();
      }
    })
    if (i === 1) {
      // Generate an access token
      const accessToken = jwt.sign({ username: "admin" }, process.env.TOKEN_SECRET, { expiresIn: '24h' });
      res.json({
        user: "admin",
        accessToken: accessToken
      });
    } else {

      res.json({ msg: "username or password incorrect!" })
    }
  });
});


server.get('/api/getcommands', function (req, res, next) {
  let sql = "SELECT * FROM commands WHERE id = 1";
  db.get(sql, (err, data) => {
    if (err) {
      throw err;
    }
    res.send(data.command);
  });
});



let dashboard = require('./routes/dashboard');
let upload = require('./routes/upload');

server.use('/mydashboard', dashboard);
server.use('/upload', upload);

server.get('*', (req, res) => res.sendFile(__dirname + '/public/index.html'));

var args = process.argv;

if(args.slice(2) == 'useSSL'){
    https.createServer({
      cert: fs.readFileSync(process.env.CERT_PATH),
      ca: fs.readFileSync(process.env.CHAIN_PATH),
      key: fs.readFileSync(process.env.KEY_PATH)
    },server).listen(4000,'0.0.0.0', function () {
      console.log('0xsp Started on port 4000');
  });
}else{
http.createServer(server).listen(4000,'0.0.0.0', function () {
    console.log('0xsp Started on port 4000');
});
}
