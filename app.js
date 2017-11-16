const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const flash = require('connect-flash');
const cors = require('cors');

// PORT number
const port = 3000;

// Check connection with MySQL database
const connection = require('./config/database');

// CORS middleware
app.use(cors());

// Set up view engine as ejs
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Set static folder
app.use(express.static(path.join(__dirname + '/public')));

// Cookie-Parser middleware
app.use(cookieParser());

// Body-Parser middleware
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

// Use connect-flash for flash messages stored in session
app.use(flash());

app.get('/', function(req, res) {
	res.sendFile(__dirname + '/public/index.html');
});

// Start server
app.listen(port, () => {
	console.log('Server started on port ' + port);
});
