// Docker redis - docker run -d -p 6379:6379 --name redis1 redis
// docker stop redis1
const redis = require('redis');
const constants = require('./constants')

// Create connection with Redis database
const redisClient = redis.createClient({
	host: constants.REDIS_HOST,
	port: constants.REDIS_PORT,
});

// Check connection with Redis
redisClient.on('connect', function() {
	console.log('Redis Connected');
	redisClient.set('currentBid', 0);
	redisClient.set('currentRound', 1);
	
	redisClient.set('baseBid', 0);
	redisClient.set('maxBid', 0);
    
    // Creating the key-value storage for all six teams
	for(let i = 1; i <= constants.TOTAL_TEAMS; i++){
		key = "aclteam" + i;
		redisClient.hmset(key, {
		    'bidFlag': 0,
		    'rank': 0,
		    'premLeft': constants.INITIAL_PREMIUM,
		    'yourBid': 0
		});
		redisClient.zadd('aclTeamRanks', 0, key);
	} 
});
redisClient.on('error', function(){
	console.log('Could not connect to Redis');
});
module.exports = redisClient;