CREATE DATABASE universidade;
CREATE TABLE aluno(
	nome varchar(60),
	numero integer,
	cpf varchar(11),
	turma varchar(11),
	datanascimento timestamp,
	dptoprim varchar(11),
	dptosec varchar(11),
	CONSTRAINT pk_aluno PRIMARY KEY
	(cpf),
	CONSTRAINT fk_aluno1 FOREIGN KEY
	(dptoprim),
	CONSTRAINT fk_aluno2 FOREIGN KEY
	(dptoprim)
	);
CREATE TABLE endereco(
	nu_cpf varchar(11),
	cep integer,
	estado varchar(11),
	cidade varchar(11),
	CONSTRAINT fk_endereco FOREIGN KEY (nu_cpf)
	);
CREATE TABLE telefone(
	telefone varchar(13),
	nu_cpf varchar(11),
	CONSTRAINT fk_tel FOREIGN KEY (nu_cpf)
	);
CREATE TABLE departamento(
	nome varchar(60),
	codigo varchar(11),
	numero integer,
	faculdade varchar(11),
	CONSTRAINT pk_dpto PRIMARY KEY
	(codigo)
	);

CREATE TABLE curso(
	nome varchar(60),
	numero varchar(11),
	descricao varchar(300),
	programacurso varchar(300),
	nivel integer,
	horas integer,
	CONSTRAINT pk_curso PRIMARY KEY
	(numero)
	);
CREATE TABLE disciplina(
	instrutor varchar(60),
	semestre integer,
	numero integer,
	ano integer
	);
CREATE TABLE historico(
	conceito varchar(1),
	numero integer,
	nu_cpf varchar(11),
	num_disc integer,
	CONSTRAINT fk_hist1 FOREIGN KEY (nu_cpf),
	CONSTRAINT fk_hist2 FOREIGN KEY (num_disc)
	);
	