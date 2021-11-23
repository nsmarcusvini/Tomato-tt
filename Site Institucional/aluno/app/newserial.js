const sensors = require('./sensors')
const SerialPort = require("serialport");
const Readline = SerialPort.parsers.Readline;

class ArduinoRead {

    constructor() {
        this.listData = [
            {
            'name': 'Umidade',
            'data': [],
            'total': 0,
            "average": 0
            },
            {
            'name': 'Temperatura',
            'data': [],
            'total': 0,
            "average": 0
            }];
        this.__listDataTemp = [];
    }


    get List() {
        return this.listData;
        
    }

    fake_data() {
        setInterval(() => {
            let dht11 = sensors.dht11(20, 80, 0, 50);

            if (this.listData.length === 59) {
                while (this.listData.length > 0) {
                    this.listData.pop();
                } 
            }
            let temp = dht11;
            if (temp.length === this.listData.length){
                temp.map((item, index)=>{
                    console.log('Leitura - ' + this.listData[index].name + ': ' + item);
                    this.listData[index].data.push(parseInt(item))
                })
            }
            
            
        }, 1000);
    }


    SetConnection() {
        SerialPort.list().then(listSerialDevices => {
            console.log(listSerialDevices)
            let listArduinoSerial = listSerialDevices.filter(serialDevice => {
                return serialDevice.vendorId == 2341 && serialDevice.productId == 43;
            });

            if (listArduinoSerial.length != 1) {
                console.log("Arduino not found - Generating data");
                this.fake_data();
            } else {
                console.log("Arduino found in the com %s", listArduinoSerial[0].path);
                return listArduinoSerial[0].path;
            }
        }).then(path => {
            try {
                let arduino = new SerialPort(path, { baudRate: 9600 });

                const parser = new Readline();
                arduino.pipe(parser);
                arduino.on('close',() => {
                    console.log('Lost Connection');
                    this.fake_data();
                });
                parser.on('data', (data) => {
                    console.log(data)
                    let temp = data.replace(/\r/g,'').split(';');
                    if (temp.length === this.listData.length){
                        temp.map((item, index)=>{
                            console.log('Leitura - ' + this.listData[index].name + ': ' + item);
                            this.listData[index].data.push(parseInt(item))
                        })
                    }
                    //this.listData.push(parseFloat(data));
                });
            } catch (e) {
            }

        }).catch(error => console.log(error));
    }

}

const serial = new ArduinoRead();
serial.SetConnection();


module.exports.ArduinoDataTemp = { List: serial.List};
