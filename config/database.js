const mysql = require('mysql');
const constants = require('./constants');

const connection = mysql.createConnection({
    host : constants.DATABASE_URL,
    user : constants.DATABASE_USER,
    password : constants.DATABASE_PASSWORD,
    database : constants.DATABASE_NAME,
    port: constants.DATABASE_PORT,
}); 

connection.connect(function(err) {
    if(!err)
        console.log('Connected to database with ID: ' + connection.threadId);
    else
        console.log('Error connecting to database: ' + err);
});

module.exports = connection;
