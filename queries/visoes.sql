-- Visoes

    -- Dados completos de um profissional da saude

        CREATE OR REPLACE VIEW dadosprofissional AS
        SELECT *
        FROM pessoa NATURAL JOIN profissional_saude NATURAL JOIN matricula_area;

    -- Dados completos de um profissional da saude que não é médico ou enfermeiro

        CREATE OR REPLACE VIEW dados_profissional_especializado AS
        SELECT *
        FROM pessoa
          NATURAL JOIN (SELECT ps.cpf, ps.matricula FROM profissional_saude ps
            LEFT JOIN medico m ON m.cpf = ps.cpf
            LEFT JOIN enfermeiro e ON e.cpf = ps.cpf
            WHERE m.crm IS NULL AND e.coren IS NULL
          ) as profissional_especializado
          NATURAL JOIN matricula_area;

    -- Dados completos de um medico

        CREATE OR REPLACE VIEW dadosmedico AS
        SELECT *
        FROM pessoa NATURAL JOIN profissional_saude NATURAL JOIN matricula_area NATURAL JOIN medico;

     -- Dados completos de um paciente

        CREATE OR REPLACE VIEW dadospaciente AS
        SELECT *
        FROM pessoa NATURAL JOIN paciente;


     -- Dados completos de um remedio

        CREATE OR REPLACE VIEW dadosremedio AS
        SELECT *
        FROM remedio NATURAL JOIN descricao_remedio;

    -- Dados completos de uma enfermidade

        CREATE OR REPLACE VIEW dadosenfermidade AS
        SELECT *
        FROM enfermidade NATURAL JOIN descricao_enfermidade;

     -- Dados completos de um procedimento

        CREATE OR REPLACE VIEW dadosprocedimento AS
        SELECT *
        FROM procedimento NATURAL JOIN descricao_procedimento;

    -- Dados completos de uma cirurgia

        CREATE OR REPLACE VIEW dadoscirurgia AS
        SELECT *
        FROM dadosprocedimento NATURAL JOIN cirurgia;

    -- Consultas que não geraram procedimentos

        CREATE OR REPLACE VIEW consultas_nao_geram_procedimentos AS
        SELECT c.cpf_medico, c.cpf_paciente, c.data_consulta, tipo, nome_enfermidade
        FROM
        (consulta c
          NATURAL JOIN consulta_enfermidade
          NATURAL JOIN enfermidade)
        LEFT JOIN consulta_procedimento cp
          ON  c.cpf_medico = cp.cpf_medico
          AND c.cpf_paciente = cp.cpf_paciente
          AND c.data_consulta = cp.data_consulta
        WHERE cod_procedimento IS NULL;

    -- Consultas que geraram procedimentos
        CREATE OR REPLACE VIEW consultas_geram_procedimentos AS
        SELECT c.cpf_medico, c.cpf_paciente, c.data_consulta,
               tipo, nome_enfermidade, cp.cod_procedimento,
               nome_procedimento, data_procedimento
        FROM
        (consulta c
          NATURAL JOIN consulta_enfermidade
          NATURAL JOIN enfermidade)
        INNER JOIN
          (consulta_procedimento cp NATURAL JOIN procedimento)
          ON  c.cpf_medico = cp.cpf_medico
          AND c.cpf_paciente = cp.cpf_paciente
          AND c.data_consulta = cp.data_consulta;
