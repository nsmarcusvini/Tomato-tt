const sensors = require('./sensors')
const SerialPort = require("serialport");
const Readline = SerialPort.parsers.Readline;

class ArduinoRead {

    constructor() {
        this.listData = [];
        this.__listDataTemp = [];
    }

    get List() {
        return this.listData;
    }


    fake_data() {
        setInterval(() => {
            let dht11 = sensors.dht11();

            if (this.listData.length === 59) {
                let sum = this.listData.reduce((a, b) => a + b);
                this.listDataHour.push((sum / this.listData.length).toFixed(2));
                while (this.listData.length > 0) {
                    this.listData.pop();
                }
            }
            this.listData.push(dht11);
        }, 2000);
    }


    SetConnection() {

        SerialPort.list().then(listSerialDevices => {

            let listArduinoSerial = listSerialDevices.filter(serialDevice => {
                return serialDevice.vendorId == 2341 && serialDevice.productId == 43;
            });

            if (listArduinoSerial.length != 1) {
                this.fake_data();
                console.log("Arduino not found - Generating data");
            } else {
                console.log("Arduino found in the com %s", listArduinoSerial[0].comName);
                return listArduinoSerial[0].comName;
            }
        }).then(comName => {
            try {
                let arduino = new SerialPort(comName, { baudRate: 9600 });

                const parser = new Readline();
                arduino.pipe(parser);
                arduino.on('close', () => {
                    console.log('Lost Connection');
                    this.fake_data();
                });
                parser.on('data', (data) => {
                    data = data.split(" ");
                    console.log('DHT11 - Temperatura: ' + data[1]);
                    console.log('DHT11 - Umidade: ' + data[0]);
                    this.listData.push(data);
                });
            } catch (e) {
                this.fake_data();
            }

        }).catch(error => console.log(error));
    }
}

const serial = new ArduinoRead();
serial.SetConnection();

module.exports.ArduinoDataTemp = { List: serial.List }