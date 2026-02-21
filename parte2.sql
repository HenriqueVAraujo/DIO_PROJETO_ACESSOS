-- Tabela de Backup para usuários excluídos
CREATE TABLE IF NOT EXISTS user_archive (
    idUser INT,
    name VARCHAR(45),
    email VARCHAR(45),
    deleted_at DATETIME
);

DELIMITER //
CREATE TRIGGER tr_backup_user_before_delete
BEFORE DELETE ON clients -- Assumindo que a tabela se chama clients
FOR EACH ROW
BEGIN
    INSERT INTO user_archive (idUser, name, email, deleted_at)
    VALUES (OLD.idClient, OLD.Fname, OLD.Email, NOW());
END;
//
DELIMITER ;


DELIMITER //
CREATE TRIGGER tr_update_salary_before
BEFORE UPDATE ON employee
FOR EACH ROW
BEGIN
    -- Se o salário novo for menor que o atual, impede a atualização (regra de exemplo)
    IF NEW.Salary < OLD.Salary THEN
        SET NEW.Salary = OLD.Salary;
    END IF;
    
    -- Registra a data da última alteração salarial se o valor mudou
    IF NEW.Salary <> OLD.Salary THEN
        SET NEW.Last_Update = NOW(); -- Assumindo que essa coluna existe
    END IF;
END;
//
DELIMITER ;
