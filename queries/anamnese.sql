-- Anamnese

    -- Inserção
    INSERT INTO anamnese VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <pressao>, <temperatura>, <batimentos>, <queixas>, <comentarios>, <recomendacoes>);


-- Consulta

    -- Listando anamnese
    CREATE OR REPLACE FUNCTION lista_anamnese_periodo(data_inicio timestamp, data_fim timestamp)
      RETURNS SETOF anamnese
      AS
      'SELECT *
        FROM anamnese
        WHERE data_consulta BETWEEN data_inicio AND data_fim'
      LANGUAGE 'sql';

    CREATE OR REPLACE FUNCTION lista_anamnese_medico_paciente_periodo(
        param_cpf_medico varchar, param_cpf_paciente varchar,
        data_inicio timestamp, data_fim timestamp)
      RETURNS SETOF anamnese
      AS
      'SELECT *
        FROM lista_anamnese_periodo(data_inicio, data_fim)
        WHERE cpf_medico = param_cpf_medico
          AND cpf_paciente = param_cpf_paciente'
      LANGUAGE 'sql';

    CREATE OR REPLACE FUNCTION historico_anamnese_paciente(param_cpf_paciente varchar)
      RETURNS SETOF anamnese
      AS
      'SELECT * FROM anamnese WHERE cpf_paciente = param_cpf_paciente'
      LANGUAGE 'sql';
