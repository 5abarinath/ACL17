const mysql = require('mysql');

const connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : '',
    database : 'ACL17'
}); 

connection.connect(function(err) {
    if(!err)
        console.log('Connected to database with ID: ' + connection.threadId);
    else
        console.log('Error connecting to database: ' + err);
});

module.exports = connection;
