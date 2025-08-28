create database db_revenda_gabrielle;

create table produtos (
produto_id serial primary key,
nome varchar(100) not null,
descricao varchar(40),
preco decimal(10,2) not null,
estoque int not null default 0,
categoria_id int not null
);

create table endereco(
endereco_id serial primary key,
cep varchar (10) not null,
rua varchar (40) not null,
numero varchar (10) not null,
ponto_referencia varchar (40),
bairro varchar (30) not null,
uf char (2) not null
);

create table clientes (
cliente_id serial primary key,
nome varchar(40) not null,
email varchar(30) not null unique,
telefone varchar(15) not null,
endereco_id int,
data_nascimento date,
cpf char(11) unique,
foreign key (endereco_id) references endereco(endereco_id)
);

create table vendas (
venda_id serial primary key,
cliente_id int not null,
data_venda date not null,
total decimal(10,2) not null,
foreign key (cliente_id) references clientes(cliente_id)
);

create table funcionarios (
funcionario_id serial primary key,
nome varchar(100) not null,
cargo varchar(50) not null,
telefone varchar(15),
email varchar(100) not null unique,
salario decimal(10,2),
data_admissao date,
endereco_id int,
foreign key (endereco_id) references endereco(endereco_id)
);


create table pagamentos (
pagamento_id serial primary key,
venda_id int not null,
metodo varchar(20) not null,
status varchar(30) not null default false,
data_pagamento date,
foreign key (venda_id) references vendas(venda_id)
);

create view clientes_com_endereco as
select c.nome, c.email, c.telefone, e.rua, e.numero, e.bairro, e.uf
from clientes c
left join endereco e on c.endereco_id = e.endereco_id;

select * from clientes_com_endereco;

create view vendas_com_cliente as
select v.venda_id, v.data_venda, v.total, c.nome as cliente_nome, c.email
from vendas v
join clientes c on v.cliente_id = c.cliente_id;

select * from vendas_com_cliente;

create view pagamentos_com_venda as
select p.pagamento_id, p.metodo, p.status, p.data_pagamento, v.total
from pagamentos p
join vendas v on p.venda_id = v.venda_id;

select * from pagamentos_com_venda;

create view funcionarios_com_endereco as
select f.nome, f.cargo, f.email, e.rua, e.numero, e.bairro, e.uf
from funcionarios f
left join endereco e on f.endereco_id = e.endereco_id;

select * from funcionarios_com_endereco;

create view produtos_estoque_preco as
select nome, descricao, preco, estoque
from produtos;

select * from produtos_estoque_preco;


create view clientes_com_num_vendas as
select c.nome, count(v.venda_id) as total_vendas
from clientes c
left join vendas v on c.cliente_id = v.cliente_id
group by c.nome;

select * from clientes_com_num_vendas;

insert into produtos (nome, descricao, preco, estoque, categoria_id) values
('Shampoo Hidratante', 'Shampoo de uso diário para cabelos secos', 19.99, 50, 1),
('Condicionador Nutritivo', 'Condicionador para hidratação profunda', 22.50, 60, 1),
('Máscara Capilar', 'Máscara de tratamento intensivo', 45.00, 30, 2),
('Creme para Pentear', 'Creme para pentear anti-frizz', 15.99, 100, 3),
('Óleo de Argan', 'Óleo para nutrição e brilho dos cabelos', 39.99, 20, 2),
('Shampoo Anticaspa', 'Shampoo para combater a caspa', 18.00, 70, 1),
('Tônico Capilar', 'Tônico fortalecedor de raízes', 28.00, 40, 3),
('Gel Modelador', 'Gel para fixação forte e modelagem', 12.99, 90, 1),
('Spray Protetor Solar', 'Spray para proteger contra raios UV', 25.00, 50, 2),
('Kit de Escovas', 'Escova para modelar e escovar os fios', 35.00, 15, 4);

insert into endereco (cep, rua, numero, ponto_referencia, bairro, uf) values
('12345-678', 'Rua A', '123', 'Próximo ao mercado', 'Centro', 'SP'),
('23456-789', 'Rua B', '456', 'Ao lado da farmácia', 'Jardim', 'RJ'),
('34567-890', 'Rua C', '789', 'Em frente ao banco', 'Vila Nova', 'MG'),
('45678-901', 'Rua D', '101', 'Próximo ao hospital', 'Parque', 'ES'),
('56789-012', 'Rua E', '202', 'Ao lado da escola', 'Santa Clara', 'BA'),
('67890-123', 'Rua F', '303', 'Perto da praça', 'São José', 'PR'),
('78901-234', 'Rua G', '404', 'Em frente ao supermercado', 'Cidade Alta', 'SC'),
('89012-345', 'Rua H', '505', 'Ao lado da biblioteca', 'Centro', 'PE'),
('90123-456', 'Rua I', '606', 'Próximo ao shopping', 'Vila Real', 'GO'),
('01234-567', 'Rua J', '707', 'Em frente ao posto de saúde', 'Bairro Novo', 'MT');

insert into clientes (nome, email, telefone, endereco_id, data_nascimento, cpf) values
('Ana Clara', 'ana@clara.com', '11999999999', 1, '1985-04-12', '12345678901'),
('Gabrielle', 'carlos@sesi.com', '21988888888', 2, '1990-11-05', '23456789012'),
('Juliana Mazala', 'ju@sesi.com', '31977777777', 3, '1982-03-22', '34567890123'),
('Maria Alice', 'maria@sesi.com', '41966666666', 4, '1988-07-30', '45678901234'),
('Luiza', 'luiza@sesi.com', '51955555555', 5, '1995-12-10', '56789012345'),
('Gabrielle Gomes', 'Gomes@sesi.com', '61944444444', 6, '1992-01-25', '67890123456'),
('Larissa', 'Larissa@sesi.com', '71933333333', 7, '1987-09-17', '78901234567'),
('Isadora', 'isa@sesi.com', '81922222222', 8, '1991-06-23', '89012345678'),
('Letícia', 'lele@sesi.com', '91911111111', 9, '1994-02-14', '90123456789'),
('andrea', 'andrea@sesi.com', '92900000000', 10, '1980-10-30', '01234567890');

insert into vendas (cliente_id, data_venda, total) values
(1, '2025-08-10', 120.50),
(2, '2025-08-11', 200.00),
(3, '2025-08-12', 150.75),
(4, '2025-08-13', 90.99),
(5, '2025-08-14', 230.00),
(6, '2025-08-15', 180.60),
(7, '2025-08-16', 205.80),
(8, '2025-08-17', 175.40),
(9, '2025-08-18', 110.00),
(10, '2025-08-19', 99.99);


insert into funcionarios (nome, cargo, telefone, email, salario, endereco_id) values
('João Santos', 'Gerente', '11988888888', 'joao@empresa.com', 3500.00, 1),
('Maria Clara', 'Atendente', '21977777777', 'maria@empresa.com', 2200.00, 2),
('Antonio', 'Vendedor', '31966666666', 'Antonio@empresa.com', 2500.00, 3),
('Sofia Almeida','Analista de Estoque','11977776666','sofia.almeida@empresa.com',2800.00, 3);


insert into pagamentos (venda_id, metodo, status, data_pagamento) values
(1, 'Cartão de Crédito', 'pago', '2025-08-15'),
(2, 'Boleto', 'pendente', '2025-08-16'),
(3, 'Pix', 'pago', '2025-08-17'),
(4, 'Cartão de Débito', 'pago', '2025-08-18'),
(5, 'Dinheiro', 'pendente', '2025-08-19'),
(6, 'Cartão de Crédito', 'pago', '2025-08-20'),
(7, 'Boleto', 'pendente', '2025-08-21'),
(8, 'Pix', 'pago', '2025-08-22'),
(9, 'Cartão de Débito', 'pago', '2025-08-23'),
(10,'Dinheiro', 'pendente', '2025-08-24');


select * from funcionarios
where cargo like 'Gerente';

explain select * from produtos where preco > 20;

create index idx_preco
on produtos (preco);

select preco, estoque
FROM produtos
WHERE preco = 45.00 ;

explain select * from produtos where preco > 20;

alter table clientes 
alter column telefone int;

alter table produtos 
alter column estoque varchar;

create user Gabrille with password 'gabi15';

grant all privileges on all tables in schema public to Gabrille;

create user julinhamazala with password 'amanhanãotemSenai32';

grant select on clientes to julinhamazala;

select c.nome, e.rua, e.numero, e.bairro
from clientes c
inner join endereco e on c.endereco_id = e.endereco_id;

select c.nome, e.rua, e.numero, e.bairro
from clientes c
left join endereco e on c.endereco_id = e.endereco_id;

select c.nome, e.rua, e.numero, e.bairro
from clientes c
right join endereco e on c.endereco_id = e.endereco_id;



select f.nome, e.rua, e.bairro, e.uf
from funcionarios f
inner join endereco e on f.endereco_id = e.endereco_id;

select f.nome, e.rua, e.bairro, e.uf
from funcionarios f
left join endereco e on f.endereco_id = e.endereco_id;

select f.nome, e.rua, e.bairro, e.uf
from funcionarios f
right join endereco e on f.endereco_id = e.endereco_id;




select v.venda_id, v.total, p.metodo, p.status
from vendas v
inner join pagamentos p on v.venda_id = p.venda_id;

select v.venda_id, v.total, p.metodo, p.status
from vendas v
left join pagamentos p on v.venda_id = p.venda_id;

select v.venda_id, v.total, p.metodo, p.status
from vendas v
right join pagamentos p on v.venda_id = p.venda_id;


select v.venda_id, v.data_venda, v.total, c.nome as cliente_nome, c.email
from vendas v
inner join clientes c on v.cliente_id = c.cliente_id;

select v.venda_id, v.data_venda, v.total, c.nome as cliente_nome, c.email
from vendas v
left join clientes c on v.cliente_id = c.cliente_id;

select v.venda_id, v.data_venda, v.total, c.nome as cliente_nome, c.email
from vendas v
right join clientes c on v.cliente_id = c.cliente_id;

update funcionarios
set telefone = '00000000000'
where telefone is null;

update clientes
set data_nascimento = '1990-01-01'
where data_nascimento is null;

update endereco
set ponto_referencia = 'sem referência'
where ponto_referencia is null;

update funcionarios 
set nome = 'sem nome'
where nome is null;
























