NATURAL JOIN profissional_saude/*Remédios
Cadastrar remédio; 				Feito
Receitar um remédio;			Feito

Internação
Cadastrar uma internação;		Feito
Fechar uma internação;			WIP
Busca de internação por data;	Feito

Internação-Remédio:
Cadastrar uma administração							Feito
Consultar dados de uma administração				Feito
Consultar profissional que realizou administração	Feito

Procedimento
Cadastrar um procedimento para uma enfermidade para um paciente;   Feito
Consultar detalhes (data, profissional, informações) do procedimento; Feito
Consultar profissionais que realizaram um procedimento;	Feito

Cirurgia
Cadastrar uma cirurgia;		Feito
Consultar cirurgias em um dia por horário; Feito
Consulta cirurgia em uma sala;	Feito

Exame
Solicitar um exame;	Feito
Inserir informações do exame;	Feito
Consultar exames pendentes (requisitados mas ainda Não realizados)
de um paciente
*/


-- Querys SQL do projeto de banco
--------------------------------Remedio---------------------------------
-- Cadastra um novo remedio
INSERT INTO remedio VALUES (<cod_remedio>, <nome_remedio>);
INSERT INTO public.descricao_remedio VALUES (<cod_remedio>,
												<nome_remedio>,
												<dose_max>);
-- Receita um remedio (enfermidade)
INSERT INTO enfermidade_remedio VALUES (<cod_remedio>,
												<cod_enfermidade>)
-- Receita um remedio (internação)
INSERT INTO internacao_remedio VALUES (<cpf_medico>,<cpf_paciente>,
										<data_consulta>, <data_entrada>,
										<cod_remedio>,
										<data_administração>,
										<cpf_profissional>, <dosagem>)
/* 	Onde:
	<cod_remedio> 		: inteiro único
	<nome_remedio>		: varchar (50)
	<dose_max>			: varchar (50)
	<cod_efermidade>	: inteiro único
	<cpf_medico>		: varchar (11) único
	<cpf_paciente>		: varchar (11) único
	<data_consulta>		: timestamp (c/ TimeZone)
	<data_entrada>  	: timestamp (c/ TimeZone)
	<data_administração>: timestamp (c/ TimeZone)
	<cpf_profissional>	: varchar (11)
	<dosagem>			: varchar (20)
*/
------------------------------------------------------------------------
-------------------------------Internação-------------------------------
-- Cadastra uma Internação
INSERT INTO internacao VALUES (<cpf_medico>, <cpf_paciente>,
								<data_consulta>, <data_entrada>)
-- Fechar um internação (?)
UPDATE internacao WHERE SET
-- Busca de internação por data
-- Data da consulta
SELECT  inter.data_consulta, inter.data_entrada, med.nome, pac.nome
-- BEWARE HERE BE QUERYS
FROM 	internacao inter, (pessoa NATURAL JOIN medico) med,
						  (pessoa NATURAL JOIN paciente) pac
WHERE 	inter.cpf_medico 	= <cpf_medico> 		AND
		inter.cpf_paciente 	= <cpf_paciente> 	AND
		inter.data_consulta = <data_consulta> 	AND
		inter.cpf_medico	= med.cpf			AND
		inter.cpf_paciente 	= pac.cpf
-- Data de Entrada
SELECT  inter.data_consulta, inter.data_entrada, med.nome as medico,
pac.nome AS paciente
-- BEWARE HERE BE QUERYS
FROM 	internacao inter, (pessoa NATURAL JOIN medico) med,
						  (pessoa NATURAL JOIN paciente) pac
WHERE 	inter.cpf_medico 	= <cpf_medico> 		AND
		inter.cpf_paciente 	= <cpf_paciente> 	AND
		inter.data_entrada 	= <data_entrada> 	AND
		inter.cpf_medico 	= med.cpf			AND
		inter.cpf_paciente 	= pac.cpf
/*	Onde:
	<cpf_medico>		: varchar (11) único
	<cpf_paciente>		: varchar (11) único
	<data_consulta>		: timestamp (c/ TimeZone)
	<data_entrada>  	: timestamp (c/ TimeZone)
*/
------------------------------------------------------------------------
----------------------- Internação-Remédio------------------------------
-- Cadastrar um administração (Igual a receitar)
INSERT INTO internacao_remedio VALUES (<cpf_medico>,<cpf_paciente>,
										<data_consulta>, <data_entrada>,
										<cod_remedio>,
										<data_administração>,
										<cpf_profissional>, <dosagem>)

-- Consultar dados de uma administração
SELECT ir.data_consulta, ir.data_entrada, med.nome AS medico,
pac.nome AS paciente, prof.nome as profissional, r.nome_remedio,
ir.dosagem
FROM internacao_remedio ir, (pessoa NATURAL JOIN medico) med,
							(pessoa NATURAL JOIN paciente) pac,
							(pessoa NATURAL JOIN profissional) prof,
							remedio r
WHERE 	ir.cpf_medico 			= <cpf_medico> 			AND
		ir.cpf_paciente 		= <cpf_paciente>		AND
		ir.data_consulta 		= <data_consulta>		AND
		ir.data_entrada 		= <data_entrada>		AND
		ir.cod_remedio			= <cod_remedio>			AND
		ir.data_administracao	= <data_administracao>	AND
		ir.cpf_medico 			= med.cpf				AND
		ir.cpf_paciente 		= pac.cpf

-- Consultar o profissional de saúdo que administrou um remédio
SELECT ir.data_consulta, ir.data_entrada, med.nome AS medico,
pac.nome AS paciente, prof.nome as profissional, r.nome_remedio,
ir.dosagem
FROM internacao_remedio ir, (pessoa NATURAL JOIN profissional_saude) prof,
							remedio r
WHERE 	ir.cpf_medico 			= <cpf_medico> 			AND
		ir.cpf_paciente 		= <cpf_paciente>		AND
		ir.data_consulta 		= <data_consulta>		AND
		ir.data_entrada 		= <data_entrada>		AND
		ir.cod_remedio			= <cod_remedio>			AND
		ir.data_administracao	= <data_administracao>	AND
		ir.cpf_profissional		= prof.cpf


/*	Onde:
	<cpf_medico>		: varchar (11) único
	<cpf_paciente>		: varchar (11) único
	<data_consulta>		: timestamp (c/ TimeZone)
	<data_entrada>  	: timestamp (c/ TimeZone)
	<data_administração>: timestamp (c/ TimeZone)
	<cpf_profissional>	: varchar (11)
	<dosagem>			: varchar (20)
*/
------------------------------------------------------------------------
----------------------------Procedimento--------------------------------
-- Cadastrar um procedimento para uma enfermidade para um paciente
INSERT INTO consulta_procedimento VALUES (<cod_procedimento>,
										  <cpf_medico>,<cpf_paciente>,
										  <data_consulta>)
-- Consultar Detalhes de um procedimento
SELECT	pac.nome, med.nome, proc.nome_procedimento, dp.descricao, proc.data
FROM 	procedimento proc,
		descricao_procedimento dp,
		consulta_procedimento cp,
		profissional_procedimento pp,
		(pessoa NATURAL JOIN medico) med,
		(pessoa NATURAL JOIN paciente) pac,
		(pessoa NATURAL JOIN profissional_saude) prof
WHERE 	cp.cod_procedimento = <cod_procedimento> 	AND
		cp.cpf_medico = <cpf_medico>				AND
		cp.cpf_paciente = <cpf_paciente> 			AND
		cp.data_consulta = <data_consulta>			AND
		cp.cpf_paciente = pac.cpf_paciente 			AND
		cp.cpf_medico = med.cpf_medico 				AND
		pp.cpf_profissional = prof.cpf_profissional
-- Consultar profissionais que fizeram um procedimento
SELECT	proc.cod_procedimento, pp.nome, pp.matricula
FROM 	procedimento proc,
		(profissional_procedimento NATURAL JOIN profissional_saude) pp
WHERE	proc.cod_procedimento = <cod_procedimento>
--------------------------------------------------------------------------------
----------------------------------Cirurgia--------------------------------------
-- Inserir uma Cirurgia
INSERT INTO cirurgia VALUES (<cod_procedimento>, <sala>)
-- Cadastrar uma cirurgia para uma internacao
INSERT INTO internacao_cirurgia VALUES (<cpf_medico>, <cpf_paciente>,
	<data_consulta>, <data_entrada>, <cod_procedimento>)

-- Consultar cirurgias em um dia por horário
SELECT	c.data_procedimento, c.sala, c.cod_procedimento
FROM	(procedimento NATURAL JOIN cirurgia) c
WHERE	c.data_procedimento BETWEEN <data1> and <data2>

-- Consultar cirurgias em uma sala
SELECT	c.cod_procedimento, c.data_procedimento
FROM	(procedimento NATURAL JOIN cirurgia) c
WHERE	c.sala = <sala>
--------------------------------------------------------------------------------
------------------------------------Exame---------------------------------------
-- Requisitar um Exame
INSERT INTO consulta_procedimento VALUES (<cod_procedimento>, <cpf_medico>,
	<cpf_paciente>, <data_consulta>)

-- Inserir informações de um Exame
UPDATE exame WHERE cod_procedimento = <cod_exame> SET dados = <dados>
