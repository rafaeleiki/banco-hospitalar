-- Anamnese

    -- Inserção
    INSERT INTO anamnese VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <pressao>, <temperatura>, <batimentos>, <queixas>, <comentarios>, <recomendacoes>);
    

-- Consulta
    
    -- Listando anamnese
    SELECT * 
    FROM anamnese 
    WHERE cpf_medico = <cpf_medico> AND 
          cpf_paciente = <cpf_paciente> AND data_consulta BETWEEN <data_inicio> AND <data_fim>
