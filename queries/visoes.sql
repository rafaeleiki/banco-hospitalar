-- Visoes 

    -- Dados completos de um profissional da saude

        CREATE VIEW dadosprofissional AS
        SELECT *
        FROM pessoa NATURAL JOIN profissional_saude NATURAL JOIN matricula_area
        
    -- Dados completos de um medico

        CREATE VIEW dadosmedico AS
        SELECT *
        FROM pessoa NATURAL JOIN profissional_saude NATURAL JOIN matricula_area NATURAL JOIN medico
        
     -- Dados completos de um paciente

        CREATE VIEW dadospaciente AS
        SELECT *
        FROM pessoa NATURAL JOIN paciente
        