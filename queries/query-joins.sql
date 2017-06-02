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
												<cod_enfermidade>);
-- Receita um remedio (internação)
INSERT INTO internacao_remedio VALUES (<cpf_medico>,<cpf_paciente>,
										<data_consulta>, <data_entrada>,
										<cod_remedio>,
										<data_administração>,
										<cpf_profissional>, <dosagem>);
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
								<data_consulta>, <data_entrada>);
-- Fechar um internação (?)
UPDATE internacao WHERE SET
-- Busca de internação por data
-- Data da consulta teste ok
SELECT  inter.data_consulta, inter.data_entrada, med.nome as medico, pac.nome as paciente
FROM 	internacao inter, dadosmedico med,
						  dadospaciente pac
WHERE 	inter.cpf_medico 	= <cpf_medico> 		AND
		inter.cpf_paciente 	= <cpf_paciente> 	AND
		inter.data_consulta = <data_consulta> 	AND
		inter.cpf_medico	= med.cpf			AND
		inter.cpf_paciente 	= pac.cpf;

-- Data de Entrada teste ok
SELECT  inter.data_consulta, inter.data_entrada, med.nome as medico,
pac.nome AS paciente
FROM 	internacao inter, dadosmedico med,
						  dadospaciente pac
WHERE 	inter.cpf_medico 	= <cpf_medico> 		AND
		inter.cpf_paciente 	= <cpf_paciente> 	AND
		inter.data_entrada 	= <data_entrada> 	AND
		inter.cpf_medico 	= med.cpf			AND
		inter.cpf_paciente 	= pac.cpf;
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
										<cpf_profissional>, <dosagem>);

-- Consultar dados de uma administração teste ok
SELECT ir.data_consulta, ir.data_entrada,ir.data_administracao, med.nome AS medico,
pac.nome AS paciente, prof.nome as profissional, r.nome_remedio,
ir.dosagem
FROM internacao_remedio ir, dadosmedico med,
							dadospaciente pac,
							dadosprofissional prof,
							remedio r
WHERE 	ir.cpf_medico 			= <cpf_medico> 			AND
		ir.cpf_paciente 		= <cpf_paciente>		AND
		ir.data_consulta 		= <data_consulta>		AND
		ir.data_entrada 		= <data_entrada>		AND
		ir.cod_remedio			= <cod_remedio>			AND
		ir.data_administracao	= <data_administracao>	AND
		ir.cpf_medico 			= med.cpf				AND
		ir.cpf_paciente 		= pac.cpf               AND
        ir.cpf_profissional 	= prof.cpf	            AND
		ir.cod_remedio = r.cod_remedio;

-- Consultar o profissional de saúdo que administrou um remédio teste ok
SELECT ir.data_consulta, ir.data_entrada, med.nome AS medico,
pac.nome AS paciente, prof.nome as profissional, r.nome_remedio,
ir.dosagem
FROM internacao_remedio ir, dadosmedico med, dadospaciente pac,dadosprofissional prof, remedio r
WHERE 	ir.cpf_medico 			= <cpf_medico> 			AND
		ir.cpf_paciente 		= <cpf_paciente>		AND
		ir.data_consulta 		= <data_consulta>		AND
		ir.data_entrada 		= <data_entrada>		AND
		ir.cod_remedio			= <cod_remedio>			AND
		ir.data_administracao	= <data_administracao>	AND
		ir.cpf_medico 			= med.cpf				AND
		ir.cpf_paciente 		= pac.cpf               AND
		ir.cpf_profissional 	= prof.cpf	            AND
		ir.cod_remedio = r.cod_remedio;

-- Consultar todos os remédios administrados durante uma internacao teste ok
SELECT ir.data_administracao, prof.nome as profissional, r.nome_remedio, r.indicacao, ir.dosagem
FROM internacao_remedio ir, dadosprofissional prof, dadosremedio r
WHERE   ir.cpf_medico 			= <cpf_medico> 			AND
		ir.cpf_paciente 		= <cpf_paciente>		AND
		ir.data_consulta 		= <data_consulta>		AND
		ir.data_entrada 		= <data_entrada>		AND
		ir.cpf_profissional = prof.cpf AND
		ir.cod_remedio = r.cod_remedio;
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
										  <data_consulta>);
-- Consultar Detalhes de um procedimento teste ok
SELECT	pac.nome as paciente, med.nome as medico, prof.nome as quemrealizou, prof.area, proc.nome_procedimento, proc.descricao, proc.data_procedimento
FROM 	dadosprocedimento as proc NATURAL JOIN consulta_procedimento cp NATURAL JOIN profissional_procedimento pp,
		dadosmedico med,
		dadospaciente pac,
		dadosprofissional prof
WHERE 	cp.cod_procedimento = <cod_procedimento>	AND
		cp.cpf_paciente = pac.cpf			AND
		cp.cpf_medico = med.cpf				AND
		pp.cpf = prof.cpf;
-- Consultar profissionais que fizeram um procedimento teste ok
SELECT	proc.cod_procedimento, prof.nome, prof.matricula, prof.area
FROM 	dadosprocedimento proc NATURAL JOIN profissional_procedimento pp, dadosprofissional prof
WHERE	proc.cod_procedimento = <cod_procedimento> AND
	pp.cpf = prof.cpf;

-- Consultar todos os procedimentos referentes a uma consulta teste ok
SELECT proc.cod_procedimento, proc.nome_procedimento, proc.descricao, proc.data_procedimento
FROM consulta_procedimento cp, dadosprocedimento proc
WHERE cp.cpf_medico = <cpf_medico> AND
        cp.cpf_paciente = <cpf_paciente> AND
        cp.data_consulta = <data_consulta> AND
        cp.cod_procedimento = proc.cod_procedimento
ORDER BY proc.data_procedimento;
--------------------------------------------------------------------------------
----------------------------------Cirurgia--------------------------------------
-- Inserir uma Cirurgia
INSERT INTO cirurgia VALUES (<cod_procedimento>, <sala>);

-- Consultar cirurgias em um dia por horário teste ok
SELECT	c.data_procedimento, c.cod_procedimento, c.nome_procedimento,  c.sala
FROM	dadoscirurgia c
WHERE	c.data_procedimento BETWEEN <data1> and <data2>;

-- Consultar cirurgias em uma sala teste ok
SELECT	c.cod_procedimento, c.nome_procedimento, c.data_procedimento
FROM	dadoscirurgia c
WHERE	c.sala = <sala>;
--------------------------------------------------------------------------------
------------------------------------Exame---------------------------------------
-- Requisitar um Exame
INSERT INTO consulta_procedimento VALUES (<cod_procedimento>, <cpf_medico>,
	<cpf_paciente>, <data_consulta>);

-- Inserir informações de um Exame
UPDATE exame WHERE cod_procedimento = <cod_exame> SET dados = <dados>;

-- Todos os exames de um período do paciente
SELECT *
	FROM exame
	NATURAL JOIN procedimento
	NATURAL JOIN consulta_procedimento
	NATURAL JOIN consulta
	WHERE cpf_paciente = <cpf_paciente>
		AND data_procedimento BETWEEN <data_inicio> AND <data_fim>;

-- Funções
CREATE OR REPLACE FUNCTION internacao_medico_paciente_data_consulta(
		param_cpf_medico varchar, param_cpf_paciente varchar, param_data_consulta timestamp
	)
	RETURNS TABLE(
		data_consulta timestamp with time zone, data_entrada timestamp with time zone,
		medico varchar, paciente varchar
	)
	AS
	'SELECT  inter.data_consulta, inter.data_entrada,
					 med.nome as medico, pac.nome as paciente
	FROM 	internacao inter, dadosmedico med,
							  dadospaciente pac
	WHERE 	inter.cpf_medico 	= param_cpf_medico 		AND
			inter.cpf_paciente 	= param_cpf_paciente 	AND
			inter.data_consulta = param_data_consulta 	AND
			inter.cpf_medico	= med.cpf			AND
			inter.cpf_paciente 	= pac.cpf'
	LANGUAGE 'sql';


CREATE OR REPLACE FUNCTION cirurgias_na_sala(id_sala varchar)
	RETURNS SETOF dadoscirurgia
	AS
	'SELECT	*
		FROM	dadoscirurgia c
		WHERE	c.sala = id_sala'
	LANGUAGE 'sql';


CREATE OR REPLACE FUNCTION remedios_na_internacao(
	param_cpf_medico varchar, param_cpf_paciente varchar,
	param_data_consulta timestamp, param_data_entrada timestamp
)
	RETURNS TABLE(
		data_administracao timestamp with time zone, profissional varchar,
		nome_remedio varchar, indicacao text, dosagem varchar
	)
	AS
	'SELECT ir.data_administracao, prof.nome as profissional, r.nome_remedio, r.indicacao, ir.dosagem
	FROM internacao_remedio ir, dadosprofissional prof, dadosremedio r
	WHERE   ir.cpf_medico 			= param_cpf_medico 			AND
			ir.cpf_paciente 		= param_cpf_paciente		AND
			ir.data_consulta 		= param_data_consulta		AND
			ir.data_entrada 		= param_data_entrada		AND
			ir.cpf_profissional = prof.cpf AND
			ir.cod_remedio = r.cod_remedio'
	LANGUAGE 'sql';


CREATE OR REPLACE FUNCTION exames_paciente_periodo(
	cpf varchar, inicio timestamp, fim timestamp
	)
	RETURNS TABLE(
	cpf_medico varchar, cpf_paciente varchar, data_consulta timestamp with time zone,
	cod_procedimento integer, nome_arquivo varchar, dados bytea,
	nome_procedimento varchar, data_procedimento timestamp with time zone,
	tipo text
	)
	AS
	'SELECT *
		FROM exame
		NATURAL JOIN procedimento
		NATURAL JOIN consulta_procedimento
		NATURAL JOIN consulta
		WHERE cpf_paciente = cpf
			AND data_procedimento BETWEEN inicio AND fim'
	LANGUAGE 'sql';
