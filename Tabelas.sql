-- Criação do banco de dados e seleção do mesmo
CREATE DATABASE projeto_Zoologico_;
USE projeto_Zoologico_;

CREATE TABLE Visitante (
    ID_Visitante INT PRIMARY KEY,
    Nome VARCHAR(100),
    CPF VARCHAR(14),
    Telefone VARCHAR(20),
    Email VARCHAR(100),
    Endereco VARCHAR(255),
    Idade INT
);

CREATE TABLE Promocao (
    ID_Promocao INT PRIMARY KEY,
    Codigo_Promocional VARCHAR(50),
    Tipo_Desconto VARCHAR(50),
    Data_Inicio DATE,
    Desconto_Valor DECIMAL(10,2),
    Data_Fim DATE
);

CREATE TABLE Detalhes_Pagamento (
    ID_Pagamento INT PRIMARY KEY,
    Nome_Titular_Cartao VARCHAR(100),
    Numero_Cartao VARCHAR(20),
    Cartao_Validade VARCHAR(7),
    Codigo_Boleto VARCHAR(50),
    Metodo VARCHAR(50)
);

CREATE TABLE Pagamento (
    ID_Pagamento INT PRIMARY KEY,
    Metodo VARCHAR(50),
    Status_Compra VARCHAR(50),
    Data_Processamento DATETIME,
    fk_Detalhes_Pagamento_ID INT,
    CONSTRAINT fk_Pagamento_Detalhes FOREIGN KEY (fk_Detalhes_Pagamento_ID) REFERENCES Detalhes_Pagamento(ID_Pagamento)
);

CREATE TABLE Compra (
    ID_Compra INT PRIMARY KEY,
    Data_Compra DATETIME,
    Valor_Total DECIMAL(10,2),
    fk_Visitante_ID_Visitante INT,
    fk_Promocao_ID_Promocao INT,
    fk_Pagamento_ID_Pagamento INT,
    CONSTRAINT fk_Compra_Visitante FOREIGN KEY (fk_Visitante_ID_Visitante) REFERENCES Visitante(ID_Visitante),
    CONSTRAINT fk_Compra_Promocao FOREIGN KEY (fk_Promocao_ID_Promocao) REFERENCES Promocao(ID_Promocao),
    CONSTRAINT fk_Compra_Pagamento FOREIGN KEY (fk_Pagamento_ID_Pagamento) REFERENCES Pagamento(ID_Pagamento)
);

CREATE TABLE Tipo (
    ID_Tipo INT PRIMARY KEY,
    Tipo_Ingresso VARCHAR(100),
    Descricao TEXT,
    Quantidade_Disponivel INT,
    Preco DECIMAL(10,2)
);

CREATE TABLE CHECKIN_Ingresso (
    ID_CHECKIN INT PRIMARY KEY AUTO_INCREMENT,
    Data_Hora DATETIME NOT NULL,
    Status VARCHAR(50) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL,
    ID_Ingresso INT NOT NULL,
    Data_Visita DATE NOT NULL,
    Data_Hora_Checkin DATETIME NOT NULL,
    Status_Ingresso VARCHAR(50) NOT NULL,
    fk_Compra_ID_Compra INT NOT NULL,
    fk_Tipo_ID_Tipo INT NOT NULL,
    CONSTRAINT fk_Checkin_Compra FOREIGN KEY (fk_Compra_ID_Compra) REFERENCES Compra(ID_Compra),
    CONSTRAINT fk_Checkin_Tipo FOREIGN KEY (fk_Tipo_ID_Tipo) REFERENCES Tipo(ID_Tipo)
);


CREATE TABLE Avaliacao (
    ID_Avaliacao INT PRIMARY KEY,
    Nota INT,
    Comentarios TEXT,
    Data_Avaliacao DATE,
    fk_Visitante_ID_Visitante INT,
    fk_Ingresso_ID_Ingresso INT,
    CONSTRAINT fk_Avaliacao_Visitante FOREIGN KEY (fk_Visitante_ID_Visitante) REFERENCES Visitante(ID_Visitante),
    CONSTRAINT fk_Avaliacao_Checkin FOREIGN KEY (fk_Ingresso_ID_Ingresso) REFERENCES CHECKIN_Ingresso(ID_CHECKIN)
);

CREATE TABLE Reembolso (
    ID_Reembolso INT PRIMARY KEY,
    Data_Solicitacao DATE,
    Status VARCHAR(50),
    Valor_Reembolso DECIMAL(10,2),
    Motivo TEXT,
    fk_CHECKIN_Ingresso_ID INT,
    CONSTRAINT fk_Reembolso_Checkin FOREIGN KEY (fk_CHECKIN_Ingresso_ID) REFERENCES CHECKIN_Ingresso(ID_CHECKIN)
);
