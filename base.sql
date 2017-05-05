-- Base para a criação do banco de dados
CREATE TABLE pessoa (
  cpf varchar(11) PRIMARY KEY,
  nome text NOT NULL,
  data_nascimento timestamp WITH TIME ZONE NOT NULL,
  endereco text NOT NULL,
  telefone varchar(20) NOT NULL,
  genero char NOT NULL
);

CREATE TABLE paciente (
  cpf varchar(11) PRIMARY KEY REFERENCES pessoa(cpf),
  ocupacao varchar(100),
  etnia varchar(20),
  local_nascimento varchar(50),
  escolaridade varchar(50),
  religiao varchar(20),
  convenio varchar(20) NOT NULL
);

CREATE TABLE matricula_area (
  matricula varchar(20) PRIMARY KEY,
  area varchar(50) NOT NULL
);

CREATE TABLE profissional_saude (
  cpf varchar(11) PRIMARY KEY REFERENCES pessoa(cpf),
  matricula varchar(20) UNIQUE NOT NULL REFERENCES matricula_area(matricula)
);

CREATE TABLE medico (
  cpf varchar(11) PRIMARY KEY REFERENCES pessoa(cpf),
  crm varchar(20) UNIQUE NOT NULL
);

CREATE TABLE enfermeiro (
  cpf varchar(11) PRIMARY KEY REFERENCES pessoa(cpf),
  coren varchar(20) UNIQUE NOT NULL
);

CREATE TABLE consulta (
  cpf_medico varchar(11) REFERENCES medico(cpf),
  cpf_paciente varchar(11) REFERENCES paciente(cpf),
  data_consulta timestamp WITH TIME ZONE,
  tipo text NOT NULL,
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta)
);

CREATE TABLE anamnese (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  pressao integer NOT NULL,
  temperatura integer NOT NULL,
  batimentos integer NOT NULL,
  queixas text NOT NULL,
  comentarios text,
  hipoteses text,
  recomendacoes text,
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta)
);

CREATE TABLE enfermidade (
  cod_enfermidade integer PRIMARY KEY,
  nome_enfermidade varchar(50) NOT NULL
);

CREATE TABLE descricao_enfermidade (
  cod_enfermidade integer PRIMARY KEY REFERENCES enfermidade(cod_enfermidade),
  descricao text NOT NULL
);

CREATE TABLE remedio (
  cod_remedio integer PRIMARY KEY,
  nome_remedio varchar(50) NOT NULL
);

CREATE TABLE descricao_remedio (
  cod_remedio integer PRIMARY KEY REFERENCES remedio(cod_remedio),
  indicacao text,
  dosagem_maxima varchar(50)
);

CREATE TABLE internacao (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  data_entrada timestamp WITH TIME ZONE,
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta, data_entrada)
);

CREATE TABLE descricao_internacao (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_entrada timestamp WITH TIME ZONE,
  data_saida timestamp WITH TIME ZONE,
  leito varchar(50) NOT NULL,
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_entrada)
);

CREATE TABLE procedimento (
  cod_procedimento integer PRIMARY KEY,
  nome_procedimento varchar(50) NOT NULL,
  data_procedimento timestamp WITH TIME ZONE NOT NULL
);

CREATE TABLE descricao_procedimento (
  cod_procedimento integer PRIMARY KEY REFERENCES procedimento(cod_procedimento),
  descricao text NOT NULL
);

CREATE TABLE exame (
  cod_procedimento integer PRIMARY KEY REFERENCES procedimento(cod_procedimento),
  dados bytea NOT NULL
);

CREATE TABLE cirurgia (
  cod_procedimento integer PRIMARY KEY REFERENCES procedimento(cod_procedimento),
  sala varchar(15) NOT NULL
);

CREATE TABLE anamnese_enfermidade (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  cod_enfermidade integer REFERENCES enfermidade(cod_enfermidade),
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta, cod_enfermidade)
);

CREATE TABLE consulta_enfermidade (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  cod_enfermidade integer REFERENCES enfermidade(cod_enfermidade),
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cpf_medico, cpf_medico, data_consulta, cod_enfermidade)
);

CREATE TABLE anamnese_remedio (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  cod_remedio integer REFERENCES remedio(cod_remedio),
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta, cod_remedio)
);

CREATE TABLE enfermidade_remedio (
  cod_enfermidade integer REFERENCES enfermidade(cod_enfermidade),
  cod_remedio integer REFERENCES remedio(cod_remedio),
  PRIMARY KEY(cod_enfermidade, cod_remedio)
);

CREATE TABLE consulta_procedimento (
  cod_procedimento integer REFERENCES procedimento(cod_procedimento),
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta)
    REFERENCES consulta(cpf_medico, cpf_paciente, data_consulta),
  PRIMARY KEY(cod_procedimento, cpf_medico, cpf_paciente, data_consulta)
);

CREATE TABLE profissional_procedimento (
  cpf varchar(11) REFERENCES profissional_saude(cpf),
  cod_procedimento integer REFERENCES procedimento(cod_procedimento),
  PRIMARY KEY(matricula, cod_procedimento)
);

CREATE TABLE internacao_remedio (
  cpf_medico varchar(11),
  cpf_paciente varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  data_entrada timestamp WITH TIME ZONE,
  cod_remedio integer REFERENCES remedio(cod_remedio),
  data_administracao timestamp WITH TIME ZONE,
  cpf_profissional varchar(11) REFERENCES profissional_saude(cpf) NOT NULL,
  dosagem varchar(20) NOT NULL,
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta, data_entrada)
    REFERENCES internacao(cpf_medico, cpf_paciente, data_consulta, data_entrada),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta,
    data_entrada, cod_remedio, data_administracao)
);

CREATE TABLE internacao_cirurgia (
  cpf_medico varchar(11),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  data_entrada timestamp WITH TIME ZONE,
  cod_procedimento integer REFERENCES cirurgia(cod_procedimento),
  FOREIGN KEY(cpf_medico, cpf_paciente, data_consulta, data_entrada)
    REFERENCES internacao(cpf_medico, cpf_paciente, data_consulta, data_entrada),
  PRIMARY KEY(cpf_medico, cpf_paciente, data_consulta, data_entrada, cod_procedimento)
);
