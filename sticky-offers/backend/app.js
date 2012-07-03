var express = require('express'), 
    routes = require('./routes');

var app = module.exports = express.createServer();
var qrcodeservice = require('./qrcodeservice');
var cryptoservice = require('./cryptoservice');

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

var title = 'Crear nuevo descuento';
var discounts = [];

var renderIndex = function(res){
  res.render('index', {
    title: title,
    discounts: discounts,
  });
}

app.get('/', function(req, res){
  renderIndex(res);
});

app.post('/claim', function(req, res){
  var discountcode = cryptoservice.decipher(req.body.token);
  res.json({'discountCode': discountcode});
});

app.post('/newdiscount', function(req, res){
  discounts.push(req.body.newdiscount);
  renderIndex(res);
});

app.get('/showdiscount/:discountname', function(req, res){
  qrcodeservice.getqrcodeimage(cryptoservice.cipher(req.params.discountname), function(image){
    res.send(image);
  });
});

app.listen(8080, function(){
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});