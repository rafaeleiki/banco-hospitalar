SELECT * FROM cirurgias_na_sala('1');
SELECT * FROM internacao_medico_paciente_data_consulta('45793412345', '24598398512', '2013-01-31 05:26:56.66-02');
SELECT * FROM procedimentos_paciente('23445621412');
SELECT * FROM remedios_paciente('13894002932');
SELECT * FROM consultas_geram_procedimentos;
SELECT * FROM consultas_nao_geram_procedimentos;
SELECT * FROM dados_profissional_especializado;
SELECT * FROM lista_anamnese_periodo('2012-01-01', '2015-12-31');
SELECT * FROM lista_anamnese_medico_paciente_periodo('45793412345', '24598398512', '2013-01-30', '2013-03-30');
SELECT * FROM historico_anamnese_paciente('24598398512');
SELECT * FROM remedios_na_internacao('45793412345', '12355566634', '2011-05-11 07:56:33.66-03', '2011-05-11 08:06:11.23-03');
SELECT * FROM exames_paciente_periodo('34111122200', '2014-04-01', '2014-04-30');
SELECT * FROM dadosmedico WHERE cpf = '39809294201';
SELECT * FROM dadosremedio WHERE indicacao ILIKE '%anestesico%';
SELECT * FROM dadosmedico WHERE endereco NOT LIKE '%Campinas%';
SELECT COUNT(*) FROM exames_pendentes
  WHERE data_procedimento BETWEEN data_consulta AND data_consulta + interval '1 day';
SELECT area, COUNT(area)
  FROM matricula_area
  GROUP BY area;
