var mysql = require('mysql2');
var connection = mysql.createConnection({
    host     : '127.0.0.1',
    port     : '3306',
    user     : 'root',
    password : 'bandtec',
    database : 'tomatopi'
});

connection.connect(function(err) {
    if (err) throw err;
    console.log('Conectado com sucesso!')
});



module.exports = connection;
