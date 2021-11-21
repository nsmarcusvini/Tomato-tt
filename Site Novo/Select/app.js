process.env.AMBIENTE_PROCESSO = "desenvolvimento";

var express = require("express");
var cors = require("cors");
var path = require("path");
var PORTA = 3232;

var app = express();

var indexRouter = require("./src/routes/index");
var medidasRouter = require("./src/routes/medidas");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/medidas", medidasRouter)

app.listen(PORTA, function() {
    console.log(`Servidor Rodando! Porta: ${PORTA}`);
});

