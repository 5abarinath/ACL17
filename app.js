const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cors = require('cors');
const server = require('http').createServer(app);
const io = require('socket.io')(server);
const redis = require('redis');


// PORT number
const port = 3000;

// redis client
const redisClient = redis.createClient();

// Check connection with MySQL database
const connection = require('./config/database');

// Check connection with redis
redisClient.on('connect', function() {
	console.log('Redis Connected');
	redisClient.set('currentBid', 0);
	redisClient.set('currentRound', 1);
	

	let sql_groups = "SELECT * FROM Groups WHERE group_id = 1";
	connection.query(sql_groups, function(err, result) {
		if(err) throw err;
		redisClient.set('baseBid', result[0].base_bid);
		redisClient.set('maxBid', result[0].max_bid);
	});

	for(var i=1; i<=6; i++){
		key = "aclteam" + i;
		redisClient.hmset(key, {
		    'bidFlag': 0,
		    'rank': 0,
		    'premLeft': 0,
		    'yourBid': 0
		});
	} 
});
redisClient.on('error', function(){
	console.log('Error in redis');
});

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

	var key = "aclteam" + teamID;
	redisClient.exists(key, function(err, reply) {
		if (reply != 1) {
			console.log("Redis entry" + key + "doesnt exist");	    	  
	    }
	});
	
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

	teamObject = 0;
	redisClient.hgetall("aclteam" + teamID, function(err, object) {
		teamObject = object;
		console.log(teamObject);

		
			let currRound = 0, currBid = 0, teamRank = 0, yourBid = 0, prem_flag = 0;
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

							if(teamObject.bidFlag == 1){
								redisClient.get('currentBid', function(err, reply) {
								    currBid = reply;

								    client.get('maxBid', function(err1, reply1) {
									    grp_obj.max_bid = reply1;

										client.get('baseBid', function(err2, reply2) {
									    	grp_obj.base_bid = reply2;

									    	team_obj.premium_left = teamObject.premLeft;
									    	teamRank = teamObject.rank;
									    	yourBid = teamObject.yourBid;

									    	if(currBid >= grp_obj.max_bid){
									    		prem_flag = 1;
									    	}
										});
									});
								});
							}

							res.render('bidding.ejs', {
							currentRound: currRound,
							group_object: grp_obj,
							team_object: team_obj,
							player_object: player_obj,
							current_bid: currBid,
							rank: teamRank,
							your_bid: yourBid,
							premiumFlag: prem_flag });
						});
					});
				});
			});
		// else{

		// 	var currRound, max_bid, base_bid;
		// 	redisClient.get('currentRound', function(err, reply) {
		// 	    currRound = reply;

		// 	    client.get('maxBid', function(err1, reply1) {
		// 		    max_bid = reply1;

		// 			client.get('baseBid', function(err2, reply2) {
		// 		    	base_bid = reply;
		// 			});
		// 		});
		// 	});
		// 	res.render('bidding.ejs', {
		// 		currentRound: ,
		// 		group_object: grp_obj,
		// 		team_object: team_obj,
		// 		player_object: player_obj });
		// }


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


