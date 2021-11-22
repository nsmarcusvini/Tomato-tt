


const express = require('express');
const { ArduinoDataTemp } = require('./newserial');
const db = require('./database')
const router = express.Router();


router.get('/', (request, response, next) => {
    
    
    //let sum = ArduinoDataTemp.List.reduce((a, b) => a + b, 0);
    //let average = (sum / ArduinoDataTemp.List.length).toFixed(2);


    response.json({
        data: ArduinoDataTemp.List,
    });

    response.json(ArduinoDataTemp.List);


});


router.post('/sendData', (request, response) => {

    var umidade  =  ArduinoDataTemp.List[0].data;
    var temperatura_dht11 = ArduinoDataTemp.List[1].data;
    var sql = "INSERT INTO dadoshistoricos (dadosUmidade, dadosTemperatura) VALUES (?, ?)";

    db.query(sql, [umidade[umidade.length - 1], temperatura_dht11[temperatura_dht11.length - 1]] , function(err, result) {
        if (err) throw err;
        console.log("Number of records inserted: " + result.affectedRows);
      });
      
      
    response.sendStatus(200);
})

module.exports = router;