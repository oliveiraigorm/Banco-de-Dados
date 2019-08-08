--Igor Miranda Oliveira

--1
SELECT fnome, fcidade from fornecedor;

--2
SELECT pnome from peca WHERE peso > 15;

--3
SELECT fnome FROM ( SELECT fcodigo FROM fornecimento WHERE jcodigo = 1) c,
fornecedor WHERE c.fcodigo = fornecedor.fcodigo;
--4
SELECT SUM(quantidade) FROM fornecimento WHERE jcodigo = 2;
--5
SELECT SUM(quantidade) FROM fornecimento WHERE jcodigo = 1 AND fcodigo = 1;
--6 
SELECT fnome FROM fornecedor WHERE fnome NOT IN (SELECT fnome FROM (SELECT fcodigo FROM fornecimento)c, 
fornecedor WHERE c.fcodigo = fornecedor.fcodigo);
--7
SELECT pnome,cor,quantidade FROM (SELECT SUM(quantidade) quantidade,pcodigo
					  FROM fornecimento GROUP BY pcodigo 
 					ORDER BY pcodigo ASC )c, peca
					WHERE c.pcodigo = peca.pcodigo;
--8
SELECT COUNT(jcodigo) FROM projeto;
--9
SELECT pnome, cor FROM (SELECT pcodigo FROM fornecimento WHERE jcodigo = 3)d, peca 
WHERE d.pcodigo = peca.pcodigo;
--10
SELECT fnome FROM fornecedor ORDER BY (fnome) ASC;
--11
SELECT jnome FROM (SELECT jcodigo FROM fornecimento, 
				   (SELECT pcodigo FROM peca WHERE peca.pcidade = 'Londrina') a,
					(SELECT fcodigo FROM fornecedor WHERE fornecedor.fcidade = 'Londrina') b
				   WHERE a.pcodigo = fornecimento.pcodigo 
				   AND b.fcodigo = fornecimento.fcodigo ) x, projeto
				   WHERE projeto.jcodigo = X.jcodigo
				   
--12
SELECT pnome FROM peca, (SELECT pcodigo FROM fornecimento, (SELECT fcodigo FROM fornecedor 
	WHERE fornecedor.fstatus = '10' OR  fornecedor.fstatus = '20') a
	WHERE fornecimento.fcodigo = a.fcodigo) x WHERE peca.pcodigo =  x.pcodigo GROUP BY(pnome)