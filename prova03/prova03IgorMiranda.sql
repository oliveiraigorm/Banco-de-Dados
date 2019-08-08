--Igor Miranda

--1

CREATE OR REPLACE FUNCTION avisa(INTEGER, DATE, DATE)
RETURNS TABLE(idtransacao INTEGER ,
	idtipooperacao integer,
	idcontaorigem integer,
	idcontadestino integer,
	tmhorario time,
	txtstatus varchar(50),
	dtdata date,
	dblvalor double precision,
	idfuncionario integer)
AS
$$
BEGIN
	SELECT * FROM transacao WHERE transacao.idcontaorigem = $1 
	AND  transacao.dtdata > $2 AND transacao.dtdata < $3;
END
$$
LANGUAGE 'plpgsql'

SELECT avisa(1,'2009-02-03', '2005-02-03')

--2

CREATE OR REPLACE VIEW vw_meta AS SELECT * FROM metas 
		NATURAL JOIN (SELECT idfuncionario, SUM(dblvalor) AS total FROM transacao
				 WHERE DATE_PART('month', CURRENT_DATE) = DATE_PART('month', dtdata) 
				 GROUP BY(idfuncionario))AS a 
				WHERE total > metas.dblvalor
--3

CREATE GROUP g1;
CREATE USER us1 IN GROUP g1;
CREATE USER us2 IN GROUP g1;
GRANT all privileges ON ALL TABLES IN SCHEMA public TO group g1;

--4

CREATE OR REPLACE FUNCTION avisa()
 RETURNS trigger AS
$$
DECLARE
	registro RECORD;
BEGIN
	FOR registro IN
       SELECT dtdata FROM (SELECT * FROM transacao WHERE transacao.idtipooperacao = 0 
		ORDER BY(dtdata) DESC limit 1) AS a NATURAL JOIN conta
		WHERE conta.idtipoconta = 2 AND conta.idtipoconta = 6
	LOOP
		RAISE NOTICE 'Novo saque realizado em %', registro.dtdata;
	END LOOP;
END
$$

LANGUAGE 'plpgsql'

CREATE TRIGGER avisa
  AFTER INSERT
  ON transacao
  EXECUTE PROCEDURE avisa();

--5

ALTER TABLE TRANSACAO ADD COLUMN val_impo INTEGER ;

CREATE OR REPLACE FUNCTION tax()
 RETURNS trigger AS
$$
DECLARE
	registro RECORD;
BEGIN
	FOR registro IN
       SELECT dblvalor FROM transacao NATURAL JOIN taxaimposto
	LOOP
		UPDATE transacao
		SET val_impo = record.dblvalor
		WHERE val_impo = NULL;
	END LOOP;
END
$$

LANGUAGE 'plpgsql'

CREATE TRIGGER tax
  AFTER INSERT
  ON transacao
  EXECUTE PROCEDURE tax();


