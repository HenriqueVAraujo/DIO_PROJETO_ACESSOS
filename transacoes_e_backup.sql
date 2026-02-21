-- ######################################################
-- PARTE 1: TRANSAÇÕES MANUAIS
-- ######################################################

-- Desabilitando autocommit para controle total da transação
SET autocommit = 0;

-- Início da transação para modificação de dados persistidos
START TRANSACTION;

-- Cenário: Atualização de salário e registro de bônus por departamento
UPDATE employee 
SET Salary = Salary * 1.05 
WHERE Dno = 5;

-- Registro de log de auditoria (exemplo de modificação múltipla)
-- Supondo que exista uma tabela de controle de custos
UPDATE department 
SET Total_Salaries = (SELECT SUM(Salary) FROM employee WHERE Dno = 5)
WHERE Dnumber = 5;

-- Verificação de segurança: Se as alterações forem válidas, confirmar
COMMIT;

-- Caso ocorra algum erro durante o processo manual:
-- ROLLBACK;


-- ######################################################
-- PARTE 2: TRANSAÇÃO DENTRO DE PROCEDURE (COM TRATAMENTO DE ERRO)
-- ######################################################

DELIMITER //

CREATE PROCEDURE sp_Transaction_Execution()
BEGIN
    -- Declaração de variável para capturar erros SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        -- Em caso de qualquer erro (chave estrangeira, tipo de dado, etc), desfaz tudo
        ROLLBACK;
        SELECT 'Erro detectado: Transação abortada e dados revertidos.' AS Resultado;
    END;

    -- Início da Transação Controlada
    START TRANSACTION;

    -- Operação 1: Inserção de um novo projeto
    INSERT INTO project (Pname, Pnumber, Plocation, Dnum) 
    VALUES ('Sistemas de Backup', 101, 'São Paulo', 5);

    -- Operação 2: Criando um Savepoint (Recuperação parcial)
    SAVEPOINT sp_projeto_criado;

    -- Operação 3: Inserção de dados na tabela works_on
    -- Se este SSN não existir, o EXIT HANDLER fará o ROLLBACK total
    INSERT INTO works_on (Essn, Pno, Hours) 
    VALUES ('123456789', 101, 15.5);

    -- Se todas as instruções acima executarem sem erros:
    COMMIT;
    SELECT 'Transação realizada com sucesso!' AS Resultado;

END //

DELIMITER ;

-- Chamada da procedure para teste
-- CALL sp_Transaction_Execution();
