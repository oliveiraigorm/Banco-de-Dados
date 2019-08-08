--Igor MIranda Oliveira

--Prática 06
--1
SELECT nm_empregado, nm_sobrenome FROM empregado e 
INNER JOIN historico_emprego h on e.nu_empregado = h.nu_empregado 
WHERE h.nm_cargo = 'Accountant';
--2
SELECT  nm_empregado AS NomeEmpregado, nm_sobrenome 
AS SobrenomeEmpregado FROM empregado NATURAL JOIN 
(SELECT nm_curso FROM empregado_curso  NATURAL JOIN curso) 
AS a WHERE nm_curso = 'Ada' OR nm_curso = 'LANs' 
GROUP BY (nomeempregado, sobrenomeempregado);
--3
SELECT nm_curso FROM curso NATURAL JOIN 
(SELECT nu_curso, COUNT (*) AS x FROM empregado_curso 
GROUP BY nu_curso) AS b WHERE x<10 ORDER BY (x) ;
--4
SELECT nm_depto, COUNT (nm_depto) quantidade FROM 
 empregado NATURAL JOIN departamento GROUP BY(nm_depto)
 ORDER BY (nm_depto) 
--5
SELECT nm_depto FROM(SELECT nm_depto, COUNT (nm_depto) quantidade
FROM  empregado NATURAL JOIN departamento
GROUP BY(nm_depto)ORDER BY (nm_depto) )a
WHERE quantidade> 6 

--6
SELECT nm_empregado FROM empregado NATURAL JOIN (SELECT nm_depto FROM(SELECT nm_depto, COUNT (nm_depto) quantidade
FROM  empregado NATURAL JOIN departamento
GROUP BY(nm_depto)ORDER BY (nm_depto) )a
WHERE quantidade = 6 ) x GROUP BY (nm_empregado)

--7
SELECT nm_empregado, nm_sobrenome FROM empregado NATURAL JOIN
historico_emprego WHERE DATE_PART('year', current_date) 
- DATE_PART('year', historico_emprego.dt_inicio)  = 3 
OR DATE_PART('year', historico_emprego.dt_fim) 
- DATE_PART('year', historico_emprego.dt_inicio)  = 3  
GROUP BY(nm_empregado, nm_sobrenome)
--8
--CONSIDERANDO QUE A QUESTAO FOI ESCRITA ERRADA COM 
--CURSOS AO INVÉS DE EMPREGO POIS CURSO NAO TEM DT_FIM
SELECT nm_empregado, dt_inicio, dt_fim FROM(
SELECT nu_empregado, dt_inicio, dt_fim FROM(
SELECT dt_inicio, COUNT(dt_inicio) x 
FROM historico_emprego GROUP BY(dt_inicio)) a NATURAL JOIN historico_emprego
WHERE x >1) B NATURAL JOIN empregado

--9
SELECT nm_curso FROM curso
WHERE nu_curso NOT IN(SELECT nu_curso FROM curso
					 NATURAL JOIN empregado_curso ) 
--10
SELECT nm_curso FROM curso WHERE DATE_PART('month', dt_curso) = 10

--11
SELECT nm_curso, COUNT(nu_empregado) QuantidadeDeAlunos FROM curso
					 NATURAL JOIN empregado_curso
					 GROUP BY(nm_curso) ORDER BY (QuantidadeDeAlunos) DESC LIMIT 1

--12
SELECT nm_empregado, nm_sobrenome FROM empregado 
ORDER BY (DATE_PART('year', CURRENT_DATE) -
DATE_PART('year', dt_nascimento)) DESC
LIMIT 3







