const express = require('express');
const { ArduinoDataTemp } = require('./newserial');
const db = require('./database')
const router = express.Router();


router.get('/', (request, response, next) => {
    
    ArduinoDataTemp.List.map((item)=>{
        let sum = item.data.reduce((a, b) => a + b, 0);
        let average = (sum / item.data.length).toFixed(2);
        item.total = item.data.length;
        item.average = isNaN(average) ? 0 : average
    })
    
    //let sum = ArduinoDataTemp.List.reduce((a, b) => a + b, 0);
    //let average = (sum / ArduinoDataTemp.List.length).toFixed(2);


    /*response.json({
        data: ArduinoDataTemp.List,
        total: ArduinoDataTemp.List.length,
        average: isNaN(average) ? 0 : average,
    });*/

    response.json(ArduinoDataTemp.List);


});

router.post('/sendData', (request, response) => {

    var umidade  =  ArduinoDataTemp.List[0].data;
    var temperatura_dht11 = ArduinoDataTemp.List[1].data;
    var luminosidade = ArduinoDataTemp.List[2].data;
    var temperatura_lm35 = ArduinoDataTemp.List[3].data;

    var sql = "INSERT INTO medidas (umidade, temperatura_dht11, luminosidade, temperatura_lm35) VALUES (?, ?, ?, ?)";

    db.query(sql, [umidade[0], temperatura_dht11[0], luminosidade[0], temperatura_lm35[0]] , function(err, result) {
        if (err) throw err;
        console.log("Number of records inserted: " + result.affectedRows);
      });
      
    
    response.sendStatus(200);
})

module.exports = router;