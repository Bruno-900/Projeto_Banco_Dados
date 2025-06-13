
-- ==============================================
-- PARTE 2: TRANSAÇÃO COM REGRA DE NEGÓCIO
-- ==============================================

-- Regra de Negócio: Ao registrar um novo ingresso (CHECKIN_Ingresso),
-- verificar se há quantidade disponível do tipo correspondente na tabela Tipo.
-- Se houver, decrementar a quantidade e inserir o ingresso.
-- Caso contrário, ou em caso de erro, reverter a operação (ROLLBACK).

DELIMITER //
CREATE PROCEDURE sp_registrar_ingresso_com_transacao (
    IN p_ID_CHECKIN INT,
    IN p_Data_Hora DATETIME,
    IN p_Status VARCHAR(50),
    IN p_Preco DECIMAL(10,2),
    IN p_Tutor_s_n BOOLEAN,
    IN p_ID_Ingresso INT,
    IN p_Data_Visita DATE,
    IN p_Data_Hora_Checkin DATETIME,
    IN p_Status_Ingresso VARCHAR(50),
    IN p_fk_Compra_ID_Compra INT,
    IN p_fk_Tipo_ID_Tipo INT,
    OUT p_sucesso BOOLEAN,
    OUT p_mensagem VARCHAR(255)
)
BEGIN
    DECLARE v_quantidade_disponivel INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SET p_sucesso = FALSE;
        SET p_mensagem = 'Erro durante a transação. Operação revertida.';
    END;

    START TRANSACTION;

    -- Verificar a quantidade disponível do tipo de ingresso
    SELECT Quantidade_Disponivel INTO v_quantidade_disponivel
    FROM Tipo
    WHERE ID_Tipo = p_fk_Tipo_ID_Tipo AND ativo = TRUE;

    -- Verificar se o tipo existe e está ativo
    IF v_quantidade_disponivel IS NULL THEN
        ROLLBACK;
        SET p_sucesso = FALSE;
        SET p_mensagem = 'Tipo de ingresso não encontrado ou inativo.';
    -- Verificar se há ingressos disponíveis
    ELSEIF v_quantidade_disponivel > 0 THEN
        -- Decrementar a quantidade disponível
        UPDATE Tipo
        SET Quantidade_Disponivel = Quantidade_Disponivel - 1
        WHERE ID_Tipo = p_fk_Tipo_ID_Tipo;

        -- Inserir o novo registro de CHECKIN_Ingresso
        INSERT INTO CHECKIN_Ingresso (ID_CHECKIN, Data_Hora, Status, Preco, Tutor_s_n, ID_Ingresso, Data_Visita, Data_Hora_Checkin, Status_Ingresso, fk_Compra_ID_Compra, fk_Tipo_ID_Tipo)
        VALUES (p_ID_CHECKIN, p_Data_Hora, p_Status, p_Preco, p_Tutor_s_n, p_ID_Ingresso, p_Data_Visita, p_Data_Hora_Checkin, p_Status_Ingresso, p_fk_Compra_ID_Compra, p_fk_Tipo_ID_Tipo);

        COMMIT;
        SET p_sucesso = TRUE;
        SET p_mensagem = 'Ingresso registrado e quantidade atualizada com sucesso.';
    ELSE
        -- Quantidade insuficiente
        ROLLBACK;
        SET p_sucesso = FALSE;
        SET p_mensagem = 'Quantidade insuficiente de ingressos para este tipo.';
    END IF;

END //
DELIMITER ;
