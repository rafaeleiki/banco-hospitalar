INSERT INTO anamnese VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <pressao>,
            <temperatura>,
            <batimentos>,
            <queixas>,
            <comentarios>,
            <recomendacoes>);

INSERT INTO pessoa VALUES (
            <cpf>,
            <ocupacao>,
            <etnia>,
            <local_nascimento>,
            <escolaridade>,
            <religiao>,
            <convenio>);

INSERT INTO paciente VALUES (
            <cpf>,
            <ocupacao>,
            <etnia>,
            <local_nascimento>,
            <escolaridade>,
            <religiao>,
            <convenio>);

INSERT INTO matricula_area VALUES (
            <matricula>,
            <area>);

INSERT INTO profissional_saude VALUES (
            <cpf>,
            <matricula>);

INSERT INTO medico VALUES (
            <cpf>,
            <crm>);

INSERT INTO enfermeiro VALUES (
            <cpf>,
            <coren>);

INSERT INTO consulta VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <tipo>);

INSERT INTO anamnese VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <pressao>,
            <temperatura>,
            <batimentos>,
            <queixas>,
            <comentarios>,
            <hipoteses>,
            <recomendacoes>);

INSERT INTO enfermidade VALUES (
            <cod_enfermidade>,
            <nome_enfermidade>);

INSERT INTO descricao_enfermidade VALUES (
            <cod_enfermidade>,
            <descricao>);

INSERT INTO remedio VALUES (
            <cod_remedio>,
            <nome_remedio>);

INSERT INTO descricao_remedio VALUES (
            <cod_remedio>,
            <indicacao>,
            <dosagem_maxima>);

INSERT INTO internacao VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <data_entrada>);

INSERT INTO descricao_internacao VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <data_entrada>,
            <data_saida>,
            <leito>);

INSERT INTO procedimento VALUES (
            <cod_procedimento>,
            <nome_procedimento>,
            <data_procedimento>);

INSERT INTO descricao_procedimento VALUES (
            <cod_procedimento>,
            <descricao>);

INSERT INTO exame VALUES (
            <cod_procedimento>,
            <dados>);

INSERT INTO cirurgia VALUES (
            <cod_procedimento>,
            <sala>);

INSERT INTO consulta_enfermidade VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <cod_enfermidade>);

INSERT INTO enfermidade_remedio VALUES (
            <cod_enfermidade>,
            <cod_remedio>);

INSERT INTO consulta_procedimento VALUES (
            <cod_procedimento>,
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>);

INSERT INTO profissional_procedimento VALUES (
            <cpf>,
            <cod_procedimento>);

INSERT INTO internacao_remedio VALUES (
            <cpf_medico>,
            <cpf_paciente>,
            <data_consulta>,
            <data_entrada>,
            <cod_remedio>,
            <data_administracao>,
            <cpf_profissional>,
            <dosagem>);
