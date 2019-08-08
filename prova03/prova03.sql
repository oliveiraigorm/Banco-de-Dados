--Igor Miranda

--1

CREATE OR REPLACE FUNCTION avisa(INTEGER, DATE, DATE)
RETURNS TABLE()
AS
$$
DECLARE
	tran RECORD;
BEGIN
	FOR tran IN 
		SELECT * FROM transacao WHERE tranasacao.idcontaorigem = $1 
		AND  dtdata > $2 AND dtdata < $3;
	END LOOP;
END
$$
LANGUAGE 'plpgsql'
