var express = require('express'), app = express.createServer();

var conect = 0;
var port = 8080;

var data ={
	 "sefford" : {
		name   : "Sefford",
		mail   : "sefford@gmail.com",
		level  : 85,
		thropy : ['Androide Cinéfilo', 'Java Developer'],
		image : 'http://2.gravatar.com/avatar/20288f4d2ef35e3488bb032328ec9733?size=420'
	},"alexdev_":{
		name : "Blood Elf Paladin",
		mail : "alejandroperezpaya@gmail.com",
		level : 85,
		thropy : ['Root User', 'NodeJS'],
		image : 'http://static.desktopnexus.com/thumbnails/92461-bigthumbnail.jpg'
	},"alexrs95": {
		name : 'Alexrs95',
		mail : 'alexrs95@gmail.com',
		level : 85,
		thropy : ['Cubo de Rubik en 1.25 minutos', 'Androide Viajero'],
		image : 'http://1.gravatar.com/userimage/32454316/d2d9123ec121b105de3564806eca18db?size=420'
	}, "michaelfields" : {
		name : "Miguel Campos (N00B)",
		mail : "gafeman@gmail.com",
		level : 1,
		thropy : ['Programador N00B'],
		image : 'http://2.gravatar.com/avatar/c659399ef74f0c3b18c40cb04bd6c596?size=420'
	}
};

app.configure(function (){
	app.use(express.static(__dirname + '/static'));
    app.use(express.methodOverride());
    app.use(express.bodyParser());
    app.use(app.router);
	app.set('view options', {
		layout: true
	});
});

app.configure('development', function (){
    app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.set('views', __dirname+'/views');
app.set('views');

app.get('/api/:name', function (req, res){
if (req.params.name == 'michaelfields' || 'alexrs95' || 'alexdev_' || 'sefford'){
	res.send(data[req.params.name]);
} else {
	res.send('The user is not registered');
}
});

app.get('/', function (req, res){
	res.render('index.jade');
});

app.post('/', function (req, res){
	var user = req.body.user;
	res.redirect('/profile/'+ user);
});

app.post('/add', function (){
	var user = req.body.user;
	var thropy = req.body.thropy;
	data[user].thropy.push(thropy);
});

app.get('/profile/:name', function (req, res){
	var datos = data[req.params.name];
	if(datos == null){
		res.render('not.jade');		
	} else{
		res.render('user.jade', datos);
	}
	// res.render('user.jade', {avatar: url});
});

app.listen(port, function (){
	console.log('Up and Running on port:' + port);
});