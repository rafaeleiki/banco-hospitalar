-- Atualização
	UPDATE paciente SET ocupacao = <ocupacao>,
                    	etnia = <etnia>,
                    	local_nascimento = <local_nascimento>,
                    	escolaridade = <escolaridade>,
                    	religiao = <religiao>,
                    	convenio = <convenio>
WHERE cpf = <cpf>;

-- Consulta de dados de um paciente
	SELECT *
	FROM dadospaciente
	WHERE cpf = <cpf>;

-- Consulta do histórico de consultas de um paciente
	SELECT *
	FROM consulta
	WHERE cpf_paciente = <cpf_paciente>;

-- Consulta do histórico de exames de um paciente
	SELECT *
	FROM exame
	NATURAL JOIN procedimento
	NATURAL JOIN consulta_procedimento
	NATURAL JOIN consulta
	WHERE cpf_paciente = cpf
	AND data_procedimento BETWEEN inicio AND fim'


-- Consulta do histórico de internações de um paciente
	SELECT data_entrada, data_saida, leito
   	FROM consulta NATURAL JOIN descricao_internacao
    	WHERE cpf_paciente = <cpf_paciente>;


-- Consulta do histórico de cirurgias de um paciente
	SELECT cod_procedimento, data_procedimento, nome_procedimento, descricao,sala
 	FROM consulta NATURAL JOIN consulta_procedimento NATURAL JOIN dadoscirurgia
    	WHERE cpf_paciente = <cpf_paciente>;

-- Consulta do histórico de procedimentos de um paciente
	SELECT * FROM consulta
    	NATURAL JOIN consulta_procedimento
    	NATURAL JOIN procedimento
    	WHERE cpf_paciente = <cpf_paciente>;

-- Consulta do histórico de remédios de um paciente
	  SELECT e.nome_enfermidade, r.nome_remedio, r.indicacao, r.dosagem_maxima
FROM consulta
    	NATURAL JOIN consulta_enfermidade
    	NATURAL JOIN enfermidade_remedio
    	NATURAL JOIN dadosremedio r
    	NATURAL JOIN enfermidade e
    	WHERE cpf_paciente = <cpf_paciente>;

-- Consulta do histórico de anamneses de um paciente
	SELECT * from consulta
    	NATURAL JOIN anamnese
    	WHERE cpf_paciente = <cpf_paciente>;


-- Consulta do histórico de enfermidades de um paciente
SELECT cod_enfermidade, nome_enfermidade, descricao
FROM (paciente p  INNER JOIN consulta c ON p.cpf = c.cpf_paciente)
NATURAL JOIN consulta_enfermidade
NATURAL JOIN enfermidade
NATURAL JOIN descricao_enfermidade
WHERE p.cpf = <cpf_paciente>

-- Consulta exames pendentes (requisitados mas não realizados) de um paciente
  	SELECT * FROM consulta
    	NATURAL JOIN consulta_procedimento
    	NATURAL JOIN procedimento
    	NATURAL JOIN exame
    	NATURAL JOIN descricao_procedimento
    	WHERE cpf_paciente = <cpf_paciente> AND dados IS NULL

-- Listando anamnese
	SELECT *
FROM anamnese
WHERE cpf_medico = <cpf_medico> AND cpf_paciente = <cpf_paciente> AND data_consulta BETWEEN <data_inicio> AND <data_fim>

-- Atualização
UPDATE pessoa set nome = <nome>, data_nascimento = <data_nascimento>, endereco = <endereco>, telefone = <telefone>, genero = <genero>
WHERE cpf = <cpf>;

UPDATE medico set crm = <crm> WHERE cpf = <cpf>;

UPDATE enfermeiro set coren = <coren> WHERE cpf = <cpf>;


-- Consulta da área de um profissional
SELECT cpf, area as Area
FROM matricula_area NATURAL JOIN profissional_saude
WHERE cpf = <cpf>

-- Receita um remédio (enfermidade)
INSERT INTO enfermidade_remedio VALUES (<cod_remedio>,<cod_enfermidade>)

-- Receita um remédio (internação)
INSERT INTO internacao_remedio VALUES (<cpf_medico>,<cpf_paciente>, <data_consulta>, <data_entrada>, <cod_remedio>, <data_administração>, <cpf_profissional>, <dosagem>)

-- Fechar um internação
UPDATE descricao_internacao
SET data_saida = COALESCE(data_saida, <data_saida>)
WHERE cpf_medico = <cpf_medico> AND cpf_paciente = <cpf_paciente> AND
data_consulta = <data_consulta> AND data_entrada = <data_consulta>

-- Consultar quanto tempo levou uma internação
SELECT data_saida - data_entrada
FROM internacao NATURAL JOIN descricao_internacao
WHERE cpf_medico = <cpf_medico>
AND cpf_paciente = <cpf_paciente>
AND data_consulta = <data_consulta>
AND data_entrada = <data_entrada>


-- Busca de internação por data
-- Data da consulta
SELECT  inter.data_consulta, inter.data_entrada, med.nome as medico, pac.nome as paciente
FROM     internacao inter, dadosmedico med, dadospaciente pac
WHERE   	  inter.cpf_medico     = <cpf_medico>    	 AND
   	 inter.cpf_paciente     = <cpf_paciente>     AND
   	 inter.data_consulta = <data_consulta>     AND
   	 inter.cpf_medico    = med.cpf   		 AND
   	 inter.cpf_paciente     = pac.cpf
-- Data de Entrada
SELECT  inter.data_consulta, inter.data_entrada, med.nome as medico,
pac.nome AS paciente
FROM     internacao inter, dadosmedico med, dadospaciente pac
WHERE    	 inter.cpf_medico     = <cpf_medico>    	 AND
   	 inter.cpf_paciente     = <cpf_paciente>     AND
   	 inter.data_entrada     = <data_entrada>     AND
   	 inter.cpf_medico     = med.cpf   		 AND
   	 inter.cpf_paciente     = pac.cpf

-- Consultar dados de uma administração
SELECT ir.data_consulta, ir.data_entrada,ir.data_administracao, med.nome AS medico,
pac.nome AS paciente, prof.nome as profissional, r.nome_remedio,
ir.dosagem
FROM internacao_remedio ir, dadosmedico med, dadospaciente pac, dadosprofissional prof,  remedio r
WHERE   	 ir.cpf_medico    	 = <cpf_medico>    		 AND
   	 ir.cpf_paciente    	 = <cpf_paciente>   	 AND
   	 ir.data_consulta    	 = <data_consulta>   	 AND
   	 ir.data_entrada    	 = <data_entrada>   	 AND
   	 ir.cod_remedio   	 = <cod_remedio>   		 AND
   	 ir.data_administracao    = <data_administracao>    AND
   	 ir.cpf_medico    	 = med.cpf   			 AND
   	 ir.cpf_paciente    	 = pac.cpf           	AND
    	ir.cpf_profissional  	  = prof.cpf            	AND
   	 ir.cod_remedio = r.cod_remedio

-- Consultar o profissional de saúde que administrou um remédio
SELECT ir.data_consulta, ir.data_entrada, med.nome AS medico,
pac.nome AS paciente, prof.nome as profissional, r.nome_remedio,
ir.dosagem
FROM internacao_remedio ir, (pessoa NATURAL JOIN profissional_saude) prof,
   						 remedio r
WHERE     ir.cpf_medico    		 = <cpf_medico>    		 AND
   	 ir.cpf_paciente    	 = <cpf_paciente>   	 AND
   	 ir.data_consulta    	 = <data_consulta>   	 AND
   	 ir.data_entrada    	 = <data_entrada>   	 AND
   	 ir.cod_remedio   		 = <cod_remedio>   		 AND
   	 ir.data_administracao    = <data_administracao>    AND
   	 ir.cpf_profissional   	 = prof.cpf

-- Consulta todas os remédios administrados durante uma internação
SELECT ir.data_administracao, prof.nome as profissional, r.nome_remedio, r.indicacao, ir.dosagem
FROM internacao_remedio ir, dadosprofissional prof, dadosremedio r
WHERE   	ir.cpf_medico    	 = <cpf_medico>    	AND
   	 ir.cpf_paciente    	 = <cpf_paciente>   	 AND
   	 ir.data_consulta    	 = <data_consulta>   	 AND
   	 ir.data_entrada    	 = <data_entrada>   	 AND
   	 ir.cpf_profissional 	= prof.cpf		 AND
   	 ir.cod_remedio 	= r.cod_remedio
-- Procedimento
-- Consultar Detalhes de um procedimento
SELECT    pac.nome as paciente, med.nome as medico, prof.nome as quemrealizou, prof.area, proc.nome_procedimento, proc.descricao, proc.data_procedimento
FROM     dadosprocedimento as proc NATURAL JOIN consulta_procedimento cp NATURAL JOIN profissional_procedimento pp,  dadosmedico med,dadospaciente pac, dadosprofissional prof
WHERE     cp.cod_procedimento = <cod_procedimento>    AND
   	 cp.cpf_paciente = pac.cpf   		 AND
   	 cp.cpf_medico = med.cpf   			 AND
   	 pp.cpf = prof.cpf

-- Consultar profissionais que fizeram um procedimento
SELECT    proc.cod_procedimento, prof.nome, prof.matricula, prof.area
FROM     dadosprocedimento proc NATURAL JOIN profissional_procedimento pp, dadosprofissional prof
WHERE    proc.cod_procedimento = <cod_procedimento> AND
    		pp.cpf = prof.cpf

-- Consultar todos os procedimentos referentes a uma consulta
SELECT proc.cod_procedimento, proc.nome_procedimento, proc.descricao, proc.data_procedimento
FROM consulta_procedimento cp, dadosprocedimento proc
WHERE cp.cpf_medico = <cpf_medico> AND
    	cp.cpf_paciente = <cpf_paciente> AND
    	cp.data_consulta = <data_consulta> AND
    	cp.cod_procedimento = proc.cod_procedimento
ORDER BY proc.data_procedimento

-- Consultar procedimentos que não foram realizados por um profissional de uma certa área
SELECT proc.cod_procedimento, nome_procedimento, data_procedimento, prof.cpf, nome, area
FROM dadosprocedimento proc NATURAL JOIN profissional_procedimento NATURAL JOIN dadosprofissional prof
WHERE area <> <area>'
Cirurgia
Inserir uma Cirurgia
INSERT INTO cirurgia VALUES (<cod_procedimento>, <sala>);

-- Consultar cirurgias em um dia por horário
SELECT    c.data_procedimento, c.cod_procedimento, c.nome_procedimento,  c.sala
FROM    dadoscirurgia c
WHERE    c.data_procedimento BETWEEN <data1> and <data2>

-- Consultar cirurgias em uma sala
SELECT    c.cod_procedimento, c.nome_procedimento, c.data_procedimento
FROM    dadoscirurgia c
WHERE    c.sala = <sala>
Exame

-- Inserir informações de um Exame
UPDATE exame WHERE cod_procedimento = <cod_exame> SET dados = <dados>
