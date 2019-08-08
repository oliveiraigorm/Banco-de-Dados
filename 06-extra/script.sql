--IGOR MIRANDA OLIVEIRA
--1
SELECT nm_cliente FROM cliente NATURAL JOIN pedido
WHERE pedido.in_finalizado = 'S'
GROUP BY (nm_cliente)
--2
SELECT nm_cliente, in_finalizado  FROM cliente NATURAL JOIN pedido
WHERE pedido.dt_pedido > '01 jan 2002' AND
pedido.dt_pedido > '20 feb 2002'
--3
SELECT nm_cliente, in_finalizado, dt_pedido  FROM cliente NATURAL JOIN pedido
ORDER BY (dt_pedido) ASC 
LIMIT 4

--4
SELECT nm_material, nm_cor_material FROM 
(SELECT id_material FROM detalhepedido NATURAL JOIN pedido) a
NATURAL JOIN material
LIMIT 3


--5
SELECT nm_costureiro FROM costureiro NATURAL JOIN
costura WHERE dt_fim_costura IS NULL
GROUP BY(nm_costureiro)


--6
SELECT nm_costureiro FROM(SELECT * FROM ((SELECT id_traje, id_pedido FROM detalhepedido
						   NATURAL JOIN pedido) b
NATURAL JOIN costura)a NATURAL JOIN traje
WHERE te_descricao_traje = 'Vestido de verão') c NATURAL JOIN costureiro
GROUP BY (nm_costureiro)


--7
SELECT nu_tamanho AS TamanhoDeMiniSaia FROM traje NATURAL JOIN detalhepedido
WHERE te_descricao_traje = 'Mini saia'
--8
SELECT nm_material, nm_cor_material FROM (SELECT id_traje FROM traje 
										  NATURAL JOIN detalhepedido
WHERE te_descricao_traje = 'Saia longa')a NATURAL JOIN material
GROUP BY (nm_material, nm_cor_material)
