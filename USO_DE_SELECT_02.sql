

-- 1) Identifique departamentos com mais de 15 funcionários.
SELECT sigla_depto FROM departamento
WHERE qtd_funcionarios_depto > 15;

-- 2) Selecione os nomes dos funcionários cujo salário é maior ou igual a R$ 4.000.
SELECT nome_funcionario FROM funcionario WHERE salario >= 4000.00;

-- 3) Calcular a média salarial dos funcionários
SELECT AVG(salario) AS media_salarial FROM funcionario;

-- 4) Calcular a média salarial dos funcionários com duas casas decimais de precisão após a vírgula, você pode usar a função ROUND
SELECT ROUND(AVG(salario), 2) AS media_salarial FROM funcionario;

-- 5) Encontre funcionários cujo nome contém "Silva".
SELECT nome_funcionario FROM funcionario
WHERE nome_funcionario LIKE '%Gomes%';

-- 6) Calcule o salário anual de todos os funcionários.
SELECT nome_funcionario, salario * 12 AS salario_anual FROM funcionario;

-- 7) Identifique o funcionário com o salário mais alto.
SELECT nome_funcionario, salario FROM funcionario 
WHERE salario = (SELECT MAX(salario) FROM funcionario);

-- 8) Identifique os 2 salários mais altos.
SELECT nome_funcionario, salario
FROM funcionario ORDER BY salario DESC LIMIT 3;

-- 9) Identifique o funcionário mais velho de cada cargo.
SELECT nome_funcionario, cargo,  MAX(data_admissao) AS data_admissao 
FROM funcionario GROUP BY cargo, nome_funcionario;


-- 10) Encontre departamentos com pelo menos um funcionário com salário superior a R$ 5.000.
SELECT DISTINCT d.nome_depto
FROM departamento d
WHERE EXISTS ( SELECT 1 FROM funcionario f 
WHERE f.sigla_depto = d.sigla_depto AND f.salario > 5000.00 );

-- 11) Encontre os departamentos onde pelo menos um funcionário tem um salário superior ao salário médio de todos os funcionários.
SELECT DISTINCT d.nome_depto
FROM departamento d
WHERE EXISTS (
    SELECT 1 FROM funcionario f WHERE f.sigla_depto = d.sigla_depto
    AND f.salario > (SELECT AVG(salario) FROM funcionario)
);

-- 12) Encontre departamentos com pelo menos um funcionário cujo nome contenha "Costa".
SELECT DISTINCT d.nome_depto
FROM departamento d
WHERE EXISTS (
    SELECT 1 FROM funcionario f WHERE f.sigla_depto = d.sigla_depto
    AND f.nome_funcionario LIKE '%Costa%'
);

-- 13) Encontre departamentos onde pelo menos um funcionário tem um salário superior ao salário médio de seu próprio departamento.
SELECT DISTINCT d.nome_depto
FROM departamento d
WHERE EXISTS (
    SELECT 1 FROM funcionario f WHERE f.sigla_depto = d.sigla_depto
    AND f.salario > (SELECT AVG(salario) FROM funcionario WHERE sigla_depto = d.sigla_depto)
);
