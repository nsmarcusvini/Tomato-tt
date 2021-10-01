-- Criando Banco de Dados --
create database cultivo_tomato;

-- Selecionando Banco de Dados --
use tomato;

-- Criando Tabela Cadastro T1 --
create table cadastro (
idCliente int primary key auto_increment,
nome varchar (45),
contato varchar (45),
cidade varchar (45)
);

-- Criando Tabela Usuários T2 --
create table usuario (
idUsuario int primary key auto_increment,
nome varchar (45),
email varchar (45),
senha char (10),
fkCadastro int,
foreign key (fkCadastro) references usuario (idUsuario),
fkFazenda int,
foreign key (fkFazenda) references usuario (idUsuario)
);

-- Criando Tabela Fazenda T3 --
create table fazenda (
idFazenda int primary key auto_increment,
tipoSolo varchar (45),
tipoTomate varchar (45),
tamanhoFazenda varchar (45),
dataConsumo datetime,
consumoAgua varchar (100)
);

-- Criando Tabela Dados Históricos T4 --
create table dadoshistoricos (
idDados int primary key auto_increment,
dtUmidade datetime,
medidasUmidade varchar (45),
dtTemperatura datetime,
medidaTemperatura varchar (45),
statusSensor varchar (45),
check (statusSensor = 'ativo' or statusSensor = 'inativo'),
fkSensor int,
foreign key (fkSensor) references dadoshistoricos(idDados)
);

-- Criando Tabela Sensor T5 -- 
create table sensor (
idSensor int primary key auto_increment,
descricao varchar(45),
localSensor varchar (45),
fkFazenda int,
foreign key (fkFazenda) references sensor(idSensor)
);

-- Inserindo dados na tabela cadastro --
insert into cadastro(nome,contato,cidade) values
('JBS','(11) 3144-4000','São Paulo - SP'),
('AMBEV','(11) 3592-6863','Osasco - SP'),
('RAÍZEN ENERGIA','(64) 3636-2268','Jataí - GO · '),
('MARFRIG GLOBAL FOODS','(11) 4593-7400','Itupeva - SP'),
('BUNGE ALIMENTOS','(13)3131-7300','Santos - SP'),
('COSAN','(11) 04538-132','São Paulo - SP');

-- Inserindo dados na tabela usuário --
insert into usuario (nome,email,senha) values
('Bruno Tavares','bruno.tavares@bandtec.com.br','1234567890'),
('Marcus Vinicius','marcus@bandtec.com.br','1010101010'),
('Breno Padovani','breno@bandtec.com.br','2020202020'),
('Igor Quintanilha','igor@bandtec.com.br','3030303030'),
('Juliana Ju','juliana@bandtec.com.br','4040404040'),
('Kamila Santos','kamila@bandtec.com.br','5050505050'),
('Carlos Felix','carlos@bandtec.com.br','6060606060'),
('Marise Machine','marise@bandtec.com.br','7070707070'),
('Vivian Dados','vivian@bandtec.com.br','8080808080'),
('Friza Maioral','friza@bandtec.com.br','9090909090'),
('Betina','betina@bandtec.com,br','1212121212'),
('Regina','regina@bandtec.com.br','2121212121');

-- Inserindo dados na tabela fazenda -- 
insert into fazenda (tipoSolo,tipoTomate,tamanhoFazenda,dataConsumo,consumoAgua) values
('fertil','italiano','100hectares','2020-02-01','2.5'),
('fertil','italiano','120hectares','2020-02-01','2'), 
('fertil','cereja','200hectares','2020-02-01','2'), 
('fertil','debora','150hectares','2020-02-01','1.9'), 
('fertil','holandês','97hectares','2020-02-01','2.2'), 
('fertil','carmen','99hectares','2020-02-01','2.5'), 
('fertil','debora','225hectares','2020-02-01','2'); 

-- Inserindo os dados na tabela dados historicos --
insert into dadoshistoricos (dtUmidade,medidasUmidade,dtTemperatura,medidaTemperatura,statusSensor) values
('2020-02-01','70%','2020-02-01','25ºc','ativo'),
('2020-02-01','72%','2020-02-01','23ºC','ativo'),
('2020-02-01','67%','2020-02-01','18ºC','ativo'),
('2020-02-01','65%','2020-02-01','16ºC','ativo'),
('2020-02-01','75%','2020-02-01','20ºC','ativo'),
('2020-02-01','80%','2020-02-01','27ºC','ativo'),
('2020-02-01','78%','2020-02-01','26ºC','ativo'),
('2020-02-01','72%','2020-02-01','20ºC','ativo'),
('2020-02-01','75%','2020-02-01','24ºC','ativo'),
('2020-02-01','80%','2020-02-01','27ºC','ativo');

-- Inserindo dados na tabela sensor --
insert into sensor(descricao,localSensor) values
('S1','leste'),
('S2','sul'),
('S3','norte'),
('S4','oeste'),
('S5','centro');

-- Exibindo os dados das tabelas --
select * from cadastro;
select * from usuario;
select * from fazenda;
select * from sensor;
select * from dadoshistoricos;

select * from usuario left join cadastro on usuario.fkCadastro = idUsuario
					  left join fazenda on usuario.fkFazenda = idFazenda;
            
select * from usuario left join cadastro on fazenda = cadastro;            
                      