/*drop table costura;
drop table costureiro;
drop table detalhePedido;
drop table pedido;
drop table quantidade;
drop table material;
drop table traje;
drop table cliente;*/

CREATE TABLE cliente (
  id_cliente		INTEGER	PRIMARY KEY
 ,nm_cliente		CHAR(20)NOT NULL
 ,nu_casa_Cliente	INTEGER	NOT NULL
 ,nu_cep_Cliente	CHAR(9)	NOT NULL
 );

CREATE TABLE traje (
  id_traje			INTEGER	 PRIMARY KEY
 ,te_descricao_Traje		CHAR(20) NOT NULL
 ,vl_custo_Producao_Traje	REAL	 NOT NULL
 ,nm_detalhe_Traje		CHAR(60)
 );

CREATE TABLE material (
  id_material		INTEGER	PRIMARY KEY
 ,nm_material		CHAR(20)	NOT NULL
 ,nm_cor_Material	CHAR(20)	NOT NULL
 ,nm_padrao_Material	CHAR(20)	NOT NULL
 ,vl_custo_Material	REAL		NOT NULL
 );

CREATE TABLE quantidade (
  -- nu_tamanho is the UK dress size for the item in question. For example
  --   size 8,10,12,14,16 are all valid dress sizes.
  -- nu_quantidade is how many linear feet are needed to make the particular
  --   item. Material comes in a roll, and you get that many feet off the
  --   roll to make the item.
  id_traje	INTEGER NOT NULL REFERENCES traje
 ,nu_tamanho	INTEGER	NOT NULL
 ,nu_quantidade	REAL	NOT NULL
 ,PRIMARY KEY ( id_traje, nu_tamanho )
	);

CREATE TABLE pedido (
  id_pedido	INTEGER	PRIMARY KEY
 ,id_cliente	INTEGER REFERENCES cliente
 ,dt_pedido	DATE NOT NULL 
 ,in_finalizado	CHAR(1)
 );

CREATE TABLE detalhePedido (
  id_pedido	INTEGER	NOT NULL REFERENCES pedido
 ,id_detalhe_Pedido	INTEGER	NOT NULL
 ,id_traje	INTEGER	NOT NULL
 ,nu_tamanho	INTEGER	NOT NULL
 ,id_material	INTEGER	REFERENCES material
 ,PRIMARY KEY (id_pedido, id_detalhe_Pedido)
 ,FOREIGN KEY (id_traje, nu_tamanho) REFERENCES quantidade
 );

CREATE TABLE costureiro(
  id_costureiro		INTEGER	PRIMARY KEY
 ,nm_costureiro	CHAR(20)	NOT NULL
 ,nu_casa_Costureiro	INTEGER	NOT NULL
 ,nu_cep_Costureiro	CHAR(8)	NOT NULL
 );

CREATE TABLE costura (
  id_costureiro		INTEGER	NOT NULL REFERENCES costureiro
 ,id_pedido	INTEGER	NOT NULL
 ,id_detalhe_Pedido	INTEGER	NOT NULL
 ,dt_inicio_Costura DATE NOT NULL 
 ,dt_fim_Costura DATE 
 ,PRIMARY KEY ( id_costureiro, id_pedido, id_detalhe_Pedido )
 ,FOREIGN KEY ( id_pedido, id_detalhe_Pedido ) REFERENCES detalhePedido
 );

--- tabcliente, 1, 50
insert into cliente values (  1,'Sr Jorge',12,'30245839');
insert into cliente values (  2,'Sr Bruno',24,'40598382');
insert into cliente values (  3,'Sr Getulio',78,'90483746');
insert into cliente values (  4,'Sr Joao',25,'30240839');
insert into cliente values (  5,'Sr Breno',34,'29485736');
insert into cliente values (  6,'Sra Milla',31,'0394827');
insert into cliente values (  7,'Dr Petrus',3,'39485736');
insert into cliente values (  8,'Srta Patricia',100,'03948576');
--- tabtraje, 1, 50
insert into traje values (  1,'Calças',18.00,'2 Zipper/sem 1.5cm botões/bainha cinta/cintura atadura');
insert into traje values (  2,'Saia longa',15.00,'1 Zipper/sem botão 3cm/atadura ');
insert into traje values (  3,'Shorts',10.00,'Zipper/Fecho Clip ');
insert into traje values (  4,'Mini saia',14.25,'1 Zipper/sem 2cm botão');
insert into traje values (  5,'Vestido de verão',20.00 ,NULL);
insert into traje values (  6,'Suntop',6.50 ,NULL);
--- tabmaterial, 1, 50
insert into material values (  1,'Seda','Preto','Simples',7.00 );
insert into material values (  2,'Seda','Vermelho escuro','Tingido',10.00 );
insert into material values (  3,'Algodão','Listrado amarelo','Tecido',3.00 );
insert into material values (  4,'Algodão','Listrado verde','Tecido',3.00 );
insert into material values (  5,'Algodão','Pontilhado preto','Tecido',3.00 );
insert into material values (  6,'Algodão','Listrado vermelho','Tecido',3.00 );
insert into material values (  7,'Poliéster','Amarelo palha','Tingido',2.55 );
insert into material values (  8,'Algodão','Listrado azul','Tecido',3.00 );
insert into material values (  9,'Algodão','Cor-de-rosa','Tecido',3.00 );
insert into material values (  10,'Seda','Verde escuro','Tingido',15.00 );
insert into material values (  11,'Seda real','Vermelho/laranja','Tingido',4.00 );
insert into material values (  12,'Sarja','Azul marinho','Tecido',5.50 );
insert into material values (  13,'Algodão','Azul escuro','Tingido',3.50 );
insert into material values (  14,'Algodão','Verde escuro','Tingido',3.50 );
--- tabquantidade, 1, 50
insert into quantidade values (  1,8,2.7 );
insert into quantidade values (  1,10,2.7 );
insert into quantidade values (  1,12,2.8 );
insert into quantidade values (  1,14,2.8 );
insert into quantidade values (  1,16,3.0 );
insert into quantidade values (  1,18,3.0 );
insert into quantidade values (  2,8,3.4 );
insert into quantidade values (  2,10,3.4 );
insert into quantidade values (  2,12,3.8 );
insert into quantidade values (  2,14,3.8 );
insert into quantidade values (  2,16,4.2 );
insert into quantidade values (  2,18,4.5 );
insert into quantidade values (  3,8,1.3 );
insert into quantidade values (  3,10,1.3 );
insert into quantidade values (  3,12,1.3 );
insert into quantidade values (  3,14,1.5 );
insert into quantidade values (  3,16,1.6 );
insert into quantidade values (  3,18,1.8 );
insert into quantidade values (  4,8,1.2 );
insert into quantidade values (  4,10,1.2 );
insert into quantidade values (  4,12,1.2 );
insert into quantidade values (  4,14,1.4 );
insert into quantidade values (  4,16,1.5 );
insert into quantidade values (  4,18,1.9 );
insert into quantidade values (  5,8,3.2 );
insert into quantidade values (  5,10,3.2 );
insert into quantidade values (  5,12,3.2 );
insert into quantidade values (  5,14,3.4 );
insert into quantidade values (  5,16,5.2 );
insert into quantidade values (  5,18,5.2);
insert into quantidade values (  6,8,1.0 );
insert into quantidade values (  6,10,1.0 );
insert into quantidade values (  6,12,1.0 );
insert into quantidade values (  6,14,1.5 );
insert into quantidade values (  6,16,1.5 );
insert into quantidade values (  6,18,1.8 );
--- tabpedido, 1, 50
insert into pedido values (  1,8,'10 jan 2002','S');
insert into pedido values (  2,7,'11 jan 2002','S');
insert into pedido values (  3,6,'20 jan 2002','S');
insert into pedido values (  4,5,'02 feb 2002','S');
insert into pedido values (  5,4,'03 feb 2002','S');
insert into pedido values (  6,3,'20 feb 2002','N');
insert into pedido values (  7,2,'21 feb 2002','N');
insert into pedido values (  8,1,'27 feb 2002','N');
insert into pedido values (  9,2,'27 feb 2002','N');
insert into pedido values (  10,3,'28 feb 2002','N');
insert into pedido values (  11,4,'01 mar 2002','N');
insert into pedido values (  12,5,'03 mar 2002','N');
--- tabdetalhePedido, 1, 50
insert into detalhePedido values (  1,1,1,8,1);
insert into detalhePedido values (  1,2,2,8,2);
insert into detalhePedido values (  2,1,3,10,3);
insert into detalhePedido values (  2,2,4,10,4);
insert into detalhePedido values (  2,3,5,10,5);
insert into detalhePedido values (  3,1,6,12,6);
insert into detalhePedido values (  4,1,1,14,7);
insert into detalhePedido values (  4,2,2,14,10);
insert into detalhePedido values (  5,1,3,16,9);
insert into detalhePedido values (  5,2,4,16,10);
insert into detalhePedido values (  5,3,5,16,11);
insert into detalhePedido values (  6,1,1,8,12);
insert into detalhePedido values (  6,2,2,8,13);
insert into detalhePedido values (  6,3,3,8,14);
insert into detalhePedido values (  7,1,4,10,1);
insert into detalhePedido values (  7,2,5,10,2);
insert into detalhePedido values (  7,3,6,10,3);
insert into detalhePedido values (  8,1,6,12,4);
insert into detalhePedido values (  8,2,5,12,5);
insert into detalhePedido values (  8,3,4,12,6);
insert into detalhePedido values (  9,1,3,14,7);
insert into detalhePedido values (  10,1,2,16,8 );
insert into detalhePedido values (  10,2,1,16,9 );
insert into detalhePedido values (  11,1,1,18,10);
insert into detalhePedido values (  11,2,2,18,11);
insert into detalhePedido values (  11,3,3,18,12);
insert into detalhePedido values (  12,1,4,8,13);
insert into detalhePedido values (  12,2,5,8,14);
insert into detalhePedido values (  12,3,6,8,1);
insert into detalhePedido values (  12,4,1,8,2);
insert into detalhePedido values (  12,5,2,8,3);
--- tabcostureiro, 1, 50
insert into costureiro values(  1,'Sra Renata',2,'26365544');
insert into costureiro values(  2,'Srta Sandra',4,'30294857');
insert into costureiro values(  3,'Sr Nelson',56,'30293847');
insert into costureiro values(  4,'Sra Zenilda',27,'20394857');
insert into costureiro values(  5,'Sr Saulo',31,'30298173');
insert into costureiro values(  6,'Sr Taylor',3,'30309281');
insert into costureiro values(  7,'Srta Paula',7,'30293827');
--- tabcostura, 1, 50
insert into costura values (  1,1,1,'10 jan 2002','05 mar 2002');
insert into costura values (  2,1,2,'10 jan 2002','15 mar 2002');
insert into costura values (  3,2,1,'11 jan 2002','05 mar 2002');
insert into costura values (  4,2,2,'11 jan 2002','25 mar 2002');
insert into costura values (  5,2,3,'11 jan 2002','05 mar 2002');
insert into costura values (  6,3,1,'20 jan 2002','25 mar 2002');
insert into costura values (  7,4,1,'02 feb 2002','05 mar 2002');
insert into costura values (  1,4,2,'02 feb 2002','25 mar 2002');
insert into costura values (  2,5,1,'03 feb 2002','15 mar 2002');
insert into costura values (  3,5,2,'03 feb 2002','25 mar 2002');
insert into costura values (  4,5,3,'03 feb 2002','27 mar 2002');
insert into costura values (  5,6,1,'20 feb 2002',NULL);
insert into costura values (  6,6,2,'20 feb 2002','28 mar 2002');
insert into costura values (  7,6,3,'20 feb 2002',NULL);
insert into costura values (  1,7,1,'21 feb 2002',NULL);
insert into costura values (  2,7,2,'21 feb 2002',NULL);
insert into costura values (  3,7,3,'21 feb 2002','28 mar 2002');
insert into costura values (  4,8,1,'27 feb 2002','03 mar 2002');
insert into costura values (  5,8,2,'27 feb 2002',NULL);
insert into costura values (  6,8,3,'27 feb 2002',NULL);
insert into costura values (  7,9,1,'27 feb 2002',NULL);
insert into costura values (  1,10,1,'28 feb 2002',NULL);
insert into costura values (  2,10,2,'28 mar 2002',NULL );
insert into costura values (  3,11,1,'01 mar 2002','04 mar 2002');
insert into costura values (  4,11,2,'01 mar 2002',NULL);
insert into costura values (  5,11,3,'01 mar 2002',NULL);
insert into costura values (  7,12,2,'03 mar 2002',NULL);
insert into costura values (  1,12,3,'03 mar 2002',NULL);
insert into costura values (  2,12,4,'03 mar 2002',NULL);
insert into costura values (  2,12,5,'03 mar 2002',NULL);
