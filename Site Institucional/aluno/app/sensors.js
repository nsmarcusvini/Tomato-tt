
function dht11(minHumidity, maxHumidity, minTemperature, maxTemperature) {

  if (minHumidity < 20 || maxHumidity > 80) {
    throw new Error(
      "Os valores minímos e máximos para umidade são 20% e 80% respectivamente."
    );
  }

  if (minTemperature < 0 || maxTemperature > 50) {
    throw new Error(
      "Os valores minímos e máximos para temperatura são 0 e 50 respectivamente."
    );
  }

  minTemperature = typeof minTemperature == "undefined" ? 0 : minTemperature;
  maxTemperature = typeof maxTemperature == "undefined" ? 50 : maxTemperature;

  minHumidity = typeof minHumidity == "undefined" ? 20 : minHumidity;
  maxHumidity = typeof maxHumidity == "undefined" ? 80 : maxHumidity;

  let randomHumidity = Math.floor(
    Math.random() * (maxHumidity - minHumidity + 1) + minHumidity
  );

  let randomTemperature = Math.floor(
    Math.random() * (maxTemperature - minTemperature) + minTemperature);

  return [randomHumidity, randomTemperature];
}

 

 
module.exports = {dht11};
