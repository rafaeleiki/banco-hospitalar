-- Anamnese

-- Inserção
    INSERT INTO anamnese VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <pressao>, <temperatura>, <batimentos>, <queixas>, <comentarios>, <recomendacoes>);
    INSERT INTO anamnese_enfermidade VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <cod_enfermidade>);
    INSERT INTO anamnese_remedio VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <cod_remedio>);

-- Consulta
    
    -- Listando anamnese sem remedios e enfermidades
    SELECT * FROM anamnese WHERE cpf_medico = <cpf_medico> AND cpf_paciente = <cpf_paciente> AND data_consulta BETWEEN <data_inicio> AND <data_fim>

    -- Listando anamnese com remedios e enfermidades
    SELECT * FROM anamnese a 
        INNER JOIN anamnese_enfermidade ae ON a.cpf_paciente = ae.cpf_paciente    
	    INNER JOIN enfermidade e ON ae.cod_enfermidade = e.cod_enfermidade
	    INNER JOIN anamnese_remedio ar ON a.cpf_paciente = ar.cpf_paciente
	    INNER JOIN remedio r ON ar.cod_remedio = r.cod_remedio
        WHERE a.cpf_medico = <cpf_medico> AND a.cpf_paciente = <cpf_paciente> AND a.data_consulta BETWEEN <data_inicio> AND <data_fim>

    -- Histórico de remédios e enfermidades relatados durante a anamnese de um paciente
    SELECT r.nome_remedio AS Remedio, e.nome_enfermidade AS Enfermidade, a.data_consulta AS Data FROM anamnese a
        INNER JOIN anamnese_enfermidade ae ON a.cpf_paciente = ae.cpf_paciente
        INNER JOIN enfermidade e ON ae.cod_enfermidade = e.cod_enfermidade
        INNER JOIN anamnese_remedio ar ON a.cpf_paciente = ar.cpf_paciente
        INNER JOIN remedio r ON ar.cod_remedio = r.cod_remedio
        WHERE a.cpf_medico = <cpf_medico> AND a.cpf_paciente = <cpf_paciente> AND a.data_consulta BETWEEN <data_inicio> AND <data_fim>





