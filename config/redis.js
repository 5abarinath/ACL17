const redis = require('redis');

// Create connection with Redis database
const redisClient = redis.createClient();

// Check connection with Redis
redisClient.on('connect', function() {
	console.log('Redis Connected');
	redisClient.set('currentBid', 0);
	redisClient.set('currentRound', 1);
	
	redisClient.set('baseBid', 0);
	redisClient.set('maxBid', 0);
    
    // Creating the key-value storage for all six teams
	for(var i=1; i<=6; i++){
		key = "aclteam" + i;
		redisClient.hmset(key, {
		    'bidFlag': 0,
		    'rank': 0,
		    'premLeft': 150000,
		    'yourBid': 0
		});
		redisClient.zadd('aclTeamRanks', 0, key);
	} 
});
redisClient.on('error', function(){
	console.log('Could not connect to Redis');
});
module.exports = redisClient;