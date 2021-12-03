-- Criando o Banco de Dados tomatopi --
create database tomatopi;

 -- drop database tomatopi;

-- Selecionando Banco de Dados tomatopi --
use tomatopi;

-- Criando Tabela Cadastro, com os campos: idCliente, nome, email, senha, usuário e cnpj --
create table cadastro (
idCliente int primary key auto_increment,
nome varchar (45),
email varchar (45),
senha varchar (40),
usuario varchar(20),
cnpj varchar (13)
);

select *from cadastro;

-- Criando Tabela Usuários, com os campos: idUsuario, nome, email, senha, cnpj e fkCadastro --
create table usuario (
idUsuario int primary key auto_increment,
nome varchar (45),
email varchar (45),
senha varchar (40),
cnpj varchar (13),
fkCadastro int,
foreign key (fkCadastro) references cadastro (idCliente)
);

-- Inserindo dados na tabela usuário --
insert into usuario (nome,email,senha,cnpj,fkCadastro) values
('Bruno Tavares','Piracicaba-SP','bat.95','1234567890',1),
('Marcus Vinicius','Sumaré','marcusvini','1010101010',2),
('Breno Padovani','Itu','bpadovani','2020202020',3),
('Igor Quintanilha','São Paulo','igorqin','3030303030',4),
('Juliana Ju','São Carlos','ju2021','4040404040',5),
('Kamila Santos','Pirassununga','kami12','5050505050',6);

-- Criando Tabela Fazenda, com os campos: idFazenda, tipoSolo, tipoTomate, tamanhoFazenda,dtConsumo e consumoAgua --
create table fazenda (
idFazenda int primary key auto_increment,
tipoSolo varchar (45),
tipoTomate varchar (45),
tamanhoFazenda varchar (45),
dtConsumo datetime default current_timestamp,
consumoAgua varchar (100),
fkCadastro int,
foreign key (fkCadastro) references cadastro(idCliente)
) auto_increment = 500;

-- Inserindo dados na tabela fazenda -- 
insert into fazenda (tipoSolo,tipoTomate,tamanhoFazenda,consumoAgua,fkCadastro) values
('fertil','italiano','100hectares','2.5',1),
('fertil','italiano','120hectares','2',2),
('fertil','cereja','200hectares','2',3), 
('fertil','debora','150hectares','1.9',4), 
('fertil','holandês','97hectares','2.2',5), 
('fertil','carmen','99hectares','2.5',6);

-- TESTE
-- Criando Tabela Acesso, com os campos: idAcesso, data, fkUsuario e fkFazenda --
create table acesso (
idAcesso int primary key,
dtAcesso datetime,
fkUsuario int,
foreign key (fkUsuario) references acesso (idAcesso),
fkFazenda int,
foreign key (fkFazenda) references acesso (idAcesso)
); 
-- 

-- Criando Tabela Dados Históricos, com os campos: idDados, dtDados, dadosUmidade, dadosTemperatura, dadosLuminosidade, dadosTempLM e fkFazenda --
create table dadoshistoricos (
idDados int primary key auto_increment,
dtDados datetime default current_timestamp,
dadosUmidade float,
dadosTemperatura float,
dadosLuminosidade float,
dadosTempLM float,
fkFazenda int
) auto_increment = 200;
select * from dadoshistoricos;

-- Criando Tabela Sensor, com os campos: idSensor, descricao, localSensor, fkFazenda -- 
create table sensor (
idSensor int primary key auto_increment,
descricao varchar(45),
localSensor varchar (45),
statusSensor varchar (45),
check (statusSensor = 'ativo' or statusSensor = 'inativo'
                              or statusSensor = 'manutenção'),
fkFazenda int,
foreign key (fkFazenda) references fazenda (idFazenda)
) auto_increment = 1000;

-- Inserindo dados na tabela sensor --
insert into sensor(descricao,localSensor,statusSensor,fkFazenda) values
('S1','leste','ativo',500),
('S2','sul','ativo',501),
('S3','norte','ativo',502),
('S4','oeste','ativo',503),
('S5','centro','ativo',504),
('S6','centro','ativo',505);

-- Exibindo os dados das tabelas separadamente --
select * from cadastro;
select * from usuario;
select * from fazenda;
select * from sensor;
select * from dadoshistoricos;
select * from acesso;

-- Exibir todos os campos e todos os dados da tabela usuario, cadastro --
select * from usuario join cadastro on idCliente = fkCadastro;

select * from usuario join cadastro on cadastro.idCliente = usuario.fkCadastro
	join fazenda on fazenda.fkCadastro = idCliente;
                      
-- Exibindo os principais dados de um determinado cliente --                      
select usuario.nome as 'Nome do Usuário',
       cadastro.nome as 'Nome da Empresa',
       fazenda.tipoTomate as 'Tipo de Tomate',
       sensor.descricao as 'Descrição do Sensor',
       sensor.statusSensor as 'Status',
       dadoshistoricos.dadosUmidade as 'Umidade',
       dadoshistoricos.dadosTemperatura as 'Temperatura'
       from cadastro join usuario on cadastro.idCliente = usuario.fkCadastro
                     join fazenda on cadastro.idCliente = fazenda.fkCadastro
                     join dadoshistoricos on fazenda.idFazenda = dadoshistoricos.fkFazenda
                     join sensor on fazenda.idFazenda =  sensor.fkFazenda
                     where usuario.idUsuario = 3;
                     
-- Exibindo os dados do cliente e os sensores de temperatura e umidade DHT11 --                              
select usuario.nome as 'Usuário',
       cadastro.nome as 'Nome da Empresa', 
       fazenda.tipoTomate as 'Tipo de Tomate',
       sensor.descricao as 'Sensor',
	   dadoshistoricos.dadosUmidade as 'Umidade', 
       dadoshistoricos.dadosTemperatura as 'Temperatura',
       dadoshistoricos.dtDados as 'Data e Hora da medição'
       from cadastro join usuario on cadastro.idCliente = usuario.fkCadastro
			  join fazenda on cadastro.idCliente = fazenda.fkCadastro
              join dadoshistoricos on fazenda.idFazenda = dadoshistoricos.fkFazenda
              join sensor on fazenda.idFazenda =  sensor.fkFazenda
              where usuario.idUsuario = 1;
 
-- Exibindo os dados do cliente e todos os tipos de sensores disponíveis --
select usuario.nome as 'Usuário',
       cadastro.nome as 'Nome da Empresa', 
       fazenda.tipoTomate as 'Tipo de Tomate',
       sensor.descricao as 'Sensor',
	   dadoshistoricos.dadosUmidade as 'Sensor de Umidade', 
       dadoshistoricos.dadosTemperatura as 'Sensor de Temperatura',
	   dadoshistoricos.dadosLuminosidade as 'Sensor de Luminosidade',
	   dadoshistoricos.dadosTempLM as 'Sensor LM35 - Temperatura',
       dadoshistoricos.dtDados as 'Data e Hora da medição'
       from cadastro join usuario on cadastro.idCliente = usuario.fkCadastro
			  join fazenda on cadastro.idCliente = fazenda.fkCadastro
              join dadoshistoricos on fazenda.idFazenda = dadoshistoricos.fkFazenda
              join sensor on fazenda.idFazenda =  sensor.fkFazenda
              where usuario.idUsuario = 1;