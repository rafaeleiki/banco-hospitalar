-- Visoes

    -- Dados completos de um profissional da saude

        CREATE VIEW dadosprofissional AS
        SELECT *
        FROM pessoa NATURAL JOIN profissional_saude NATURAL JOIN matricula_area;

    -- Dados completos de um profissional da saude que não é médico ou enfermeiro

        CREATE VIEW dados_profissional_especializado AS
        SELECT *
        FROM pessoa
          NATURAL JOIN (SELECT ps.cpf, ps.matricula FROM profissional_saude ps
            LEFT JOIN medico m ON m.cpf = ps.cpf
            LEFT JOIN enfermeiro e ON e.cpf = ps.cpf
            WHERE m.crm IS NULL AND e.coren IS NULL
          ) as profissional_especializado
          NATURAL JOIN matricula_area;

    -- Dados completos de um medico

        CREATE VIEW dadosmedico AS
        SELECT *
        FROM pessoa NATURAL JOIN profissional_saude NATURAL JOIN matricula_area NATURAL JOIN medico;

     -- Dados completos de um paciente

        CREATE VIEW dadospaciente AS
        SELECT *
        FROM pessoa NATURAL JOIN paciente;


     -- Dados completos de um remedio

        CREATE VIEW dadosremedio AS
        SELECT *
        FROM remedio NATURAL JOIN descricao_remedio;

    -- Dados completos de uma enfermidade

        CREATE VIEW dadosenfermidade AS
        SELECT *
        FROM enfermidade NATURAL JOIN descricao_enfermidade;

     -- Dados completos de um procedimento

        CREATE VIEW dadosprocedimento AS
        SELECT *
        FROM procedimento NATURAL JOIN descricao_procedimento;

    -- Dados completos de uma cirurgia

        CREATE VIEW dadoscirurgia AS
        SELECT *
        FROM dadosprocedimento NATURAL JOIN cirurgia;
