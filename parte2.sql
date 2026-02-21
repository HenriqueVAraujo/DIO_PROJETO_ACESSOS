-- ######################################################
-- PARTE 2: GATILHOS (TRIGGERS) E PROCEDURES
-- ######################################################

-- 1. Preparação do Ambiente: Tabela de Backup
CREATE TABLE IF NOT EXISTS user_archive (
    idUser INT,
    name VARCHAR(45),
    email VARCHAR(45),
    deleted_at DATETIME
);

-- 2. Trigger de Remoção: Backup antes de deletar o cliente
DROP TRIGGER IF EXISTS tr_backup_user_before_delete;

DELIMITER //
CREATE TRIGGER tr_backup_user_before_delete
BEFORE DELETE ON clients 
FOR EACH ROW
BEGIN
    INSERT INTO user_archive (idUser, name, email, deleted_at)
    VALUES (OLD.idClient, OLD.Fname, OLD.Email, NOW());
END;
//
DELIMITER ;

-- 3. Trigger de Atualização: Validação de Salário
DROP TRIGGER IF EXISTS tr_update_salary_before;

DELIMITER //
CREATE TRIGGER tr_update_salary_before
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    -- Regra de Negócio: Impede redução salarial
    IF NEW.Salary < OLD.Salary THEN
        SET NEW.Salary = OLD.Salary;
    END IF;
    
    -- Nota: A linha abaixo assume que existe a coluna Last_Update. 
    -- Se não existir, você pode comentar a linha abaixo.
    -- SET NEW.Last_Update = NOW(); 
END;
//
DELIMITER ;

-- 4. Procedure de Manipulação de Dados (CRUD Dinâmico)
-- Inserindo a procedure que centraliza as ações conforme o desafio pede
DROP PROCEDURE IF EXISTS sp_ManageData;

DELIMITER //
CREATE PROCEDURE sp_ManageData(
    IN operacao INT, -- 1: Insert, 2: Update, 3: Delete
    IN p_id INT,
    IN p_nome VARCHAR(50),
    IN p_extra VARCHAR(50)
)
BEGIN
    CASE operacao
        WHEN 1 THEN 
            INSERT INTO clients (idClient, Fname, Email) VALUES (p_id, p_nome, p_extra);
        WHEN 2 THEN 
            UPDATE clients SET Fname = p_nome, Email = p_extra WHERE idClient = p_id;
        WHEN 3 THEN 
            DELETE FROM clients WHERE idClient = p_id;
        ELSE 
            SELECT 'Operação Inválida' AS Erro;
    END CASE;
END;
//
DELIMITER ;
