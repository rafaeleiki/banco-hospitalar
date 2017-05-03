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
  crm varchar(20) REFERENCES medico(crm),
  cpf varchar(11) REFERENCES paciente(cpf),
  data_consulta timestamp WITH TIME ZONE,
  tipo text,
  PRIMARY KEY(crm, cpf, data_consulta)
);

CREATE TABLE anamnese (
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  pressao integer,
  temperatura integer,
  batimentos integer,
  queixas text,
  comentarios text,
  hipoteses text,
  recomendacoes text,
  FOREIGN KEY(crm, cpf, data_consulta) REFERENCES consulta(crm, cpf, data_consulta),
  PRIMARY KEY(crm, cpf, data_consulta)
);

CREATE TABLE enfermidade (
  cod_enfermidade integer PRIMARY KEY,
  nome_enfermidade varchar(50) NOT NULL,
  descricao_enfermidade text
);

CREATE TABLE remedio (
  cod_remedio integer PRIMARY KEY,
  nome_remedio varchar(50) NOT NULL,
  indicacao text,
  dosagem_maxima varchar(50)
);

CREATE TABLE internacao (
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  data_entrada timestamp WITH TIME ZONE,
  data_saida timestamp WITH TIME ZONE,
  leito varchar(50) NOT NULL,
  FOREIGN KEY(crm, cpf, data_consulta) REFERENCES consulta(crm, cpf, data_consulta),
  PRIMARY KEY(crm, cpf, data_consulta, data_entrada)
);

CREATE TABLE procedimento (
  cod_procedimento integer PRIMARY KEY,
  nome_procedimento varchar(50) NOT NULL,
  data_procedimento timestamp WITH TIME ZONE NOT NULL,
  descricao_procedimento text
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
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  cod_enfermidade integer REFERENCES enfermidade(cod_enfermidade),
  FOREIGN KEY(crm, cpf, data_consulta) REFERENCES consulta(crm, cpf, data_consulta),
  PRIMARY KEY(crm, cpf, data_consulta, cod_enfermidade)
);

CREATE TABLE consulta_enfermidade (
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  cod_enfermidade integer REFERENCES enfermidade(cod_enfermidade),
  FOREIGN KEY(crm, cpf, data_consulta) REFERENCES consulta(crm, cpf, data_consulta),
  PRIMARY KEY(crm, cpf, data_consulta, cod_enfermidade)
);

CREATE TABLE anamnese_remedio (
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  cod_remedio integer REFERENCES remedio(cod_remedio),
  FOREIGN KEY(crm, cpf, data_consulta) REFERENCES consulta(crm, cpf, data_consulta),
  PRIMARY KEY(crm, cpf, data_consulta, cod_remedio)
);

CREATE TABLE enfermidade_remedio (
  cod_enfermidade integer REFERENCES enfermidade(cod_enfermidade),
  cod_remedio integer REFERENCES remedio(cod_remedio),
  PRIMARY KEY(cod_enfermidade, cod_remedio)
);

CREATE TABLE consulta_procedimento (
  cod_procedimento integer PRIMARY KEY REFERENCES procedimento(cod_procedimento),
  crm varchar(20) NOT NULL,
  cpf varchar(11) NOT NULL,
  data_consulta timestamp WITH TIME ZONE NOT NULL,
  FOREIGN KEY(crm, cpf, data_consulta) REFERENCES consulta(crm, cpf, data_consulta)
);

CREATE TABLE profissional_procedimento (
  matricula varchar(20) REFERENCES matricula_area(matricula),
  cod_procedimento integer REFERENCES procedimento(cod_procedimento),
  PRIMARY KEY(matricula, cod_procedimento)
);

CREATE TABLE internacao_remedio (
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  data_entrada timestamp WITH TIME ZONE,
  cod_remedio integer REFERENCES remedio(cod_remedio) NOT NULL,
  matricula varchar(20) REFERENCES matricula_area(matricula) NOT NULL,
  dosagem varchar(20) NOT NULL,
  data_administracao timestamp WITH TIME ZONE NOT NULL,
  FOREIGN KEY(crm, cpf, data_consulta, data_entrada)
    REFERENCES internacao(crm, cpf, data_consulta, data_entrada),
  PRIMARY KEY(crm, cpf, data_consulta, data_entrada)
);

CREATE TABLE internacao_cirurgia (
  crm varchar(20),
  cpf varchar(11),
  data_consulta timestamp WITH TIME ZONE,
  data_entrada timestamp WITH TIME ZONE,
  cod_procedimento integer REFERENCES cirurgia(cod_procedimento),
  FOREIGN KEY(crm, cpf, data_consulta, data_entrada)
    REFERENCES internacao(crm, cpf, data_consulta, data_entrada),
  PRIMARY KEY(crm, cpf, data_consulta, data_entrada)
);
