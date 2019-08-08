--Igor Miranda Oliveira

--1

-- é possível saber quais artigos são de autoria ou foram revisados por um participante atraves da tabela revisor_artigo, 
-- que permite descobrir o revisor e para descobrir o autor é necessário realizar um natural joi de revisor_artigo com autor_artigo
-- Também é possível descobrir a qual congresso um artigo foi submetido, a partir da tabela participante_congresso que relaciona 
-- o id de um participante com qual congresso ele participou

--2
CREATE OR REPLACE FUNCTION distribui() 
RETURNS TABLE (numrevisor INTEGER, numartigo INTEGER)
AS $$
DECLARE
registro RECORD;
num_artigos INTEGER;
num_revisores INTEGER;
media INTEGER;
contador INTEGER;
BEGIN
SELECT COUNT(id_revisor_artigo) INTO num_revisores FROM revisor_artigo;
SELECT COUNT(id_artigo) INTO num_artigos FROM revisor_artigo;

media :=  num_revisores/num_artigos;
FOR registro IN 
SELECT id_revisor_artigo FROM revisor_artigo
LOOP
	contador := 0;
	WHILE(contador < media) LOOP
		RETURN QUERY SELECT id_revisor_artigo, id_artigo 
		FROM revisor_artigo WHERE dt_revisao <> NULL;
		contador := contador + 1;
		END LOOP;
	END LOOP;
END
$$
LANGUAGE 'plpgsql'

--3
CREATE OR REPLACE FUNCTION enviaemail (INTEGER)
RETURNS INTEGER
AS $$
DECLARE
registro RECORD;
BEGIN
FOR registro IN
	SELECT * FROM revisor_artigo 
	LOOP
		IF registro.dt_revisao < now() THEN
		 RAISE NOTICE 'Atencao %, seu artigo foi corrigido', $1;
		END IF;
END LOOP;
END
$$
LANGUAGE 'plpgsql';

--4

CREATE VIEW vw_artigos AS SELECT id_artigo, dt_envio_artigo FROM 
(SELECT id_artigo FROM revisor_artigo WHERE nu_nota > 8 ) AS a 
NATURAL JOIN artigo ORDER BY artigo.dt_envio_artigo DESC

