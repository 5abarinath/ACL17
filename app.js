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
		res.sendFile(path.join(__dirname + '/public/Gamemaster' + '/index.html'));
	let groupID = redisClient.get('currentRound');
	let sql_player_data = "SELECT CONCAT(player_fname, ' ', player_lname) AS player_name, player_image, player_id FROM Players WHERE group_id = ?";
	connection.query(sql_player_data,[groupID],function(err,result){
		if(err) throw err;
		var player_object = result;
		res.render('selection', {
			player_obj:player_object
		});
	});
});


//Assigning Players after the Slot is Over, and Submit is clicked
app.post('/gamemaster/assignPlayers', function(req,res){
	var firstPlayerID = req.body.player1;
	var firstPlayerTeam = req.body.selectionOne;
	var secondPlayerID = req.body.player2;
	var secondPlayerTeam = req.body.selectionTwo;
	var thirdPlayerID = req.body.player3;
	var thirdPlayerTeam = req.body.selectionThree;
	var fourthPlayerID = req.body.player4;
	var fourthPlayerTeam = req.body.selectionFour;
	var fifthPlayerID = req.body.player5;
	var fifthPlayerTeam = req.body.selectionFive;
	var sixthPlayerID = req.body.player6;
	var sixthPlayerTeam = req.body.selectionSix;

	//Adding Players to their respective Teams
	let sql_player_assign = "UPDATE Players SET team_id = ? WHERE player_id = ?";
	connection.query(sql_player_assign,[firstPlayerTeam,firstPlayerID],function(err, result) {});
	connection.query(sql_player_assign,[secondPlayerTeam,secondPlayerID],function(err, result) {});
	connection.query(sql_player_assign,[thirdPlayerTeam,thirdPlayerID],function(err, result) {});
	connection.query(sql_player_assign,[fourthPlayerTeam,fourthPlayerID],function(err, result) {});
	connection.query(sql_player_assign,[fifthPlayerTeam,fifthPlayerID],function(err, result) {});
	connection.query(sql_player_assign,[sixthPlayerTeam,sixthPlayerID],function(err, result) {});

	//Updating Players with the prices.

	redisClient.get('currentRound', function(err20, groupIdResp) {
		let playerArray = [firstPlayerID, secondPlayerID, thirdPlayerID, fourthPlayerID, fifthPlayerID, sixthPlayerID];
		redisClient.hget("aclteam1", 'yourBid', function(err,result){
			if(err) throw err;
			let sql_player_price = "UPDATE Players SET price = ? WHERE player_id = ?";
			connection.query(sql_player_price,[result,playerArray[0]],function(err1,result1){
				if(err1)throw err1;
			});
			let sql_bidding_entry = "INSERT INTO Bidding(team_id, bid_price, group_id) VALUES(?, ?, ?)";
			connection.query(sql_bidding_entry, ["1", result, groupIdResp], function(errr, respp){});
		});
		redisClient.hget("aclteam2", 'yourBid', function(err,result){
			if(err) throw err;
			let sql_player_price = "UPDATE Players SET price = ? WHERE player_id = ?";
			connection.query(sql_player_price,[result,playerArray[1]],function(err1,result1){
				if(err1)throw err1;
			});
			let sql_bidding_entry = "INSERT INTO Bidding(team_id, bid_price, group_id) VALUES(?, ?, ?)";
			connection.query(sql_bidding_entry, ["2", result, groupIdResp], function(errr, respp){});
		});
		redisClient.hget("aclteam3", 'yourBid', function(err,result){
			if(err) throw err;
			let sql_player_price = "UPDATE Players SET price = ? WHERE player_id = ?";
			connection.query(sql_player_price,[result,playerArray[2]],function(err1,result1){
				if(err1)throw err1;
			});
			let sql_bidding_entry = "INSERT INTO Bidding(team_id, bid_price, group_id) VALUES(?, ?, ?)";
			connection.query(sql_bidding_entry, ["3", result, groupIdResp], function(errr, respp){});
		});
		redisClient.hget("aclteam4", 'yourBid', function(err,result){
			if(err) throw err;
			let sql_player_price = "UPDATE Players SET price = ? WHERE player_id = ?";
			connection.query(sql_player_price,[result,playerArray[3]],function(err1,result1){
				if(err1)throw err1;
			});
			let sql_bidding_entry = "INSERT INTO Bidding(team_id, bid_price, group_id) VALUES(?, ?, ?)";
			connection.query(sql_bidding_entry, ["4", result, groupIdResp], function(errr, respp){});
		});
		redisClient.hget("aclteam5", 'yourBid', function(err,result){
			if(err) throw err;
			let sql_player_price = "UPDATE Players SET price = ? WHERE player_id = ?";
			connection.query(sql_player_price,[result,playerArray[4]],function(err1,result1){
				if(err1)throw err1;
			});
			let sql_bidding_entry = "INSERT INTO Bidding(team_id, bid_price, group_id) VALUES(?, ?, ?)";
			connection.query(sql_bidding_entry, ["5", result, groupIdResp], function(errr, respp){});
		});
		redisClient.hget("aclteam6", 'yourBid', function(err,result){
			if(err) throw err;
			let sql_player_price = "UPDATE Players SET price = ? WHERE player_id = ?";
			connection.query(sql_player_price,[result,playerArray[5]],function(err1,result1){
				if(err1)throw err1;
			});
			let sql_bidding_entry = "INSERT INTO Bidding(team_id, bid_price, group_id) VALUES(?, ?, ?)";
			connection.query(sql_bidding_entry, ["6", result, groupIdResp], function(errr, respp){});
		});
	});

	res.redirect(307, '/gamemaster/control');
});


//Game Master - Summary Page
app.post('/gamemaster/teamsummary',function(req,res){
	let sql_team_members = "SELECT CONCAT(player_fname, ' ', player_lname) AS player_name, player_image, player_id FROM Players WHERE team_id = ?";
	var team1,team2,team3,team4,team5,team6
	//For Aman Honda
	connection.query(sql_team_members,['1'],function(err1,result1){
		if(err1)throw err1;
		var player_object1 = result1;
		//For Ceratec Masters
		connection.query(sql_team_members,['2'],function(err2,result2){
			if(err2)throw err2;
			var player_object2 = result2;
			//For Fitness Mantras
			connection.query(sql_team_members,['3'],function(err3,result3){
				if(err3)throw err3;
				var player_object3 = result3;
				//For Maha Fast Champs
				connection.query(sql_team_members,['4'],function(err4,result4){
					if(err4)throw err4;
					var player_object4 = result4;
					//For Premier Titans
					connection.query(sql_team_members,['5'],function(err5,result5){
						if(err5)throw err5;
						var player_object5 = result5;
						//For Sun Shiners
						connection.query(sql_team_members,['6'],function(err6,result6){
							if(err6)throw err6;
							var player_object6 = result6;
							res.render('teamsummary.ejs', {
								player_obj_1:player_object1,
								player_obj_2:player_object2,
								player_obj_3:player_object3,
								player_obj_4:player_object4,
								player_obj_5:player_object5,
								player_obj_6:player_object6
							});
						});
					});
				});
			});
		});
	});
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

	if((user==1 && password=="ahrsjt117")||(user==2 && password=="cmtvny217")||(user==3 && password=="fmtgkr317")||(user==4 && password=="mfcjgv417")||(user==5 && password=="pttoyr517")||(user==6 && password=="sstdar617")){
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

										redisClient.zrevrange('aclTeamRanks', 0, 1500000, "withscores", function(err3, reply3) {
											if(err3) throw err3;

											if(currBid >= grp_obj[0].max_bid){
												prem_flag = 1;
												res.render('bidding.ejs', {
													currentRound: currRound,
													group_object: grp_obj,
													team_object: team_obj,
													player_object: player_obj,
													current_bid: currBid,
													rank: teamRank,
													your_bid: yourBid,
													teamRankings: reply3,
													premiumFlag: prem_flag
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
												teamRankings: reply3,
												premiumFlag: prem_flag 
											});
										});
									});
								});
							});
						}
						else {
							redisClient.zrevrange('aclTeamRanks', 0, 15000000, "withscores", function(err4, reply4) {
								res.render('bidding.ejs', {
									currentRound: currRound,
									group_object: grp_obj,
									team_object: team_obj,
									player_object: player_obj,
									current_bid: 0,
									rank: 0,
									your_bid: 0,
									teamRankings: reply4,
									premiumFlag: prem_flag });
							});
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
		var flagBeingSentFromPremiumBtnOnClick = data.flag;
		var team = 'aclteam' + data.teamId;
		redisClient.get('currentBid', function(err, reply) {
			if(err) throw err;
			var currBid = parseInt(reply);
			currBid+=2000;
			redisClient.hgetall(team, function(err4, teamObject) {
				if(err4) throw err4;

				redisClient.get('maxBid', function(err2, maxBidForCurrRound){
					var teamPrevBid = teamObject.yourBid;

					if(flagBeingSentFromPremiumBtnOnClick == 0){
						//previous team bid < max bid. premiumSpent = HTMLCurrBid - HTMLMaxBid + 2000;
						var premiumSpent = currBid - parseInt(maxBidForCurrRound);
						var newPremium = teamObject.premium_left - premiumSpent;
						redisClient.hset(team, 'premLeft', newPremium);
					}
					else if(flagBeingSentFromPremiumBtnOnClick == 1){
						//team is already in premium. premiumSpent = HTMLCurrBid - HTMLTeamPrevBid + 2000;
						var premiumSpent = currBid - teamPrevBid; 
						var newPremium = teamObject.premium_left - premiumSpent;
						redisClient.hset(team, 'premLeft', newPremium);	
						//client.emit('updatePremiumValue', newPremium);
					}
				});
			});
			redisClient.set('currentBid', currBid);
			redisClient.hset(team, 'yourBid', currBid);
			redisClient.zadd('aclTeamRanks', currBid, team);
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

		console.log('TAG:VISHVA after login socket' + firstBid);

		let key = "aclteam" + teamID;

		redisClient.zadd('aclTeamRanks', firstBid, key);
		redisClient.zrevrange('aclTeamRanks', 0, 1500000, "withscores", function(err, reply) {
			io.sockets.emit('master-ranking', reply);
		});

		redisClient.hset(key, 'yourBid', firstBid);

		redisClient.get('currentBid', function(err, reply) {
			if(parseInt(firstBid) > parseInt(reply)){
				redisClient.set('currentBid', firstBid);
			}
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
