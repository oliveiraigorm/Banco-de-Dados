CREATE DATABASE controle_navio;

CREATE TABLE navio(
	nnome varchar(60),
	proprietario varchar(60),
	tipo varchar(60),
	portoNome varchar(60),
	CONSTANT pk_navio PRIMARY KEY (nnome),
	CONSTANT fk_navio FOREIGN KEY (tipo),
	CONSTANT fk_navio2 FOREIGN KEY (portoNome)
);

CREATE TABLE tipo_navio(
	tipo varchar(60),
	proprietario varchar(60),
	CONSTANT pk_tiponavio PRIMARY KEY (tipo)
);

CREATE TABLE estado_pais(
	nome varchar(60),
	continente varchar(60),
	CONSTANT pk_ep PRIMARY KEY (nome)
);

CREATE TABLE agua(
	nome varchar(60),
	CONSTANT pk_agua PRIMARY KEY (nome)
);

CREATE TABLE porto(
	pjnome varchar(60),
	epnome varchar(60),
	aguaNome varchar(60),
	CONSTANT pk_porto PRIMARY KEY (pjnome),
	CONSTANT fk_porto FOREIGN KEY (epnome),
	CONSTANT fk_porto2 FOREIGN KEY (aguaNome)
	
);

CREATE TABLE movimeto(
	timeST timestamp,
	longitude integer,
	latitude integer,
	navNome varchar(60),
	CONSTANT pk_mov PRIMARY KEY (timeST),
	CONSTANT fk_mov FOREIGN KEY (navNome)
);

CREATE TABLE visita(
	dataChegada timestamp,
	dataPartida timestamp,
	navNome varchar(60),
	portoNome varchar(60),
	CONSTANT pk_visita PRIMARY KEY (dataChegada),
	CONSTANT fk_visita FOREIGN KEY (navNome),
	CONSTANT fk_visita2 FOREIGN KEY (portoNome),
);