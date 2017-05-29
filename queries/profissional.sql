-- Profissional

-- Inserção
    INSERT INTO pessoa VALUES (<cpf>, <nome>, <data_nascimento>, <endereco>, <telefone>, <genero>);
    
    INSERT INTO profissional_saude VALUES (<cpf>, <matricula>);

    INSERT INTO medico VALUES (<cpf>, <crm>);

    INSERT INTO enfermeiro VALUES (<cpf>, <coren>);

-- Atualização
    UPDATE pessoa set nome = <nome>, data_nascimento = <data_nascimento>, endereco = <endereco>, telefone = <telefone>, genero = <genero>
        WHERE cpf = <cpf>;

    UPDATE medico set crm = <crm> WHERE cpf = <cpf>;

    UPDATE enfermeiro set coren = <coren> WHERE cpf = <cpf>;

-- Consulta 
    -- Consulta da área de um profissional 
    SELECT ma.area as Area from matricula_area NATURAL JOIN profissional_saude WHERE cpf = <cpf>