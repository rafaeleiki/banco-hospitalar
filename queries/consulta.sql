
-- Consultas
-- Inserção
    INSERT INTO consulta VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <tipo>);

-- Consulta do histórico de consultas de um paciente
    SELECT *
    FROM consulta
    WHERE cpf_paciente = <cpf_paciente>;
