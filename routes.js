module.exports = function(app, passport) {
	
	// Render index.ejs file for login
	app.get('/', function(req, res) {
		res.render('index.ejs', { message: req.flash('loginMessage') });
	});
	
	// Receive POST request from login page and use passport to authenticate
	app.post('/authenticate', passport.authenticate('local', {
		successRedirect: '/teamprofile',
		failureRedirect: '/',
		failureFlash: true
		}),
		function(req, res) {
			console.log('Reached here');	
			req.session.cookie.maxAge = 1000 * 60 * 3;
			req.session.cookie.expires = false;
		});
	
	// Render teamprofile.ejs after login and check if user session is authenticated using isLoggedIn middleware
	app.get('/teamprofile', isLoggedIn, function(req, res) {
		res.render('teamprofile.ejs', {
			user: req.user
		});
	});
};	
	
// middleware function to make sure user is logged in
function isLoggedIn(req, res, next) {
		
	// if user is authenticated in session, carry on task
	if(req.isAuthenticated())
		return next();
		
	// If not, redirect them to login page
	res.redirect('/');
}

