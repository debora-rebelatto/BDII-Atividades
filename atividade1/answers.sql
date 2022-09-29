-- Questão 1
-- Listar os empregados (nomes) que tem salário maior que seu chefe
--  empregado | emp_sal | chefe | chef_sal
-- -----------+---------+-------+----------
--  Maria     |    8000 | Jose  |     9500
--  Claudia   |    8000 | Jose  |    10000
--  Ana       |    8000 | Jose  |    12200
--  Luiz      |    7500 | Pedro |     8000

SELECT
  emp.nome AS empregado,
  chefe.salario AS emp_sal,
  chefe.nome AS chefe,
  emp.salario AS chef_sal
FROM empregados chefe
JOIN empregados emp
ON chefe.emp_id = emp.supervisor_id
WHERE emp.salario > chefe.salario;

-- Questão 2
-- Listar o maior salario de cada departamento (pode ser usado o group by)
--  dep_id |  max
-- --------+-------
--       1 | 10000
--       2 |  8000
--       3 |  6000
--       4 | 12200
SELECT
  dep_id,
  MAX(salario)
FROM empregados
GROUP BY dep_id
ORDER BY dep_id;


-- Questão 3
-- Listar o nome do funcionario com maior salario dentro de cada departamento (pode ser usado o IN)
--  dep_id |  nome   | salario
-- --------+---------+---------
--       1 | Claudia |   10000
--       2 | Luiz    |    8000
--       3 | Joao    |    6000
--       4 | Ana     |   12200
SELECT
  emp.dep_id,
  emp.nome,
  emp.salario
FROM empregados emp
JOIN (
  SELECT
    dep_id,
    MAX(salario) AS salario
  FROM empregados
  GROUP BY dep_id
) AS emp_max
ON emp.dep_id = emp_max.dep_id
AND emp.salario = emp_max.salario
ORDER BY emp.dep_id;

-- Questão 4
-- Listar os nomes departamentos que tem menos de 3 empregados;
--    nome
-- -----------
--  RH
--  Vendas
--  Marketing
SELECT
  nome
FROM departamentos
WHERE dep_id NOT IN (
  SELECT
    dep_id
  FROM empregados
  GROUP BY dep_id
  HAVING COUNT(*) >= 3
);

-- Questão 5
-- Listar os departamentos com o número de colaboradores
--    nome    | count
-- -----------+-------
--  Marketing |     1
--  RH        |     2
--  TI        |     4
--  Vendas    |     1
SELECT
  dep.nome,
  COUNT(*) AS count
FROM departamentos dep
JOIN empregados emp
ON dep.dep_id = emp.dep_id
GROUP BY dep.nome;

-- Questão 6
-- Listar os empregados que não possuem chefes no mesmo departamento
--  emp_name | dep_name  | chefe_name | dep_chefe_name
-- ----------+-----------+------------+----------------
--  Joao     | Vendas    | Pedro      | RH
--  Ana      | Marketing | Jose       | TI
SELECT
  emp.nome AS emp_name,
  dep.nome AS dep_name,
  chefe.nome AS chefe_name,
  dep_chefe.nome AS dep_chefe_name
FROM empregados emp
JOIN departamentos dep
ON emp.dep_id = dep.dep_id
LEFT JOIN empregados chefe
ON emp.supervisor_id = chefe.emp_id
LEFT JOIN departamentos dep_chefe
ON chefe.dep_id = dep_chefe.dep_id
WHERE dep.dep_id != dep_chefe.dep_id;

-- Questão 7
-- Listar os departamentos com o total de salários pagos
--    nome    |  sum
-- -----------+-------
--  Marketing | 12200
--  RH        | 15500
--  TI        | 32500
--  Vendas    |  6000
SELECT
  dep.nome,
  SUM(emp.salario)
FROM departamentos dep
JOIN empregados emp
ON dep.dep_id = emp.dep_id
GROUP BY dep.nome;

-- TODO
-- Questão 8
-- List all employees that have a salary higher than the average salary of their department
--  emp_name | dep_name  | avg
-- ----------+-----------+-------
--  Joao     | Vendas    | 6000
--  Ana      | Marketing | 12200
SELECT
  emp.nome AS emp_name,
  dep.nome AS dep_name,
  AVG(emp.salario) AS avg
FROM empregados emp
JOIN departamentos dep
ON emp.dep_id = dep.dep_id
GROUP BY dep.nome
HAVING emp.salario > AVG(emp.salario);


-- Questão 9
-- Compare o salario de cada colaborados com média do seu setor. Dica: usar slide windows functions (https://www.postgresqltutorial.com/postgresql-window-function/)
SELECT
  emp.emp_id,
  emp.nome,
  emp.dep_id,
  emp.salario,
  AVG(emp.salario) OVER (PARTITION BY emp.dep_id) AS avg
FROM empregados emp
ORDER BY emp.dep_id;

-- Questão 10
WITH avg_salaries AS (
  SELECT
    dep.nome,
    AVG(emp.salario) AS avg
  FROM departamentos dep
  JOIN empregados emp
  ON dep.dep_id = emp.dep_id
  GROUP BY dep.nome
)
SELECT
  emp.nome,
  emp.salario,
  avg_salaries.avg
FROM empregados emp
JOIN avg_salaries
ON emp.dep_id = avg_salaries.dep_id
WHERE emp.salario >= avg_salaries;
