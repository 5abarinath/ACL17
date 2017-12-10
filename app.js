const express = require('express');
const app = express();
const path = require('path');
const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const cors = require('cors');
const server = require('http').createServer(app);
const io = require('socket.io')(server);

// PORT number
const port = 3000;

// Check connection with MySQL database
const connection = require('./config/database');

// Check connection with Redis
const redisClient = require('./config/redis');

// CORS middleware
app.use(cors());

// Set up view engine as ejs
app.set('views', path.join(__dirname, '/views'));
app.set('view engine', 'ejs');

// Set static folder
app.use(express.static(path.join(__dirname + '/public')));

// Body-Parser middleware
app.use(bodyParser.urlencoded({extended:false}));
app.use(bodyParser.json());

// Cookie-parser middleware to handle cookies
app.use(cookieParser());

// Gamemaster - index.html
app.get('/gamemaster', function(req, res) {
	res.sendFile(path.join(__dirname + '/public/Gamemaster' + '/index.html'));
});

// Gamemaster - Bidding Phase
app.post('/gamemaster/control', function(req, res) {
	let sql_round_count = "SELECT COUNT(*) AS no_of_rounds FROM Bidding";
	let sql_group_data = "SELECT group_name, group_desc, base_bid, max_bid FROM Groups WHERE group_id = ?";
	let sql_player_data = "SELECT CONCAT(player_fname, ' ', player_lname) AS player_name, player_image FROM Players WHERE group_id = ?";
	connection.query(sql_round_count, function(err, results) {
		if(err) throw err;

		var round = (results[0].no_of_rounds/6)+1;
		redisClient.set('currentRound', round);

		connection.query(sql_group_data, [round], function(err1, results1) {
			if(err1) throw err1;

			var grp_name = results1[0].group_name;
			var grp_desc = results1[0].group_desc;
			var base_bid = results1[0].base_bid;
			var max_bid = results1[0].max_bid;
x
			redisClient.set('baseBid', base_bid);
			redisClient.set('maxBid', max_bid);

			connection.query(sql_player_data, [round], function(err2, results2) {
				if(err2) throw err2;
				var plyr_obj = results2;

				res.render('master', {
					curRound: round,
					groupName: grp_name,
					groupDesc: grp_desc,
					player_object: plyr_obj });
			});
		});
	});	
});

// Gamemaster - Selection Phase
app.post('/gamemaster/selection', function(req, res) {
	let admin = req.body.token;

	if(admin != "gamemaster")
		res.sendFile(path.join(__dirname + '/public' + '/index.html'));

	res.render('selection');
});

// Login page
app.get('/', function(req, res) {
	res.render('index.ejs', {
		message: 'No msg'
	});
});

// Login form for users
app.post('/authenticate', function(req, res) {
	var user = req.body.teamName;
	var password = req.body.password;

	if((user==1 && password=="ahrsjt117")||(user==2 && password=="cmtvny217")||(user==3 && password=="fmtgkr317")||(user==4 && 				   	password=="mfcjgv417")||(user==5 && password=="pttoyr517")||(user==6 && password=="sstdar617")){
		//Set cookie in client side accessible to client
		res.cookie('teamToken', user, { maxAge: 24 * 60 * 60 * 1000, httpOnly: false});
		res.render('index.ejs', {
			message: 'Successful'
		});
	} else {
		res.render('index.ejs', {
			message: 'Invalid password!'
		});
	}
});

app.post('/initialbids', function(req, res) {
	let teamID = req.cookies.teamToken;

	let sql = "SELECT * FROM Bidders WHERE team_id = ?";
	connection.query(sql, [teamID], function(err, result) {
		if(err) throw err;
		res.render('initialbids',{
					   teamName: result[0].team_name,
					   teamOwner: result[0].team_owner,
					   teamLogo: result[0].team_logo});
	});
});

// POST request to render teamprofile.ejs
app.post('/teamprofile', function(req, res) {
	let teamID = req.cookies.teamToken;

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

		redisClient.zscore('aclTeamRanks', key, function(err1, reply){
			console.log("Team Rank", reply);
			var totalSpent = parseInt(result[0].points_spent) + parseInt(reply);

			redisClient.hgetall("aclteam" + teamID, function(err, object) {
				var teamObject = object;

				res.render('teamprofile', { 
						   teamName: result[0].team_name,
						   teamOwner: result[0].team_owner,
						   teamLogo: result[0].team_logo,
						   pointsSpent: totalSpent,
						   premiumLeft: teamObject.premLeft,
						   data: results });
			});
		});
	});
});

// POST request to populate the bidding.ejs script
app.post('/bidding', function(req, res) {
	let teamID = req.cookies.teamToken;

	teamObject = 0;
	redisClient.hgetall("aclteam" + teamID, function(err, object) {
		teamObject = object;

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

								redisClient.get('maxBid', function(err1, reply1) {
									grp_obj[0].max_bid = parseInt(reply1);
									redisClient.get('baseBid', function(err2, reply2) {
										grp_obj[0].base_bid = parseInt(reply2);
									    team_obj[0].premium_left = parseInt(teamObject.premLeft);
									    teamRank = teamObject.rank;
										yourBid = teamObject.yourBid;
										if(currBid >= grp_obj.max_bid){
											prem_flag = 1;
											res.render('bidding.ejs', {
												currentRound: currRound,
												group_object: grp_obj,
												team_object: team_obj,
												player_object: player_obj,
												current_bid: currBid,
												rank: teamRank,
												your_bid: yourBid,
												premiumFlag: prem_flag });
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
						}
						else {
							res.render('bidding.ejs', {
								currentRound: currRound,
								group_object: grp_obj,
								team_object: team_obj,
								player_object: player_obj,
								current_bid: 0,
								rank: 0,
								your_bid: 0,
								premiumFlag: prem_flag });
						}
					});
				});
			});
		});
	});
});

io.on('connection', function(client) {
	client.on('bidBtnClicked', function(data) {
		redisClient.get('currentBid', function(err, reply) {
			if(err) throw err;
			var currBid = parseInt(reply);
			var team = 'aclteam' + data;
			var btnDisable = false;
			redisClient.get('maxBid', function(err1, reply1) {
				if(err1) throw err1;
				var maxBid = parseInt(reply1);
				if(currBid < maxBid) {
					currBid += 1000;
					console.log("Current Bid: " + currBid);
					redisClient.set('currentBid', currBid);
					redisClient.hgetall(team, function(err5, teamObject) {
						console.log("CurrBid-teamObj.yourBid for " + team + " = " + (currBid - teamObject.yourBid));
						redisClient.zadd('aclTeamRanks', currBid, team);
						redisClient.hset(team, 'yourBid', currBid);
						redisClient.zrevrank('aclTeamRanks', team, function(err3, reply3) {
							if(err3) throw err3;
							redisClient.hset(team, 'rank', parseInt(reply3)+1);
						});
						if(currBid == maxBid)
							btnDisable = true;

						redisClient.zrevrange('aclTeamRanks', 0, currBid, "withscores", function(err2, reply2) {
							if(err2) throw err2;
							var currObject = {"currentBid": currBid, "disableFlag": btnDisable, "ranks": reply2};
							io.sockets.emit('bidBtnClicked', currObject);	
						});
					});
				}
				else {
					btnDisable = true;
					redisClient.zrevrange('aclTeamRanks', 0, currBid, "withscores", function(err2, reply2) {
						if(err2) throw err2;
						var currObject = {"currentBid": currBid, "disableFlag": btnDisable, "ranks": reply2};
						io.sockets.emit('bidBtnClicked', currObject);	
					});
				}
				
			});
		});
	});

	client.on('premiumBidBtnClicked', function(data) {
		redisClient.get('currentBid', function(err, reply) {
			if(err) throw err;
			var currBid = parseInt(reply);
			currBid+=2000
			var team = 'aclteam' + data;
			redisClient.hgetall(team, function(err4, teamObject) {
				if(err4) throw err4;

				redisClient.get('maxBid', function(err2, reply2){
					var teamPrevBid = teamObject.yourBid;
					if(teamPrevBid < replay2){  //reply2 = maxBid
						var premiumCost = currBid - teamObject.yourBid + maxBid - teamObject;

						if(parseInt(teamObject.premium_left) < premiumCost){
							//Premium Transaction Failed.
						}
					}	
				});
				var newPrem = (parseInt(reply4)-2000);
				redisClient.hset(team, 'premLeft', newPrem);
			});
			currBid += 2000;
			redisClient.set('currentBid', currBid);
			redisClient.hset(team, 'yourBid', currBid);
			redisClient.zincrby('aclTeamRanks', currBid, team);
			redisClient.zrevrank('aclTeamRanks', team, function(err3, reply3) {
				if(err3) throw err3;
				redisClient.hset(team, 'rank', (parseInt(reply3)+1));
			});
			redisClient.zrevrange('aclTeamRanks', 0, currBid, "withscores", function(err2, reply2) {
				if(err2) throw err2;
				var currObject = {"currentBid": currBid, "ranks": reply2};
				io.sockets.emit('premiumBidBtnClicked', currObject);	
				console.log(currObject);
			});
		});
	});

	// Gamemaster event to register initial bids
	client.on('login', function(data) {
		let teamID = data.team_id;
		let firstBid = data.initial_amount;

		let key = "aclteam" + teamID;

		redisClient.zadd('aclTeamRanks', firstBid, key);
		redisClient.zrevrange('aclTeamRanks', 0, 1500000, "withscores", function(err, reply) {
			io.sockets.emit('master-ranking', reply);
		});

		redisClient.get('currentBid', function(err, reply) {
			if(parseInt(firstBid) > parseInt(reply)){
				redisClient.set('currentBid', firstBid);
			}
		});

		redisClient.hgetall(key, function(err, teamObject){
			teamObject.yourBid = firstBid;
			redisClient.hmset(key, teamObject);
		});
	});

	client.on('startBidding', function(data) {
		for(var i=1; i<=6; i++){
			key = "aclteam" + i;
			redisClient.hset(key, 'bidFlag', 1);
		}

		client.broadcast.emit('startBidding', 'Enable bid button');
	});

	client.on('stopBidding', function(data) {
		redisClient.set('currentBid', 0);
		for(var i=1; i<=6; i++){
			key = "aclteam" + i;
			redisClient.hset(key, 'bidFlag', 0);
		}
		client.broadcast.emit('stopBidding', 'Disable bidding');
	});
});

// Start server
server.listen(port, () => {
	console.log('Server started on port ' + port);
});
