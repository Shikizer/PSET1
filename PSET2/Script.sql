/*  01 */
SELECT numero_departamento AS Número_do_departamento, CAST(AVG(salario) AS DECIMAL(10,2)) AS Média_salarial FROM funcionarios GROUP BY numero_departamento;

/* 02 */
SELECT sexo AS Sexo, CAST(AVG(salario) AS DECIMAL(10,2)) AS Média_salarial FROM funcionarios GROUP BY Sexo;

/*03*/
SELECT nome_departamento AS Departamento, CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, data_nascimento AS Data_de_nascimento,
FLOOR(DATEDIFF(CURDATE(),data_nascimento)/365.25) AS Idade, 
salario AS Salário 
FROM funcionarios f INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento ORDER BY nome_departamento;

/*04*/
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, 
salario AS Salário, CAST((salario*1.2) AS DECIMAL(10,2)) AS Salario_com_reajuste FROM funcionarios f
WHERE salario < '35000'
UNION
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, 
salario AS Salário, CAST((salario*1.15) AS DECIMAL(10,2)) AS Salario_com_reajuste FROM funcionarios f
WHERE salario >= '35000';

/*05*/
SELECT nome_departamento AS Departamento, g.primeiro_nome AS Gerente, f.primeiro_nome AS Funcionário, salario AS Salários
FROM departamento d INNER JOIN funcionarios f, 
(SELECT primeiro_nome, cpf FROM funcionarios f INNER JOIN departamento d WHERE f.cpf = d.cpf_gerente) AS g
WHERE d.numero_departamento = f.numero_departamento AND g.cpf = d.cpf_gerente ORDER BY d.nome_departamento ASC, f.salario DESC;

/*06*/
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, dto.nome_departamento AS Departamento,
dpd.nome_dependente AS Dependente, FLOOR(DATEDIFF(CURDATE(), dpd.data_nascimento)/365.25) AS Idade_dependente,
CASE WHEN dpd.sexo = 'M' THEN 'Masculino' WHEN dpd.sexo = 'm' THEN 'Masculino'
WHEN dpd.sexo = 'F' THEN 'Feminino' WHEN dpd.sexo = 'f' THEN 'Feminino' END AS Sexo_dependente
FROM funcionarios f 
INNER JOIN departamento dto ON f.numero_departamento = dto.numero_departamento INNER JOIN dependente dpd ON dpd.cpf_funcionario = f.cpf;

/*07*/
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, dp.nome_departamento AS Departamento,
CAST((f.salario) AS DECIMAL(10,2)) AS Salário FROM funcionarios f
INNER JOIN departamento dp INNER JOIN dependente dnp
WHERE dp.numero_departamento = f.numero_departamento AND
f.cpf NOT IN (SELECT dnp.cpf_funcionario FROM dependente dnp);

/*08*/
SELECT d.nome_departamento AS Departamento, p.nome_projeto AS Projeto,
CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, t.horas AS Horas
FROM funcionarios f INNER JOIN departamento d INNER JOIN projeto p INNER JOIN trabalha_em t
WHERE d.numero_departamento = f.numero_departamento AND
p.numero_projeto = t.numero_projeto AND f.cpf = t.cpf_funcionario ORDER BY p.numero_projeto;

/*09*/
SELECT d.nome_departamento AS Departamento, p.nome_projeto AS Projeto, SUM(t.horas) AS Total_de_horas
FROM departamento d INNER JOIN projeto p INNER JOIN trabalha_em t
WHERE d.numero_departamento = p.numero_departamento AND p.numero_projeto = t.numero_projeto GROUP BY p.nome_projeto;

/*10*/
SELECT d.nome_departamento AS Departamento, CAST(avg(f.salario) AS DECIMAL(10,2)) AS Média_salarial
FROM departamento d INNER JOIN funcionarios f
WHERE d.numero_departamento = f.numero_departamento GROUP BY d.nome_departamento;

/*11*/
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, p.nome_projeto AS Projeto,
CAST((f.salario) AS DECIMAL(10,2)) AS Recebimento
FROM funcionarios f INNER JOIN projeto p INNER JOIN trabalha_em t
WHERE f.cpf = t.cpf_funcionario AND p.numero_projeto = t.numero_projeto GROUP BY f.primeiro_nome;

/*12*/
SELECT d.nome_departamento AS Departamento, p.nome_projeto AS Projeto,
CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome, t.horas AS Horas
FROM funcionarios f INNER JOIN departamento d INNER JOIN projeto p INNER JOIN trabalha_em t
WHERE f.cpf = t.cpf_funcionario AND p.numero_projeto = t.numero_projeto AND (t.horas = 0 OR t.horas = NULL) GROUP BY f.primeiro_nome;

/*13*/
SELECT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome,
CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'm' THEN 'Masculino'
WHEN sexo = 'F' THEN 'Feminino' WHEN sexo = 'f' THEN 'Feminino' END AS Sexo,
FLOOR(DATEDIFF(CURDATE(), f.data_nascimento)/365.25) AS Idade
FROM funcionarios f
UNION
SELECT d.nome_dependente AS Nome,
CASE WHEN sexo = 'M' THEN 'Masculino' WHEN sexo = 'm' THEN 'Masculino'
WHEN sexo = 'F' THEN 'Feminino' WHEN sexo = 'f' THEN 'Feminino' END AS Sexo,
FLOOR(DATEDIFF(CURDATE(), d.data_nascimento)/365.25) AS Idade
FROM dependente d ORDER BY Idade;

/*14*/
SELECT d.nome_departamento AS Departamento, COUNT(f.numero_departamento) AS Número_funcionários
FROM funcionarios f INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento GROUP BY d.nome_departamento;

/*15*/
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome,
d.nome_departamento AS Departamento, 
p.nome_projeto AS Projeto
FROM departamento d INNER JOIN projeto p INNER JOIN trabalha_em t INNER JOIN funcionarios f 
WHERE d.numero_departamento = f.numero_departamento AND p.numero_projeto = t.numero_projeto AND
t.cpf_funcionario = f.cpf
UNION
SELECT DISTINCT CONCAT(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) AS Nome,
d.nome_departamento AS Departamento, 
'Sem projeto' AS Projeto
FROM departamento d INNER JOIN projeto p INNER JOIN trabalha_em t INNER JOIN funcionarios f 
WHERE d.numero_departamento = f.numero_departamento AND p.numero_projeto = t.numero_projeto AND
(f.cpf NOT IN (SELECT t.cpf_funcionario FROM trabalha_em t));
