-- Base para a criação do banco de dados
CREATE TABLE pessoa (
  cpf varchar(11) PRIMARY KEY,
  nome text not null,
  data_nascimento timestamp WITH TIME ZONE not null,
  endereco text not null,
  telefone varchar(20) not null,
  genero char not null
);

CREATE TABLE paciente (
  cpf varchar(11) PRIMARY KEY REFERENCES Pessoa(cpf),
  ocupacao varchar(100) not null,
  etnia varchar(20) not null,
  local_nascimento varchar(50) not null,
  escolaridade varchar(50) not null,
  religiao varchar(20),
  convenio varchar(20) not null
);

CREATE TABLE profissional_saude (
  cpf varchar(11) PRIMARY KEY REFERENCES Pessoa(cpf),
  matricula varchar(20) not null,
  area varchar(50) not null
);

CREATE TABLE medico (
  cpf varchar(11) REFERENCES Pessoa(cpf),
  crm varchar(20),
  PRIMARY KEY(cpf, crm)
);

CREATE TABLE enfermeiro (
  cpf varchar(11) REFERENCES Pessoa(cpf),
  coren varchar(20),
  PRIMARY KEY(cpf, coren)
);
