--Igor Miranda Oliveira

--a
CREATE USER IgorMiranda;
--b
CREATE VIEW vw_funcionario AS 
	SELECT nm_funcionario, dt_admissao FROM (SELECT * FROM pedido NATURAL JOIN funcionario)a 
					NATURAL JOIN cliente WHERE nm_cidade_cliente <> nm_cidade_funcionario 
					GROUP BY nm_funcionario, dt_admissao
	UNION

	SELECT nm_funcionario, dt_admissao FROM (SELECT * FROM encomenda NATURAL JOIN funcionario)a 
					NATURAL JOIN cliente WHERE nm_cidade_cliente <> nm_cidade_funcionario 
					GROUP BY nm_funcionario, dt_admissao

--c
CREATE USER colega;
GRANT ALL PRIVILEGES ON vw_funcionario TO colega;
--d
CREATE USER colega2;
--e
CREATE OR REPLACE FUNCTION totalEncomendas (VARCHAR)
RETURNS integer AS $total$
declare
	total integer;
BEGIN
SELECT SUM(vl_quantidade)into total FROM encomenda_livro NATURAL JOIN livro
WHERE nm_titulo = $1;
RETURN total;
END;
$total$ LANGUAGE 'plpgsql';
--f
CREATE OR REPLACE FUNCTION encomendas() 
 RETURNS TABLE (
 mes double precision,
 quantidade bigint
) 
AS $$
BEGIN
 RETURN QUERY SELECT
 DATE_PART('month', dt_encomenda),
 COUNT(*) AS valor
 FROM
 encomenda
 WHERE
 DATE_PART('year', dt_encomenda) = '1999'
 GROUP BY (DATE_PART('month', dt_encomenda));
END; $$ 
 
LANGUAGE 'plpgsql';
--g
CREATE OR REPLACE FUNCTION pedidosfeitos(INTEGER)
RETURNS TABLE(palavrachave VARCHAR)
AS $$
BEGIN
RETURN QUERY SELECT te_descricao FROM (SELECT * FROM (SELECT * FROM (SELECT * FROM pedido NATURAL JOIN 
							  cliente WHERE id_cliente = $1) AS a 
							  NATURAL JOIN livro) AS b NATURAL JOIN palavra_chave_livro) AS c
							  NATURAL JOIN palavra_Chave GROUP BY(te_descricao);
END
$$
LANGUAGE 'plpgsql'
--h
CREATE OR REPLACE FUNCTION dadosclientes()
RETURNS TABLE(id_encomenda INTEGER, 
			  id_cliente   		INTEGER,
  nm_cliente          	VARCHAR(40),
  nu_telefone_cliente   VARCHAR(20),
  nu_rg_cliente    	VARCHAR(20),
  sg_sexo_cliente       CHAR(1),
  nm_logradouro_cliente VARCHAR(40),
  nu_residencia_cliente VARCHAR(10),
  nm_bairro_cliente     VARCHAR(40),
  nu_cep_cliente        VARCHAR(8),
  nm_cidade_cliente     VARCHAR(40),
  sg_uf_cliente         CHAR(2)) AS
$$
BEGIN 
RETURN QUERY
SELECT encomenda.id_encomenda, cliente.* FROM cliente NATURAL JOIN 
						encomenda WHERE nu_prazo_estimado > 7;
END
$$
LANGUAGE 'plpgsql'
