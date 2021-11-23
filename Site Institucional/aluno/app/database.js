var mysql = require('mysql2');
var connection = mysql.createConnection({
    host     : 'cakcio.mysql.database.azure.com',
    port     : '3306',
    user     : 'calciouniverse@cakcio',
    password : 'calcio@123',
    database : 'Calcio'
});

connection.connect(function(err) {
    if (err) throw err;
    console.log('Conectado com sucesso!')
});



module.exports = connection;
