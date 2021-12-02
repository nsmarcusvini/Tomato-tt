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

-- Criando Tabela Usuários, com os campos: idUsuario, nome, cidade, usuário, senha e fkCadastro --
create table usuario (
idUsuario int primary key auto_increment,
nome varchar (45),
email varchar (45),
senha varchar (40),
cnpj varchar (13),
fkCadastro int,
foreign key (fkCadastro) references cadastro (idCliente)
);

-- Inserindo dados na tabela cadastro --
insert into cadastro(nomeEmpresa,CNPJ,emailEmpresa,telComercial,telCelular) values
('Benedita e Bernardo Alimentos ME','08.700.284/0001-30','producao@beneditaebernardoalimentosme.com.br','(11) 3550-1448','(11) 98765-5432'),
('Nelson e Vicente Alimentos ME','00.128.259/0001-12','orcamento@nelsonevicentealimentosme.com.br','(19) 2724-3293','(11) 98765-1111'),
('Fazendas Brandão','09.432.725/0001-23','administracao@vanessaecarlaadegame.com.br','(11) 2881-4840','(11) 98765-2222'),
('MARFRIG GLOBAL FOODS','24.024.735/0001-13','marfrig@foodstomate.com.br','(19) 3552-3206','(11) 98765-5555'),
('BUNGE ALIMENTOS','39.299.885/0001-07','bunge@alimentos.com.br','(19) 2839-6786','(11) 98765-5454'),	
('Fazenda do Cultivo','81.518.290/0001-61','fazenda.cultivo@bandtec.com.br','(11) 3767-5067','(11) 98765-0000');

-- Inserindo dados na tabela usuário --
insert into usuario (nomeUsuario,cidade,usuario,senha,fkCadastro) values
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

-- Criando Tabela Dados Históricos, com os campos: idDados, data, dadosUmidade, dadosTemperatura e fkSensor --
create table dadoshistoricos (
idDados int primary key auto_increment,
dtDados datetime default current_timestamp,
dadosUmidade float,
dadosTemperatura float,
fkFazenda int
) auto_increment = 200;
select * from dadoshistoricos;
-- Inserindo os dados na tabela dados historicos --
insert into dadoshistoricos (dadosUmidade,dadosTemperatura,fkFazenda)values
('70%','25ºC',500),
('72%','23ºC',501),
('67%','18ºC',502),
('65%','16ºC',503),
('75%','20ºC',504),
('80%','23ºC',505);

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
select usuario.nomeUsuario as 'Nome do Usuário',
       usuario.cidade as 'Cidade',
       cadastro.nomeEmpresa as 'Nome da Empresa',
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
                     
-- Exibindo                                  
select usuario.nomeUsuario as 'Usuário',
       cadastro.nomeEmpresa as 'Nome da Empresa', 
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