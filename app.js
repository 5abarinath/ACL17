const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');

// PORT number
const port = 3000;

// Check connection with MySQL database
const connection = require('./config/database');

// CORS middleware
app.use(cors());

// Set up view engine as ejs
app.set('views', path.join(__dirname, '/views'));
app.set('view engine', 'ejs');

// Set static folder
app.use(express.static(path.join(__dirname + '/public')));

// Body-Parser middleware
app.use(bodyParser.urlencoded({extended:true}));
app.use(bodyParser.json());

// index.html
app.get('/', function(req, res) {
	res.sendFile('index');
});

// POST request to render teamprofile.ejs
app.post('/teamprofile', function(req, res) {
	let teamID = req.body.token;
	
	var results;
	let sql1 = "SELECT p.player_fname, p.player_lname, p.player_image, g.group_name, p.price FROM Players p, Groups g WHERE p.team_id =? AND p.group_id = g.group_id";
	connection.query(sql1, [teamID], function(err, result) {
		if(err) throw err;
		results = result;
		// res.render('teamprofile', {data: results});
		
	});


	let sql = "SELECT * FROM Bidders WHERE team_id = ?";
	connection.query(sql, [teamID], function(err, result) {
		if(err) throw err;
		res.render('teamprofile', { 
					   teamName: result[0].team_name,
					   teamOwner: result[0].team_owner,
					   teamLogo: result[0].team_logo,
					   pointsSpent: result[0].points_spent,
					   premiumLeft: result[0].premium_left,
					   data: results });
		// console.log(results);
	});

	
});

// Start server
app.listen(port, () => {
	console.log('Server started on port ' + port);
});
