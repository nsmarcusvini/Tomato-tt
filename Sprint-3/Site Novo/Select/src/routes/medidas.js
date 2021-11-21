var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/listar", function(req, res) {
    medidaController.listar(req, res);
});

module.exports = router;