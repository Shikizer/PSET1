/*  01 */
SELECT numero_departamento AS Número_do_departamento, CAST(AVG(salario) AS DECIMAL(10,2)) AS Média_salarial FROM funcionarios GROUP BY numero_departamento;

/* 02 */
SELECT sexo AS Sexo, CAST(AVG(salario) AS DECIMAL(10,2)) AS Média_salarial FROM funcionarios GROUP BY Sexo;

/*03*/
SELECT nome_departamento AS Departamento, primeiro_nome AS Nome, nome_meio AS Nome_do_meio, ultimo_nome AS Sobrenome, data_nascimento AS Data_de_nascimento,
FLOOR(DATEDIFF(CURDATE(),data_nascimento)/365.25) AS Idade, 
salario AS Salário 
FROM funcionarios f INNER JOIN departamento d
WHERE f.numero_departamento = d.numero_departamento
ORDER BY nome_departamento;

/*04*/
SELECT primeiro_nome AS Nome, nome_meio AS Nome_do_meio, ultimo_nome AS Sobrenome, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, 
salario AS Salário, CAST((salario*1.2) AS DECIMAL(10,2)) AS Salario_com_reajuste FROM funcionarios
WHERE salario < '35000'
UNION
SELECT primeiro_nome AS Nome, nome_meio AS Nome_do_meio, ultimo_nome AS Sobrenome, FLOOR(DATEDIFF(CURDATE(), data_nascimento)/365.25) AS Idade, 
salario AS Salário, CAST((salario*1.15) AS DECIMAL(10,2)) AS Salario_com_reajuste FROM funcionarios
WHERE salario >= '35000';

/*05*/
...


