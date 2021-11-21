var database = require("../database/config");



function listar() {
    var instrucao = `
        SELECT * FROM dadoshistoricos;
    `; 
    console.log("Executando a instrução SQL: \n"+instrucao);
    return database.executar(instrucao);
}
module.exports = {
    listar
}