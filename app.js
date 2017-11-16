const express = require('express');
const app = express();
const session = require('express-session');
const path = require('path');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const passport = require('passport');
const flash = require('connect-flash');
const cors = require('cors');

// PORT number
const port = 3000;

// Check connection with MySQL database
const connection = require('./config/database');

// Configure passport for login
require('./config/passport')(passport);

// CORS middleware
app.use(cors());

// Set up view engine as ejs
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'ejs');

// Set static folder
app.use(express.static(path.join(__dirname + '/public')));

// Set up session for persistent logins using passport
app.use(session({
	secret: 'ACL2017biddingsecret',
	resave: true,
	saveUninitialized: true
}));

// Cookie-Parser middleware
app.use(cookieParser());

// Body-Parser middleware
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

// Initialize passport
app.use(passport.initialize());
// Set up session using passport for persistent logins
app.use(passport.session());

// Use connect-flash for flash messages stored in session
app.use(flash());

// Routes
require('./routes')(app, passport);

// Start server
app.listen(port, () => {
	console.log('Server started on port ' + port);
});
