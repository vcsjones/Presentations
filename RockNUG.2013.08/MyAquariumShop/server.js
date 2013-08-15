var http = require('http');
var express = require('express');
var less = require('less');
var lessMiddleware = require('less-middleware');
var port = process.env.PORT || 8080;
var app = express();
app.configure(function() {
	app.set('views', __dirname + '/views');
	app.set('view engine', 'jade');
	app.use(lessMiddleware({src: __dirname + '/public'}));
	app.use(express.static(__dirname + '/public'));
	app.use(express.methodOverride());
	app.use(app.router);
});

app.get('*', function(req, res, s, next) {
	next();
});

app.get('/', function(req, res) {
	res.render('index', {
		'title': 'Home'
	});
});

app.get('/cat', function(req, res) {
	res.render('about', {
		'title': 'About'
	});
});

app.get('/services/getUser/:id', function(req, res) {
	res.setHeader('Content-Type', 'application/json');
	res.send(JSON.stringify({"name": "kevin jones", "id":  req.params.id}));
});

app.listen(port);