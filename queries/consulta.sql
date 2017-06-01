
-- Consultas   
-- Inserção     
    INSERT INTO consulta VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <tipo>);

-- Consultar consultas que não geraram procedimentos

    SELECT c.cpf_medico, c.cpf_paciente, c.data_consulta, tipo, nome_enfermidade
    FROM (consulta c NATURAL JOIN consulta_enfermidade NATURAL JOIN enfermidade)  LEFT JOIN consulta_procedimento cp
    ON  c.cpf_medico = cp.cpf_medico AND c.cpf_paciente = cp.cpf_paciente AND c.data_consulta = cp.data_consulta 
    WHERE cod_procedimento is null
    
-- Consultar consultas que geraram procedimentos
    Select c.cpf_medico, c.cpf_paciente, c.data_consulta, tipo, nome_enfermidade, cp.cod_procedimento, nome_procedimento, data_procedimento
    From (consulta c NATURAL JOIN consulta_enfermidade NATURAL JOIN enfermidade)  INNER JOIN (consulta_procedimento cp NATURAL JOIN procedimento)
    ON  c.cpf_medico = cp.cpf_medico AND c.cpf_paciente = cp.cpf_paciente AND c.data_consulta = cp.data_consulta 