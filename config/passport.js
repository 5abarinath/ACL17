const LocalStrategy = require('passport-local').Strategy;

const mysql = require('mysql');
const crypto = require('crypto');
var connection = require('./database');

// Expose this function to app.js using module.exports
module.exports = function(passport) {
	
	// passport session setup
	// required for persistent login sessions
	// passport needs ability to serialize and deserialize users out of session
	
	// used to serialize users
	passport.serializeUser(function(user, done) {
		done(null, user.id);
	});
	
	// used to deserialize users
	passport.deserializeUser(function(id, done) {
		connection.query("SELECT * FROM Bidders WHERE team_id = ?", [id], function(err, rows) {
			done(err, rows[0]);
		});
	});
	
	// Define local strategy using passport and define the response to the various cases of failed login and successful login attempts
	passport.use(
		'local',
		new LocalStrategy({
			usernameField: 'username',
			passwordField: 'password',
			passReqToCallback: true
		},
		function(req, username, password, done) {
			console.log('Reached passport password authentication');
			var sha1 = crypto.createHash('sha1').update(password).digest('hex');
			connection.query("SELECT * FROM Bidders WHERE team_id = ?", [username], function(err, rows) {
				if(err)
					return done(err);
				if(!rows.length)
					return done(null, false, req.flash('loginMessage', 'Team not found!'));
				if(!(sha1===rows[0].team_pwd))
					return done(null, false, req.flash('loginMessage', 'Oops! Wrong password!'));
				
				return done(null, rows[0]);
			});
		})
	);
};
				
