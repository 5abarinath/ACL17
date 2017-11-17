const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');
var server = require('http').createServer(app);
var io = require('socket.io')(server);

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
	let sql1 = "SELECT p.player_fname, p.player_lname, p.player_image, g.group_name, p.price FROM Players p, Groups g WHERE p.team_id = ? AND p.group_id = g.group_id";
	connection.query(sql1, [teamID], function(err, result) {
		if(err) throw err;
		results = result;
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
	});
});

// POST request to populate the bidding.ejs script
app.post('/bidding', function(req, res) {
	let teamID = req.body.token;

	let currRound = 0;
	let grp_obj, team_obj, player_obj;
	let sql_count = "SELECT count(*) AS no_of_rounds FROM Bidding";
	connection.query(sql_count, function(err, result) {
		if(err) throw err;
		currRound = result[0].no_of_rounds / 6 + 1;

		let sql_groups = "SELECT * FROM Groups WHERE group_id = ?";
		connection.query(sql_groups, [currRound], function(err1, result1) {
			if(err1) throw err1;
			grp_obj = result1;


			let sql_teams = "SELECT * FROM Bidders WHERE team_id = ?";
			connection.query(sql_teams, [teamID], function(err2, result2) {
				if(err2) throw err2;
				team_obj = result2;


				let sql_players = "SELECT * FROM Players WHERE group_id = ?";
				connection.query(sql_players, [currRound], function(err3, result3) {
					if(err3) throw err3;
					player_obj = result3;
					
					res.render('bidding.ejs', {
					currentRound: currRound,
					group_object: grp_obj,
					team_object: team_obj,
					player_object: player_obj });
				});
			});
		});
	});
});

io.on('connection', function(client) {
	console.log('Client connected...');
		
	client.on('join', function(data) {
		console.log(data);
	});
});



// Start server
server.listen(port, () => {
	console.log('Server started on port ' + port);
});
