--Igor Miranda Oliveira
--a
CREATE OR REPLACE FUNCTION levanta(VARCHAR, VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	nome VARCHAR;
BEGIN
	IF $1 = NULL OR $1 = '' THEN
		RAISE NOTICE 'Valor Inválido! ';
		--RETURN NULL;
	ELSE
		FOR nome IN
			SELECT nm_musico  FROM musico NATURAL JOIN
			interprete WHERE interprete.nm_instrumento = $1 GROUP BY(nm_musico)
			LOOP
			IF $1 = 'violin' THEN 
				RAISE NOTICE  'Prezado %,
Você foi selecionado em nosso banco de dados em virtude da sua
habilidade em tocar violino. Atualmente, surgiu uma vaga para violinista
na Orquestra Municipal e, caso você tenha interesse, entre contato
através do telefone %', nome, $2 ;
			END IF;
			IF $1 = 'viola' THEN 
				RAISE NOTICE  'Prezado %,
Você foi selecionado em nosso banco de dados em virtude da sua
habilidade em tocar viola. Atualmente, surgiu uma vaga para violeiro
no Coreto Municipal e, caso você tenha interesse, entre contato
através do telefone %', nome, $2 ;
			END IF;
			IF $1 = 'banjo' THEN 
				RAISE NOTICE  'Prezado %,
Você foi selecionado em nosso banco de dados em virtude da sua
habilidade em tocar banjo. Atualmente, surgiu uma vaga para banjoista
no Palácio Real e, caso você tenha interesse, entre contato
através do telefone %', nome, $2 ;
			END IF;
		END LOOP;
	END IF;
END
$$
LANGUAGE 'plpgsql'

--b
CREATE OR REPLACE FUNCTION anuncia(date, VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	registro RECORD;
	convidado RECORD;
BEGIN
	IF $1 = NULL OR $1 = NULL THEN
		RAISE NOTICE 'Valor Inválido! ';
		--RETURN NULL;
	ELSE
		FOR convidado IN 
			SELECT nm_musico FROM musico WHERE nm_musico <> $2
			LOOP
			FOR registro IN 
				SELECT nm_auditorio, nm_cidade FROM evento INNER JOIN
				local ON evento.nu_local_evento = local.nu_local 
				WHERE dt_evento = $1 GROUP BY (nm_auditorio, nm_cidade) 
				LOOP
					RAISE NOTICE 'Prezado %, % tem o prazer de convidá-lo para o evento que	irá ocorrer no dia 30/03/2013 no % em %. 
					Seria uma honra poder contar com sua presença.',
								 convidado.nm_musico,$2,
								registro.nm_auditorio, registro.nm_cidade;
			END LOOP;
		END LOOP;
	END IF;
END
$$
LANGUAGE 'plpgsql'
--c
CREATE OR REPLACE FUNCTION musicos()
RETURNS TABLE (nome_musico CHAR, qtde BIGINT) AS $$
BEGIN
CREATE OR REPLACE VIEW vw_musicos AS SELECT * FROM
(SELECT * FROM musico INNER JOIN interprete 
ON musico.nu_musico = interprete.nu_musico_interprete) AS a NATURAL JOIN atuacao;
RETURN QUERY SELECT nm_musico, COUNT(*) FROM vw_musicos 
GROUP BY (vw_musicos.nm_musico, vw_musicos.nu_banda) HAVING COUNT(*) > 1;
END
$$
LANGUAGE 'plpgsql'