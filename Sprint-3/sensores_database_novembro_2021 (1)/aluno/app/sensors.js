function lm35(min, max) {
  min = typeof min == "undefined" ? 18 : min;
  max = typeof max == "undefined" ? 25 : max;

  let random = Math.random() * (max - min) + min;

  return random;
}

function trc5000() {
  min = 0;
  max = 1;

  let random = Math.random() * (max - min) + min;

  if (random >= 0.7) {
    return 1;
  } else if (random <= 0.7) {
    return 0;
  }
}

function ldr() {
  min = 0;
  max = 1023;

  let random = Math.floor(Math.random() * (max - min + 1) + min);

  return random;
}

function dht11(options) {
  minHumidity = options.minHum;
  maxHumidity = options.maxHum;

 

  if (minHumidity < 20 || maxHumidity > 100) {
    throw new Error(
      "Os valores minímos e máximos para umidade são 20% e 100% respectivamente."
    );
  }


  

  minHumidity = typeof minHumidity == "undefined" ? 20 : minHumidity;
  maxHumidity = typeof maxHumidity == "undefined" ? 80 : maxHumidity;

  let randomHumidity = Math.floor(
    Math.random() * (maxHumidity - minHumidity + 1) + minHumidity
  );

  

  return randomHumidity;
}

module.exports = { lm35, trc5000, ldr, dht11 };
