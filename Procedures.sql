
-- Adicionando coluna 'ativo' onde necessário
ALTER TABLE Visitante ADD COLUMN ativo BOOLEAN DEFAULT TRUE;
ALTER TABLE Promocao ADD COLUMN ativo BOOLEAN DEFAULT TRUE;
ALTER TABLE Detalhes_Pagamento ADD COLUMN ativo BOOLEAN DEFAULT TRUE;
ALTER TABLE Compra ADD COLUMN ativo BOOLEAN DEFAULT TRUE;
ALTER TABLE Tipo ADD COLUMN ativo BOOLEAN DEFAULT TRUE;
ALTER TABLE Avaliacao ADD COLUMN ativo BOOLEAN DEFAULT TRUE;

-- ----------------------------------------------
-- Tabela: Visitante
-- ----------------------------------------------

-- Procedure para Inclusão de Visitante
DELIMITER //
CREATE PROCEDURE sp_insert_visitante (
    IN p_ID_Visitante INT,
    IN p_Nome VARCHAR(100),
    IN p_CPF VARCHAR(14),
    IN p_Telefone VARCHAR(20),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255),
    IN p_Idade INT
)
BEGIN
    INSERT INTO Visitante (ID_Visitante, Nome, CPF, Telefone, Email, Endereco, Idade, ativo)
    VALUES (p_ID_Visitante, p_Nome, p_CPF, p_Telefone, p_Email, p_Endereco, p_Idade, TRUE);
END //
DELIMITER ;

-- Procedure para Atualização de Visitante
DELIMITER //
CREATE PROCEDURE sp_update_visitante (
    IN p_ID_Visitante INT,
    IN p_Nome VARCHAR(100),
    IN p_CPF VARCHAR(14),
    IN p_Telefone VARCHAR(20),
    IN p_Email VARCHAR(100),
    IN p_Endereco VARCHAR(255),
    IN p_Idade INT
)
BEGIN
    UPDATE Visitante
    SET Nome = p_Nome,
        CPF = p_CPF,
        Telefone = p_Telefone,
        Email = p_Email,
        Endereco = p_Endereco,
        Idade = p_Idade
    WHERE ID_Visitante = p_ID_Visitante;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Visitante
DELIMITER //
CREATE PROCEDURE sp_delete_logico_visitante (
    IN p_ID_Visitante INT
)
BEGIN
    UPDATE Visitante
    SET ativo = FALSE
    WHERE ID_Visitante = p_ID_Visitante;
END //
DELIMITER ;



-- ----------------------------------------------
-- Tabela: Promocao
-- ----------------------------------------------

-- Procedure para Inclusão de Promocao
DELIMITER //
CREATE PROCEDURE sp_insert_promocao (
    IN p_ID_Promocao INT,
    IN p_Codigo_Promocional VARCHAR(50),
    IN p_Tipo_Desconto VARCHAR(50),
    IN p_Data_Inicio DATE,
    IN p_Desconto_Valor DECIMAL(10,2),
    IN p_Data_Fim DATE
)
BEGIN
    INSERT INTO Promocao (ID_Promocao, Codigo_Promocional, Tipo_Desconto, Data_Inicio, Desconto_Valor, Data_Fim, ativo)
    VALUES (p_ID_Promocao, p_Codigo_Promocional, p_Tipo_Desconto, p_Data_Inicio, p_Desconto_Valor, p_Data_Fim, TRUE);
END //
DELIMITER ;

-- Procedure para Atualização de Promocao
DELIMITER //
CREATE PROCEDURE sp_update_promocao (
    IN p_ID_Promocao INT,
    IN p_Codigo_Promocional VARCHAR(50),
    IN p_Tipo_Desconto VARCHAR(50),
    IN p_Data_Inicio DATE,
    IN p_Desconto_Valor DECIMAL(10,2),
    IN p_Data_Fim DATE
)
BEGIN
    UPDATE Promocao
    SET Codigo_Promocional = p_Codigo_Promocional,
        Tipo_Desconto = p_Tipo_Desconto,
        Data_Inicio = p_Data_Inicio,
        Desconto_Valor = p_Desconto_Valor,
        Data_Fim = p_Data_Fim
    WHERE ID_Promocao = p_ID_Promocao;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Promocao
DELIMITER //
CREATE PROCEDURE sp_delete_logico_promocao (
    IN p_ID_Promocao INT
)
BEGIN
    UPDATE Promocao
    SET ativo = FALSE
    WHERE ID_Promocao = p_ID_Promocao;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: Detalhes_Pagamento
-- ----------------------------------------------

-- Procedure para Inclusão de Detalhes_Pagamento
DELIMITER //
CREATE PROCEDURE sp_insert_detalhes_pagamento (
    IN p_ID_Pagamento INT,
    IN p_Nome_Titular_Cartao VARCHAR(100),
    IN p_Numero_Cartao VARCHAR(20),
    IN p_Cartao_Validade VARCHAR(7),
    IN p_Codigo_Boleto VARCHAR(50),
    IN p_Metodo VARCHAR(50)
)
BEGIN
    INSERT INTO Detalhes_Pagamento (ID_Pagamento, Nome_Titular_Cartao, Numero_Cartao, Cartao_Validade, Codigo_Boleto, Metodo, ativo)
    VALUES (p_ID_Pagamento, p_Nome_Titular_Cartao, p_Numero_Cartao, p_Cartao_Validade, p_Codigo_Boleto, p_Metodo, TRUE);
END //
DELIMITER ;

-- Procedure para Atualização de Detalhes_Pagamento
DELIMITER //
CREATE PROCEDURE sp_update_detalhes_pagamento (
    IN p_ID_Pagamento INT,
    IN p_Nome_Titular_Cartao VARCHAR(100),
    IN p_Numero_Cartao VARCHAR(20),
    IN p_Cartao_Validade VARCHAR(7),
    IN p_Codigo_Boleto VARCHAR(50),
    IN p_Metodo VARCHAR(50)
)
BEGIN
    UPDATE Detalhes_Pagamento
    SET Nome_Titular_Cartao = p_Nome_Titular_Cartao,
        Numero_Cartao = p_Numero_Cartao,
        Cartao_Validade = p_Cartao_Validade,
        Codigo_Boleto = p_Codigo_Boleto,
        Metodo = p_Metodo
    WHERE ID_Pagamento = p_ID_Pagamento;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Detalhes_Pagamento
DELIMITER //
CREATE PROCEDURE sp_delete_logico_detalhes_pagamento (
    IN p_ID_Pagamento INT
)
BEGIN
    UPDATE Detalhes_Pagamento
    SET ativo = FALSE
    WHERE ID_Pagamento = p_ID_Pagamento;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: Pagamento
-- ----------------------------------------------

-- Procedure para Inclusão de Pagamento
DELIMITER //
CREATE PROCEDURE sp_insert_pagamento (
    IN p_ID_Pagamento INT,
    IN p_Metodo VARCHAR(50),
    IN p_Status_Compra VARCHAR(50),
    IN p_Data_Processamento DATETIME,
    IN p_fk_Detalhes_Pagamento_ID INT
)
BEGIN
    INSERT INTO Pagamento (ID_Pagamento, Metodo, Status_Compra, Data_Processamento, fk_Detalhes_Pagamento_ID)
    VALUES (p_ID_Pagamento, p_Metodo, p_Status_Compra, p_Data_Processamento, p_fk_Detalhes_Pagamento_ID);
END //
DELIMITER ;

-- Procedure para Atualização de Pagamento
DELIMITER //
CREATE PROCEDURE sp_update_pagamento (
    IN p_ID_Pagamento INT,
    IN p_Metodo VARCHAR(50),
    IN p_Status_Compra VARCHAR(50),
    IN p_Data_Processamento DATETIME,
    IN p_fk_Detalhes_Pagamento_ID INT
)
BEGIN
    UPDATE Pagamento
    SET Metodo = p_Metodo,
        Status_Compra = p_Status_Compra,
        Data_Processamento = p_Data_Processamento,
        fk_Detalhes_Pagamento_ID = p_fk_Detalhes_Pagamento_ID
    WHERE ID_Pagamento = p_ID_Pagamento;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Pagamento (Atualiza Status)
DELIMITER //
CREATE PROCEDURE sp_delete_logico_pagamento (
    IN p_ID_Pagamento INT
)
BEGIN
    UPDATE Pagamento
    SET Status_Compra = 'Cancelado' -- Usando status existente para exclusão lógica
    WHERE ID_Pagamento = p_ID_Pagamento;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: Compra
-- ----------------------------------------------

-- Procedure para Inclusão de Compra
DELIMITER //
CREATE PROCEDURE sp_insert_compra (
    IN p_ID_Compra INT,
    IN p_Data_Compra DATETIME,
    IN p_Valor_Total DECIMAL(10,2),
    IN p_fk_Visitante_ID_Visitante INT,
    IN p_fk_Promocao_ID_Promocao INT,
    IN p_fk_Pagamento_ID_Pagamento INT
)
BEGIN
    INSERT INTO Compra (ID_Compra, Data_Compra, Valor_Total, fk_Visitante_ID_Visitante, fk_Promocao_ID_Promocao, fk_Pagamento_ID_Pagamento, ativo)
    VALUES (p_ID_Compra, p_Data_Compra, p_Valor_Total, p_fk_Visitante_ID_Visitante, p_fk_Promocao_ID_Promocao, p_fk_Pagamento_ID_Pagamento, TRUE);
END //
DELIMITER ;

-- Procedure para Atualização de Compra
DELIMITER //
CREATE PROCEDURE sp_update_compra (
    IN p_ID_Compra INT,
    IN p_Data_Compra DATETIME,
    IN p_Valor_Total DECIMAL(10,2),
    IN p_fk_Visitante_ID_Visitante INT,
    IN p_fk_Promocao_ID_Promocao INT,
    IN p_fk_Pagamento_ID_Pagamento INT
)
BEGIN
    UPDATE Compra
    SET Data_Compra = p_Data_Compra,
        Valor_Total = p_Valor_Total,
        fk_Visitante_ID_Visitante = p_fk_Visitante_ID_Visitante,
        fk_Promocao_ID_Promocao = p_fk_Promocao_ID_Promocao,
        fk_Pagamento_ID_Pagamento = p_fk_Pagamento_ID_Pagamento
    WHERE ID_Compra = p_ID_Compra;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Compra
DELIMITER //
CREATE PROCEDURE sp_delete_logico_compra (
    IN p_ID_Compra INT
)
BEGIN
    UPDATE Compra
    SET ativo = FALSE
    WHERE ID_Compra = p_ID_Compra;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: Tipo
-- ----------------------------------------------

-- Procedure para Inclusão de Tipo
DELIMITER //
CREATE PROCEDURE sp_insert_tipo (
    IN p_ID_Tipo INT,
    IN p_Tipo_Ingresso VARCHAR(100),
    IN p_Descricao TEXT,
    IN p_Quantidade_Disponivel INT,
    IN p_Preco DECIMAL(10,2)
)
BEGIN
    INSERT INTO Tipo (ID_Tipo, Tipo_Ingresso, Descricao, Quantidade_Disponivel, Preco, ativo)
    VALUES (p_ID_Tipo, p_Tipo_Ingresso, p_Descricao, p_Quantidade_Disponivel, p_Preco, TRUE);
END //
DELIMITER ;

-- Procedure para Atualização de Tipo
DELIMITER //
CREATE PROCEDURE sp_update_tipo (
    IN p_ID_Tipo INT,
    IN p_Tipo_Ingresso VARCHAR(100),
    IN p_Descricao TEXT,
    IN p_Quantidade_Disponivel INT,
    IN p_Preco DECIMAL(10,2)
)
BEGIN
    UPDATE Tipo
    SET Tipo_Ingresso = p_Tipo_Ingresso,
        Descricao = p_Descricao,
        Quantidade_Disponivel = p_Quantidade_Disponivel,
        Preco = p_Preco
    WHERE ID_Tipo = p_ID_Tipo;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Tipo
DELIMITER //
CREATE PROCEDURE sp_delete_logico_tipo (
    IN p_ID_Tipo INT
)
BEGIN
    UPDATE Tipo
    SET ativo = FALSE
    WHERE ID_Tipo = p_ID_Tipo;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: CHECKIN_Ingresso
-- ----------------------------------------------

-- Procedure para Inclusão de CHECKIN_Ingresso
-- (Será modificada/usada pela transação posteriormente)
DELIMITER //
CREATE PROCEDURE sp_insert_checkin_ingresso (
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
    IN p_fk_Tipo_ID_Tipo INT
)
BEGIN
    INSERT INTO CHECKIN_Ingresso (ID_CHECKIN, Data_Hora, Status, Preco, Tutor_s_n, ID_Ingresso, Data_Visita, Data_Hora_Checkin, Status_Ingresso, fk_Compra_ID_Compra, fk_Tipo_ID_Tipo)
    VALUES (p_ID_CHECKIN, p_Data_Hora, p_Status, p_Preco, p_Tutor_s_n, p_ID_Ingresso, p_Data_Visita, p_Data_Hora_Checkin, p_Status_Ingresso, p_fk_Compra_ID_Compra, p_fk_Tipo_ID_Tipo);
END //
DELIMITER ;

-- Procedure para Atualização de CHECKIN_Ingresso
DELIMITER //
CREATE PROCEDURE sp_update_checkin_ingresso (
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
    IN p_fk_Tipo_ID_Tipo INT
)
BEGIN
    UPDATE CHECKIN_Ingresso
    SET Data_Hora = p_Data_Hora,
        Status = p_Status,
        Preco = p_Preco,
        Tutor_s_n = p_Tutor_s_n,
        ID_Ingresso = p_ID_Ingresso,
        Data_Visita = p_Data_Visita,
        Data_Hora_Checkin = p_Data_Hora_Checkin,
        Status_Ingresso = p_Status_Ingresso,
        fk_Compra_ID_Compra = p_fk_Compra_ID_Compra,
        fk_Tipo_ID_Tipo = p_fk_Tipo_ID_Tipo
    WHERE ID_CHECKIN = p_ID_CHECKIN;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de CHECKIN_Ingresso (Atualiza Status)
DELIMITER //
CREATE PROCEDURE sp_delete_logico_checkin_ingresso (
    IN p_ID_CHECKIN INT
)
BEGIN
    UPDATE CHECKIN_Ingresso
    SET Status_Ingresso = 'Cancelado' -- Usando status existente para exclusão lógica
    WHERE ID_CHECKIN = p_ID_CHECKIN;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: Avaliacao
-- ----------------------------------------------

-- Procedure para Inclusão de Avaliacao
DELIMITER //
CREATE PROCEDURE sp_insert_avaliacao (
    IN p_ID_Avaliacao INT,
    IN p_Nota INT,
    IN p_Comentarios TEXT,
    IN p_Data_Avaliacao DATE,
    IN p_fk_Visitante_ID_Visitante INT,
    IN p_fk_Ingresso_ID_Ingresso INT
)
BEGIN
    INSERT INTO Avaliacao (ID_Avaliacao, Nota, Comentarios, Data_Avaliacao, fk_Visitante_ID_Visitante, fk_Ingresso_ID_Ingresso, ativo)
    VALUES (p_ID_Avaliacao, p_Nota, p_Comentarios, p_Data_Avaliacao, p_fk_Visitante_ID_Visitante, p_fk_Ingresso_ID_Ingresso, TRUE);
END //
DELIMITER ;

-- Procedure para Atualização de Avaliacao
DELIMITER //
CREATE PROCEDURE sp_update_avaliacao (
    IN p_ID_Avaliacao INT,
    IN p_Nota INT,
    IN p_Comentarios TEXT,
    IN p_Data_Avaliacao DATE,
    IN p_fk_Visitante_ID_Visitante INT,
    IN p_fk_Ingresso_ID_Ingresso INT
)
BEGIN
    UPDATE Avaliacao
    SET Nota = p_Nota,
        Comentarios = p_Comentarios,
        Data_Avaliacao = p_Data_Avaliacao,
        fk_Visitante_ID_Visitante = p_fk_Visitante_ID_Visitante,
        fk_Ingresso_ID_Ingresso = p_fk_Ingresso_ID_Ingresso
    WHERE ID_Avaliacao = p_ID_Avaliacao;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Avaliacao
DELIMITER //
CREATE PROCEDURE sp_delete_logico_avaliacao (
    IN p_ID_Avaliacao INT
)
BEGIN
    UPDATE Avaliacao
    SET ativo = FALSE
    WHERE ID_Avaliacao = p_ID_Avaliacao;
END //
DELIMITER ;

-- ----------------------------------------------
-- Tabela: Reembolso
-- ----------------------------------------------

-- Procedure para Inclusão de Reembolso
DELIMITER //
CREATE PROCEDURE sp_insert_reembolso (
    IN p_ID_Reembolso INT,
    IN p_Data_Solicitacao DATE,
    IN p_Status VARCHAR(50),
    IN p_Valor_Reembolso DECIMAL(10,2),
    IN p_Motivo TEXT,
    IN p_fk_CHECKIN_Ingresso_ID INT
)
BEGIN
    INSERT INTO Reembolso (ID_Reembolso, Data_Solicitacao, Status, Valor_Reembolso, Motivo, fk_CHECKIN_Ingresso_ID)
    VALUES (p_ID_Reembolso, p_Data_Solicitacao, p_Status, p_Valor_Reembolso, p_Motivo, p_fk_CHECKIN_Ingresso_ID);
END //
DELIMITER ;

-- Procedure para Atualização de Reembolso
DELIMITER //
CREATE PROCEDURE sp_update_reembolso (
    IN p_ID_Reembolso INT,
    IN p_Data_Solicitacao DATE,
    IN p_Status VARCHAR(50),
    IN p_Valor_Reembolso DECIMAL(10,2),
    IN p_Motivo TEXT,
    IN p_fk_CHECKIN_Ingresso_ID INT
)
BEGIN
    UPDATE Reembolso
    SET Data_Solicitacao = p_Data_Solicitacao,
        Status = p_Status,
        Valor_Reembolso = p_Valor_Reembolso,
        Motivo = p_Motivo,
        fk_CHECKIN_Ingresso_ID = p_fk_CHECKIN_Ingresso_ID
    WHERE ID_Reembolso = p_ID_Reembolso;
END //
DELIMITER ;

-- Procedure para Exclusão Lógica de Reembolso (Atualiza Status)
DELIMITER //
CREATE PROCEDURE sp_delete_logico_reembolso (
    IN p_ID_Reembolso INT
)
BEGIN
    UPDATE Reembolso
    SET Status = 'Cancelado' -- Usando status existente para exclusão lógica
    WHERE ID_Reembolso = p_ID_Reembolso;
END //
DELIMITER ;