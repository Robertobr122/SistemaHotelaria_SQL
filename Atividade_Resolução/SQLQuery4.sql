Create database BD_HOTELARIA_ATT;
GO

USE BD_HOTELARIA_ATT;
GO 

CREATE TABLE HOSPEDE(
	Id INT IDENTITY(1000,1),
	Nome VARCHAR(100) NOT NULL,
	CPF VARCHAR(14) UNIQUE,
	Email VARCHAR(100),
	DataNascimento DATE,
	CONSTRAINT pk_hospede PRIMARY KEY(ID)
);

CREATE TABLE TELEFONEHOSPEDE(
	Id INT IDENTITY(1,1),
	IdHospede INT NOT NULL,
	Telefone CHAR(11) NOT null,
	CONSTRAINT pk_TELEFONEHOSPEDE PRIMARY KEY(ID),
	Constraint FK_Hospede_Telefone Foreign key(IdHospede) references hospede(id) 
);


CREATE TABLE TIPOQUARTO(
	ID INT IDENTITY,
	TIPO VARCHAR(50),
	CONSTRAINT PK_TIPOQUARTO PRIMARY KEY(ID)
);



CREATE TABLE QUARTO(
	Id INT IDENTITY(1,1),
	IdTipoQuarto INT NOT NULL,
	NumeroQuarto VARCHAR(10) not null,
	PrecoDiaria DECIMAL(7,2)
	Constraint FK_TipoQuarto_QUARTO Foreign key(IdTipoQuarto) references tipoquarto(id), 
	CONSTRAINT PK_QUARTO PRIMARY KEY(ID)
);

create table RESERVA(
	Id INT IDENTITY,
	IdHospede INT,
	IdQuarto INT,
	DataCheckin DATE,
	DataCheckout DATE,
	CONSTRAINT PK_RESERVA PRIMARY KEY(ID),
	Constraint FK_HOSPEDE_RESERVA Foreign key(IdHospede) references hOSPEDE(id), 
	Constraint FK_QUARTO_RESERVA Foreign key(IdQuarto) references Quarto(id)
);



create table PAGAMENTO(
	Id INT IDENTITY,
	IdReserva INT,
	DataPagamento Date,
	valor DECIMAL(8,2),
	CONSTRAINT PK_pagamento PRIMARY KEY(ID),
	Constraint FK_RESERVA_PAGAMENTO Foreign key(IdReserva) references Reserva(id), 
);

create table FORMAPAGAMENTO(
	Id INT IDENTITY,
	IdPagamento INT,
	TipoPagamento VARCHAR(50),
	CONSTRAINT PK_FormaPagamento PRIMARY KEY(ID),
	Constraint FK_Pagamento_FormaPagamento Foreign key(IdPagamento) references Pagamento(id), 
);


CREATE TABLE SERVICOEXTRA(
	Id INT IDENTITY,
	Descricao VARCHAR(100),
	valor DECIMAL(7,2)
	CONSTRAINT PK_ServicoExtra PRIMARY KEY(ID)
);



CREATE TABLE RESERVASERVICO(
	IdReserva INT,
	IdServicoExtra INT,
	Constraint PK_FK_Reserva Foreign key(IdReserva) references Reserva(id), 
	Constraint PK_FK_ServicoExtra Foreign key(IdServicoExtra) references ServicoExtra(id)
);

--01 - Liste o nome dos hóspedes e a quantidade de reservas realizadas por cada um.
--Inserindo dados:
INSERT INTO HOSPEDE(Nome, cpf, email, DataNascimento) VALUES
('Roberto Braga', '12345678901234', 'roberto@teste.com', '1998-05-10'),
('Filipe Rocha', '12345634501234', 'filipe@teste.com', '1998-04-12'),
('Kamila Queiroz', '17895678901234', 'kamila@teste.com', '2002-12-30'),
('Maria Eduarda', '12345678907894', 'meduarda@teste.com', '1997-07-25');
go

INSERT INTO TELEFONEHOSPEDE(IdHospede, Telefone) VALUES
(1000, '83999999999'),
(1001, '83999999988'),
(1002, '83999999977'),
(1003, '83999999966');
go

INSERT INTO TIPOQUARTO(TIPO) VALUES
('Simples'),
('Luxo'),
('Suíte');
go

INSERT INTO QUARTO(IdTipoQuarto, NumeroQuarto, PrecoDiaria) VALUES 
(1, 100, 100),
(1, 101, 100),
(1, 102, 100),
(2, 200, 200),
(2, 201, 200),
(2, 202, 200),
(3, 300, 300),
(3, 301, 300);
go

INSERT INTO RESERVA(IdHospede,IdQuarto, DataCheckin, DataCheckout) values 
(1000, 1, '10-05-2018', '12-05-2018'),
(1001, 2, '10-05-2019', '13-05-2018'),
(1002, 4, '10-05-2020', '14-05-2018'),
(1003, 7, '10-05-2021', '15-05-2018'),
(1000, 1, '10-05-2025', '12-05-2025'),
(1000, 1, '10-05-2024', '12-05-2024');

select  
h.Nome,
count(r.Id) as Historico_de_Reservas
from HOSPEDE h
	inner join RESERVA r
		on r.IdHospede = h.Id
group by h.Nome
order by Historico_de_Reservas desc

--02 Exiba os quartos que já foram reservados por mais de um hóspede diferente.
INSERT INTO RESERVA(IdHospede,IdQuarto, DataCheckin, DataCheckout) values 
(1002, 1, '05-05-2019', '12-05-2019')

select 
q.NumeroQuarto,
count(distinct r.IdHospede) as Qtd_Hospedes_Diferentes
from reserva r
	inner join quarto q 
		on r.IdQuarto = q.Id
group by q.NumeroQuarto
having count(distinct r.IdHospede) > 1
order by q.NumeroQuarto asc

--03 Liste as reservas que não possuem nenhum pagamento registrado.
select 
	r.Id as COD_Reserva,
	p.IdReserva
from RESERVA r
	left join PAGAMENTO P
		on p.IdReserva = r.Id
where p.IdReserva is null

--04 Exiba o total pago por cada reserva, somando o valor do pagamento e dos serviços extras utilizados.
--Inserção de Valores Incorretos, pois falta o ID do tipo Pagamento
insert into PAGAMENTO(IdReserva, DataPagamento, valor) values
(1, '2018-05-10', 200),
(2, '2018-05-13', 300),
(3, '2018-05-14', 800),
(4, '2018-05-15', 1500),
(5, '2025-05-12', 200);

--Apagaento Cadastros incorretos com seus respectivos ID's
delete from pagamento;
dbcc checkident ('PAGAMENTO', RESEED, 0);

--Ajustando tabela que estava com a fk no local errado
ALTER TABLE formapagamento
DROP CONSTRAINT fk_pagamento_formapagamento;
alter table formapagamento 
drop column idpagamento

--Adicionando a coluna de IdTipoPagamento na tabela Pagamento
alter table Pagamento
add IdTipoPagamento INT;
Alter table Pagamento
add Constraint fk_TipoPagamento_Pagamento
foreign key(IdTipoPagamento) references formaPagamento(id)

--Cadastrando tipos de pagamento
insert into FORMAPAGAMENTO(TipoPagamento) Values 
('PIX'),
('CARTÃO DÉBITO'),
('CARTÃO CRÉDITO'),
('DINHEIRO')

-- Inserindo pagamentos da forma correta
insert into PAGAMENTO(IdReserva, DataPagamento, valor, IdTipoPagamento) values
(1, '2018-05-10', 200, 1),
(2, '2018-05-13', 300, 3),
(3, '2018-05-14', 800, 3),
(4, '2018-05-15', 1500, 4),
(5, '2025-05-12', 200, 2);
--Inserindo dados de Serviço
insert into SERVICOEXTRA(Descricao, valor) values 
('Café', 40),
('Almoço', 60),
('Janta', 80),
('Massagem', 120);
--inserindo dados na tabela associativa
insert into RESERVASERVICO(IdReserva, IdServicoExtra) values 
(1, 1),
(1, 2),
(1, 3),
(3, 4),
(2, 2),
(2, 3);

-- Exibindo conta total da reservas que realizaram pagamento
Select 
re.IdHospede,
sum(pa.valor + se.valor) as Valor_Total
from PAGAMENTO pa
	inner join reserva re
		on re.Id = pa.IdReserva
	inner join RESERVASERVICO rs
		on rs.IdReserva = re.Id
	inner join SERVICOEXTRA se
		on se.Id = rs.IdServicoExtra
group by re.IdHospede

--05 Atualize a forma de pagamento da reserva do hóspede "Fernanda Souza" para "Pix", considerando a reserva mais recente.
--inserindo os dados de fernanda
INSERT INTO HOSPEDE(NOME, CPF, EMAIL, DataNascimento) values 
('Fernanda Souza', 34567890987654, 'fernanda@teste.com', '1997-06-13');
INSERT INTO reserva(IdHospede, IdQuarto, DataCheckin, DataCheckout) values 
(1004, 2, '2017-05-08', '2017-05-11');
INSERT INTO PAGAMENTO(IdReserva, DataPagamento, valor, IdTipoPagamento) values 
(8, '2017-05-08', 300, 3);

--Atualizando para pix
UPDATE PAGAMENTO
SET IDTIPOPAGAMENTO = 1
WHERE IDRESERVA = 8
--verificando 
select 
pa.IdReserva,
fo.TipoPagamento
from PAGAMENTO pa
	inner join FORMAPAGAMENTO fo
		on pa.IdTipoPagamento = fo.Id

--06 Liste o nome dos hóspedes que já utilizaram três ou mais tipos diferentes de serviços extras.
select 
ho.Nome,
count(se.Id) as QTD_Serviços_Utilizado
from HOSPEDE ho
	inner join RESERVA re
		on re.IdHospede = ho.Id
	inner join RESERVASERVICO rs
		on rs.IdReserva = re.Id
	inner join SERVICOEXTRA se
		on se.Id = rs.IdServicoExtra
group by ho.Nome
having count(se.Id) >= 3

-- 07 Remova todas as reservas com data de check-out anterior a 1º de janeiro de 2020.
select * from RESERVA
where DataCheckout < '2020-01-01';
select * from PAGAMENTO;

delete from RESERVASERVICO
where IdReserva = 1
or IdReserva = 2
or IdReserva = 3
or IdReserva = 4
or IdReserva = 7
or IdReserva = 8;
delete from pagamento
where DataPagamento < '2020-01-01';
delete from reserva
where DataCheckout < '2020-01-01';


--08 Liste todos os serviços extras utilizados em reservas no quarto número "202".
select * from QUARTO;
select * from RESERVA;
select * from HOSPEDE;
select * from SERVICOEXTRA

--inserindo novo hospede para o quarto 202 com serviços 
insert into hospede(nome, cpf, Email, DataNascimento) values 
('Ricardo Braga', 34567890987854, 'ricardo@teste.com', '1996-05-09')
insert into RESERVA(IdHospede, IdQuarto,DataCheckin,DataCheckout) values 
(1006, 6, '2025-05-20','2025-05-25')
insert into RESERVASERVICO(IdReserva, IdServicoExtra) values 
(9, 1),
(9, 2),
(9, 3),
(9, 4);

select 
qu.NumeroQuarto,
count(se.Id) QTD_SERVIÇOS_EX
from QUARTO qu
	inner join reserva re 
		on re.IdQuarto = qu.Id
	inner join RESERVASERVICO rs
		on rs.IdReserva = re.Id
	inner join SERVICOEXTRA se
		on se.Id = rs.IdServicoExtra
group by qu.NumeroQuarto
having qu.NumeroQuarto = 202


--09 Mostre os hóspedes que usaram o serviço "Massagem Relaxante" ao menos uma vez.
select  
ho.Nome,
SE.Descricao AS SERVIÇO
	from HOSPEDE ho
	INNER JOIN RESERVA RE
		ON RE.IdHospede = HO.Id
	INNER JOIN RESERVASERVICO RS
		ON RS.IdReserva = RE.Id
	INNER JOIN SERVICOEXTRA SE
		ON SE.Id = RS.IdServicoExtra
WHERE SE.Descricao = 'MASSAGEM'

--10 Altere o tipo de todos os quartos com diária superior a R$ 800,00 para "Executivo".
SELECT * FROM TIPOQUARTO
SELECT * FROM QUARTO

--ADICIONANDO NOVO QUARTO COM VALOR DE 800
INSERT INTO TIPOQUARTO(TIPO) VALUES ('SUITE MASTER')
INSERT INTO QUARTO(IdTipoQuarto,NumeroQuarto,PrecoDiaria) VALUES 
(4, 500, 850),
(4, 501, 850),
(4, 502, 850);

--VERIFICANDO QUAIS QUARTOS TEM MAIS DE 800 COMO DIARIA
SELECT 
	QU.NumeroQuarto,
	QU.Id,
	QU.IdTipoQuarto,
	TI.TIPO
FROM QUARTO QU
	INNER JOIN TIPOQUARTO TI
		ON TI.ID = QU.IdTipoQuarto
WHERE QU.PrecoDiaria > 800

--ALTERANDO NOME PARA EXECUTIVO
UPDATE TIPOQUARTO
	SET TIPO = 'EXECUTIVO'
WHERE TIPO = 'SUITE MASTER'
AND ID = 4

--11 Para cada quarto que já foi reservado, exiba o número do quarto, o tipo, o nome do hóspede e a data de check-in..
Select 
	qu.NumeroQuarto,
	ti.TIPO,
	ho.Nome,
	re.DataCheckin
from hospede ho
	inner join reserva re
		on re.IdHospede = ho.Id
	inner join QUARTO qu
		on qu.Id = re.IdQuarto
	inner join TIPOQUARTO ti
		on ti.ID = qu.IdTipoQuarto

--12 Exiba os 5 hóspedes mais recentes (com base na data da última reserva).
-- Adicionando mais reservar 
select * from HOSPEDE;
select * from QUARTO;
select * from RESERVA;
Insert into RESERVA(IdHospede, IdQuarto, DataCheckin, DataCheckout) values 
(1001, 2, '2025-02-05','2025-02-08'),
(1002, 3, '2025-03-05','2025-03-08'),
(1003, 4, '2025-04-05','2025-04-08'),
(1004, 8, '2025-05-05','2025-05-08');
--Verificando os 5 mais recentes 
Select top 5
	ho.Nome,
	re.DataCheckin
from HOSPEDE as ho
	inner join reserva as re
		on re.IdHospede = ho.Id
order by re.DataCheckin desc


--13 Mostre todos os pagamentos realizados, exibindo: nome do hóspede, número do quarto, valor do pagamento e forma de pagamento..
select 
	ho.Nome, 
	pa.DataPagamento,
	pa.valor,
	qu.NumeroQuarto
from HOSPEDE ho
	inner join RESERVA re on re.IdHospede = ho.Id
	inner join PAGAMENTO pa on pa.IdReserva = re.Id
	inner join quarto qu on qu.Id = re.IdQuarto


--14 Exiba a média de dias de estadia por tipo de quarto.

SELECT 
	TI.TIPO,
	AVG(DATEDIFF(DAY, RE.DataCheckin, RE.DataCheckout)) AS NUMERO_DE_DIAS
FROM RESERVA RE
	INNER JOIN QUARTO QU ON QU.Id = RE.IdQuarto
	INNER JOIN TIPOQUARTO TI ON TI.ID = QU.IdTipoQuarto
GROUP BY TI.TIPO

--15 Liste os hóspedes que possuem e-mail com domínio "@gmail.com" e que já realizaram ao menos uma reserva.
insert into HOSPEDE values ('José', 12378909871234, 'jose@gmail.com', '1997-03-10')
insert into HOSPEDE values ('Joana', 12378909877834, 'joana@gmail.com', '1997-07-10')
insert RESERVA values 
(1007, 8, '2025-08-10', '2025-08-18' ),
(1008, 9, '2025-04-10', '2025-04-18' );

SELECT 
	ho.Nome,
	ho.Email
FROM HOSPEDE ho
	inner join RESERVA re on re.IdHospede = ho.Id
where ho.Email like '%@gmail.com'