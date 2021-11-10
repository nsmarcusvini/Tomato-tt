var mysql = require('mysql');

var connection = mysql.createConnection({
    host     : 'localhost',
    port     : '3306',
    user     : 'root',
    password : '1234',
<<<<<<< HEAD
    database : 'Sensor'
=======
    database : 'sprint2'
>>>>>>> 093ca9d35de2d54cec1488125097aa199267ddff
});

connection.connect(function(err) {
    if (err) throw err;
    console.log('Conectado ao BD com sucesso!')
});



module.exports = connection;