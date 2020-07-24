const express = require('express');
const router = express.Router();
const sqlite3 = require('sqlite3').verbose();
const multer = require('multer');
const expressSanitizer = require('express-sanitizer');

let db = new sqlite3.Database('./db/0xsp.db');

router.use(expressSanitizer());
var storage = multer.diskStorage({
    destination: function (request, file, callback) {
        callback(null, 'uploads/');
    },
    filename: function (request, file, callback) {
        callback(null, file.originalname)
    }
});

var upload = multer({ storage: storage });

// File Upload API
router.post('/uploadFile', upload.single('file'), function (req, res, next) {
    let userSql = `SELECT * FROM users WHERE username = ? AND password = ?`;
    var i;
    db.all(userSql,[req.sanitize(req.body.username),req.sanitize(req.body.password)], (err, rows) => {
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
        });
        if (i === 1) {
            if (req.file) {
                filename = req.sanitize(req.file.originalname);
                filetype = req.file.mimetype;
                let sql = "INSERT INTO download_center (file_name,file_type) VALUES(?,?)"
                db.run(sql, [filename, filetype], (err, result) => {
                    if (err) {
                        throw err;
                    }
                    res.sendStatus(200);
                });
            } else {
                res.sendStatus(404);
            }
        } else {
            res.status(404).json({ "error": "please check username & password and try again!" });
        }
    });
});

module.exports = router;
