-- Anamnese

    -- Inserção
    INSERT INTO anamnese VALUES (<cpf_medico>, <cpf_paciente>, <data_consulta>, <pressao>, <temperatura>, <batimentos>, <queixas>, <comentarios>, <recomendacoes>);


-- Consulta

    -- Listando anamnese
    SELECT *
      FROM anamnese
      WHERE data_consulta BETWEEN <data_inicio> AND <data_fim>;

    -- Anamneses de um médico com um paciente em um período
    SELECT *
      FROM lista_anamnese_periodo(data_inicio, data_fim)
      WHERE cpf_medico = <cpf_medico>
        AND cpf_paciente = <cpf_paciente>;

    -- Histórico de anamnese de um paciente
    SELECT * from consulta
        NATURAL JOIN anamnese
        WHERE cpf_paciente = <param_cpf_paciente>;

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
      RETURNS TABLE(
        cpf_medico varchar, cpf_paciente varchar, data_consulta timestamp with time zone,
        tipo text, pressao integer, temperatura integer, batimentos integer,
        queixas text, comentarios text, hipoteses text, recomendacoes text
      )
      AS
      'SELECT * from consulta
          NATURAL JOIN anamnese
          WHERE cpf_paciente = param_cpf_paciente'
      LANGUAGE 'sql';
