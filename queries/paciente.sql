-- Paciente

-- Inserção
    INSERT INTO pessoa VALUES (<cpf>, <nome>, <data_nascimento>, <endereco>, <telefone>, <genero>);
    INSERT INTO paciente  VALUES (<cpf>, <ocupacao>, <etnia>, <local_nascimento>, <escolaridade>, <religiao>, <convenio>);

-- Atualização
    UPDATE paciente SET ocupacao = <ocupacao>, 
                        etnia = <etnia>,
                        local_nascimento = <local_nascimento>, 
                        escolaridade = <escolaridade>, 
                        religiao = <religiao>, 
                        convenio = <convenio> WHERE cpf = <cpf>;

-- Consulta

    -- Consulta de dados de um paciente
    SELECT * 
    FROM paciente NATURAL JOIN pessoa 
    WHERE cpf = <cpf>;

    -- Consulta do histórico de consultas de um paciente
    SELECT * 
    FROM consulta 
    WHERE cpf_paciente = <cpf_paciente>;

    -- Consulta do histórico de exames de um paciente
    SELECT * FROM consulta 
        NATURAL JOIN consulta_procedimento
        NATURAL JOIN procedimento
        NATURAL JOIN exame 
        WHERE cpf_paciente = <cpf_paciente>;

    -- Consulta do histórico de internações de um paciente
    SELECT * FROM consulta
        NATURAL JOIN descricao_internacao
        WHERE cpf_paciente = <cpf_paciente>;


    -- Consulta do histórico de cirurgias de um paciente
    SELECT * FROM consulta
        NATURAL JOIN consulta_procedimento
        NATURAL JOIN procedimento
        NATURAL JOIN cirurgia
        WHERE cpf_paciente = <cpf_paciente>;
    

    -- Consulta do histórico de procedimentos de um paciente
    SELECT * FROM consulta
        NATURAL JOIN consulta_procedimento
        NATURAL JOIN procedimento
        WHERE cpf_paciente = <cpf_paciente>;

    -- Consulta do histórico de remédios de um paciente
    SELECT r.nome_remedio, dr.indicacao, dr.dosagem_maxima FROM consulta
        NATURAL JOIN consulta_enfermidade
        NATURAL JOIN enfermidade_remedio
        NATURAL JOIN remedio r
        NATURAL JOIN descricao_remedio dr
        WHERE cpf_paciente = <cpf_paciente>;


    -- Consulta do histórico de anamneses de um paciente
    SELECT * from consulta
        NATURAL JOIN anamnese
        NATURAL JOIN anamnese_enfermidade
        NATURAL JOIN enfermidade
        NATURAL JOIN enfermidade_remedio
        NATURAL JOIN remedio
        WHERE cpf_paciente = <cpf_paciente>;        
        
        
    -- Consulta exames nao realizados de um paciente
      SELECT * FROM consulta 
        NATURAL JOIN consulta_procedimento
        NATURAL JOIN procedimento
        NATURAL JOIN exame 
        NATURAL JOIN descricao_procedimento
        WHERE cpf_paciente = <cpf_paciente> AND dados IS NULL  
    