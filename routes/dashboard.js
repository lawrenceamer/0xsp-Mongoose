const express = require('express');
const cors = require('cors');
const router = express.Router();
const sqlite3 = require('sqlite3').verbose();
const dotenv = require("dotenv");
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const fs = require('fs');
const request = require('request-promise');
const checkInternetConnected = require('check-internet-connected');
const expressSanitizer = require('express-sanitizer');
const { route } = require('./upload');
const PLUGINS_URL = "https://0xsp.com/plugins.json";
const CMDLET_URL = "https://0xsp.com/cmdlet.json";
const LOCAL_PLUGINS_FILE = "/plugins.json";
const LOCAL_CMDLET_FILE = "/cmdlet.json";
const PLUGINS_DIR = "./plugins/";

router.use(cors());

dotenv.config();

let db = new sqlite3.Database('./db/0xsp.db');

router.use(bodyParser.json());
router.use(expressSanitizer());
router.use(bodyParser.urlencoded({ extended: false }));


function authenticateToken(req, res, next) {
  // Gather the jwt access token from the request header
  let token = req.headers['x-access-token'] || req.headers['authorization'];
  if (token) {
    jwt.verify(token, process.env.TOKEN_SECRET, (err, decoded) => {
      if (err) {
        return res.json({
          success: false,
          message: 'Token is not valid'
        })
      } else {
        next();
      }
    });
  } else {
    return res.json({
      success: false,
      message: 'Auth token is not supplied'
    });
  }
}

router.get('/', authenticateToken, function (req, res) {
  // let requestSegments = req.path.split('/');
  let hostSql = 'SELECT COUNT(DISTINCT host) as hosts,COUNT(*) as body  FROM outputs';
  db.all(hostSql, [], (err, rows) => {
    if (err) {
      throw err;
    }
    rows.forEach(row => {
      hosts = row.hosts;
      newResult = row.body;
    });
    res.json({ hosts, newResult })
  });
});

router.get('/getwindowshosts', authenticateToken, function (req, res) {
  sql = 'SELECT random_val,sys,created_at,host,id FROM outputs WHERE sys LIKE "win%" OR sys LIKE "Win%" GROUP BY random_val';
  db.all(sql, [], (err, windowsdata) => {
    if (err) {
      throw err;
    }
    res.json({ windowsdata });
  });
});

router.get('/getlinuxhosts', authenticateToken, function (req, res) {
  sql = 'SELECT random_val,sys,created_at,host,id FROM outputs WHERE sys NOT LIKE "Win%" OR sys NOT LIKE "win%" GROUP BY random_val';
  db.all(sql, [], (err, linuxdata) => {
    if (err) {
      throw err;
    }
    res.json({ linuxdata });
  });
});

router.get('/getResult/:id/:cat', authenticateToken, function (req, res) {
  let sql = `SELECT COUNT(*) as dd FROM ( select strftime("%Y-%m-%d %H:%M", created_at) as date from outputs WHERE random_val = ?`;
  sql += ` AND output_category = ? group by date)`;
  db.all(sql, [req.params.id, req.params.cat], (err, data) => {
    if (err) {
      throw err;
    }
    data.forEach(result => {
      results = result.dd;
      res.json({ results });
    });
  });
});

router.post('/deleteScan', authenticateToken, function (req, res) {
  let deleteSql = `DELETE FROM outputs WHERE random_val = ?`;
  db.get(deleteSql, [req.sanitize(req.body.random_val)], (err, data) => {
    if (err) {
      throw err;
    } else {
      res.status(200).json({ success: true });
    }
  });

});

router.get('/scanresult/1/:id', authenticateToken, function (req, res) {
  // let requestSegments = req.path.split('/');
  let sql = `SELECT * FROM categories WHERE os LIKE "win%" OR os LIKE "Win%"`;
  db.all(sql, [], (err, rows) => {
    if (err) {
      throw err;
    }
    rows.forEach(catNameById => {
      catName = catNameById.cat_name;
    });

    res.json({ rows, catName });
  });
});
router.get('/scanresult/2/:id', authenticateToken, function (req, res) {
  let sql = `SELECT * FROM categories WHERE os NOT LIKE "Win%" OR os NOT LIKE "win%"`;
  db.all(sql, [], (err, rows) => {
    if (err) {
      throw err;
    }
    rows.forEach(catNameById => {
      catName = catNameById.cat_name;
    });

    res.json({ rows, catName });
  });
});

router.get('/scanresult/:scanID/:catID', authenticateToken, function (req, res) {
  let sql = `SELECT *,strftime("%Y-%m-%d %H:%M", created_at) as date,group_concat(DISTINCT outputs.output_body) AS body FROM outputs INNER JOIN categories ON outputs.output_category=categories.cat_id `;
  sql += `  WHERE outputs.random_val = "${req.params.scanID}" AND outputs.output_category = "${req.params.catID}" GROUP BY date`;
  db.all(sql, [], (err, data) => {
    if (err) {
      throw err;
    }

    res.send({data})
  });
});

// make sure to use isLoggedIn
router.get('/getDownloadCenter', authenticateToken, function (req, res) {
  sql = 'SELECT id,file_name,file_type FROM download_center';
  db.all(sql, [], (err, data) => {
    if (err) {
      throw err;
    }
    res.json({ data });
  });

});

router.get('/downloadFile/:id', authenticateToken, function (req, res) {
  let sql = `SELECT id,file_name FROM download_center WHERE id = ?`;
  db.all(sql, [req.params.id], (err, data) => {
    if (err) {
      throw err;
    }
    data.forEach(file => {
      fullFileName = file.file_name;
    });
    res.json({ fullFileName });
  });
});

router.post('/downloadFile/:id', authenticateToken, function (req, res) {
  let sql = `DELETE FROM download_center WHERE id = ?`;
  let deleteSql = `SELECT * FROM download_center WHERE id = ?`;
  var fileName = '';
  db.get(deleteSql, [req.sanitize(req.params.id)], (err, data) => {
    if (err) {
      throw err;
    }
    if (data > 0) {
      (async () => {
        try {
          fs.unlink('./uploads/' + `${data.file_name}`, (err) => {
            if (err) throw err;
          });
        } catch (e) {
          console.log(e);
        }
      })();
    }
  });
  db.get(sql, [req.params.id], (err) => {
    if (err) {
      throw err;
    }
    res.sendStatus(200);
  });
});



router.get('/checkInternetCon', authenticateToken, function (req, res) {
  checkInternetConnected()
    .then((result) => {
      res.json({ success: true })
    })
    .catch((ex) => {
      res.json({ success: false })
    });

});

router.get('/getCmdlet', authenticateToken, function (req, res, next) {
  checkInternetConnected()
    .then((result) => {
      parseCmdlet().then(function (cmdlet) {
        fs.writeFileSync(PLUGINS_DIR + LOCAL_CMDLET_FILE, JSON.stringify(cmdlet));
      }).catch(function (err) {
        res.json({ err })
      });
    })
    .catch((ex) => {
      console.log(ex); // cannot connect to a server or error occurred.
    });

  let rawdata = fs.readFileSync(PLUGINS_DIR + LOCAL_CMDLET_FILE);
  let cmdlet = JSON.parse(rawdata);
  res.json({ cmdlet })
});

function parseCmdlet() {
  return new Promise(function (resolve, reject) {
    request(CMDLET_URL, function (error, response, body) {
      if (error) return reject(error);
      try {
        resolve(JSON.parse(body));
      } catch (e) {
        reject(e);
      }
    });
  });
}


router.get('/getPlugins', authenticateToken, function (req, res, next) {
  checkInternetConnected()
    .then((result) => {
      parse().then(function (plugins) {
        fs.writeFileSync(PLUGINS_DIR + LOCAL_PLUGINS_FILE, JSON.stringify(plugins));
      }).catch(function (err) {
        res.json({ err })
      });
    })
    .catch((ex) => {
      console.log(ex); // cannot connect to a server or error occurred.
    });

  let rawdata = fs.readFileSync(PLUGINS_DIR + LOCAL_PLUGINS_FILE);
  let plugins = JSON.parse(rawdata);
  res.json({ plugins })
});

function parse() {
  return new Promise(function (resolve, reject) {
    request(PLUGINS_URL, function (error, response, body) {
      if (error) return reject(error);
      try {
        resolve(JSON.parse(body));
      } catch (e) {
        reject(e);
      }
    });
  });
}

router.get('/checkPlugin/:pluginName', authenticateToken, function (req, res) {
  (async () => {
    try {
      if (fs.existsSync(PLUGINS_DIR + req.params.pluginName)) {
        res.send({ msg: "File exists", success: true })
      } else {
        res.send({ msg: "File does not exist", success: false })
      }
    } catch (err) {
      console.error(err)
    }
  })();
});

router.post('/installPlugin/', authenticateToken, function (req, res) {
  checkInternetConnected()
    .then((result) => {
      let file = fs.createWriteStream(PLUGINS_DIR + req.body.cmd);
      new Promise((resolve, reject) => {
        let stream = request({
          uri: req.body.plugin_url,
          headers: {
            'Accept': '*',
            'Accept-Encoding': 'gzip, deflate, br',
            'Accept-Language': 'en-US,en;q=0.9,fr;q=0.8,ro;q=0.7,ru;q=0.6,la;q=0.5,pt;q=0.4,de;q=0.3',
          },
          gzip: true
        })
          .pipe(file)
          .on('finish', () => {
            res.sendStatus(200);
            resolve();
          })
          .on('error', (error) => {
            reject(error);
          })
      })
        .catch(error => {
          console.log(`${error}`);
        });
    })
    .catch((ex) => {
      res.sendStatus(404);
    });
});

router.get('/commands',authenticateToken,function(req,res){
  let sql = "SELECT * FROM commands WHERE id = 1";
  db.get(sql,(err,row) => {
    if(err){
      throw err;
    }
    res.json({commands:row});
  });
});

router.post('/updatecommand',authenticateToken,function(req,res){
  let command = req.sanitize(req.body.command);
  let sql = "UPDATE commands SET command = ?";
  db.run(sql,[command],(err,row) => {
    if(err){
      throw err;
    }
    res.json({success:true,msg:"Command Updated!"});
  });
});



router.post('/resetpass', authenticateToken, function (req, res) {
  let password = req.sanitize(req.body.password);
  let sql = 'UPDATE users SET password = ? ';
  if (password) {
    db.run(sql, [password], (err, row) => {
      if (err) {
        throw err;
      }
      res.json({ success: true, msg: "Password Changed Successfully" });
    });
  }
  else {
    res.json({ msg: "Password Cannot be empty!", success: false });
  }
});

module.exports = router;
