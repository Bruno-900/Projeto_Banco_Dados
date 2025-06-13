INSERT INTO Visitante (ID_Visitante, Nome, CPF, Telefone, Email, Endereco, Idade) VALUES
(1, 'Ana Silva',    '123.456.789-00', '(11) 91234-0001', 'ana.silva@example.com',    'Rua A, 100', 28),
(2, 'Bruno Costa',  '987.654.321-11', '(11) 91234-0002', 'bruno.costa@example.com',  'Av. B, 200', 35),
(3, 'Carla Souza',  '111.222.333-44', '(11) 91234-0003', 'carla.souza@example.com',  'Trav. C, 300', 22),
(4, 'Diego Rocha',  '555.666.777-88', '(11) 91234-0004', 'diego.rocha@example.com',  'Praça D, 400', 41),
(5, 'Elisa Martins','999.888.777-66', '(11) 91234-0005', 'elisa.martins@example.com','Alameda E, 500', 30);

INSERT INTO Promocao (ID_Promocao, Codigo_Promocional, Tipo_Desconto, Data_Inicio, Desconto_Valor, Data_Fim) VALUES
(1, 'PROMO10', 'Percentual', '2025-01-01', 10.00, '2025-03-31'),
(2, 'PROMO20', 'Percentual', '2025-02-15', 20.00, '2025-04-15'),
(3, 'FLAT50',  'Valor Fixo', '2025-03-01', 50.00, '2025-05-01'),
(4, 'EARLYBIRD', 'Percentual','2025-04-01', 15.00, '2025-04-30'),
(5, 'VIP5',    'Percentual', '2025-01-10', 5.00,  '2025-12-31');

INSERT INTO Detalhes_Pagamento (ID_Pagamento, Nome_Titular_Cartao, Numero_Cartao, Cartao_Validade, Codigo_Boleto, Metodo) VALUES
(1, 'Ana Silva',     '4111111111111111', '12/26', 'BOLETO001', 'Cartão'),
(2, 'Bruno Costa',   '5555555555554444', '11/25', 'BOLETO002', 'Cartão'),
(3, 'Carla Souza',   '378282246310005',  '10/24', 'BOLETO003', 'Cartão'),
(4, 'Diego Rocha',   NULL,               NULL,     'BOLETO004', 'Boleto'),
(5, 'Elisa Martins', '6011111111111117', '09/27', 'BOLETO005', 'Cartão');

-- 4) Pagamento (usa subquery para fk_Detalhes_Pagamento_ID)
INSERT INTO Pagamento (ID_Pagamento, Metodo, Status_Compra, Data_Processamento, fk_Detalhes_Pagamento_ID) VALUES
(1, 'Cartão', 'Concluído','2025-04-01 10:00:00',
    (SELECT ID_Pagamento FROM Detalhes_Pagamento WHERE Numero_Cartao = '4111111111111111')),
(2, 'Cartão', 'Pendente', '2025-04-02 11:30:00',
    (SELECT ID_Pagamento FROM Detalhes_Pagamento WHERE Numero_Cartao = '5555555555554444')),
(3, 'Cartão', 'Concluído','2025-04-03 12:45:00',
    (SELECT ID_Pagamento FROM Detalhes_Pagamento WHERE Numero_Cartao = '378282246310005')),
(4, 'Boleto', 'Concluído','2025-04-04 14:00:00',
    (SELECT ID_Pagamento FROM Detalhes_Pagamento WHERE Codigo_Boleto   = 'BOLETO004')),
(5, 'Cartão', 'Cancelado','2025-04-05 15:15:00',
    (SELECT ID_Pagamento FROM Detalhes_Pagamento WHERE Numero_Cartao = '6011111111111117'));

INSERT INTO Compra (ID_Compra, Data_Compra, Valor_Total, fk_Visitante_ID_Visitante, fk_Promocao_ID_Promocao, fk_Pagamento_ID_Pagamento) VALUES
(1, '2025-04-10 09:00:00', 150.00,
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Ana Silva'),
    (SELECT ID_Promocao  FROM Promocao  WHERE Codigo_Promocional = 'PROMO10'),
    (SELECT ID_Pagamento FROM Pagamento WHERE Status_Compra = 'Concluído' AND ID_Pagamento = 1)),
(2, '2025-04-11 10:30:00', 200.00,
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Bruno Costa'),
    (SELECT ID_Promocao  FROM Promocao  WHERE Codigo_Promocional = 'PROMO20'),
    (SELECT ID_Pagamento FROM Pagamento WHERE ID_Pagamento = 2)),
(3, '2025-04-12 11:45:00', 120.00,
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Carla Souza'),
    (SELECT ID_Promocao  FROM Promocao  WHERE Codigo_Promocional = 'FLAT50'),
    (SELECT ID_Pagamento FROM Pagamento WHERE ID_Pagamento = 3)),
(4, '2025-04-13 14:20:00', 300.00,
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Diego Rocha'),
    (SELECT ID_Promocao  FROM Promocao  WHERE Codigo_Promocional = 'EARLYBIRD'),
    (SELECT ID_Pagamento FROM Pagamento WHERE ID_Pagamento = 4)),
(5, '2025-04-14 16:00:00',  80.00,
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Elisa Martins'),
    (SELECT ID_Promocao  FROM Promocao  WHERE Codigo_Promocional = 'VIP5'),
    (SELECT ID_Pagamento FROM Pagamento WHERE ID_Pagamento = 5));


INSERT INTO Tipo (ID_Tipo, Tipo_Ingresso, Descricao, Quantidade_Disponivel, Preco) VALUES
(1, 'Adulto',   'Ingresso para adultos',   100, 50.00),
(2, 'Criança',  'Ingresso infantil',       50,  25.00),
(3, 'Idoso',    'Ingresso para idosos',    30,  30.00),
(4, 'Estudante','Ingresso para estudantes',70,  40.00),
(5, 'VIP',      'Ingresso VIP',            20, 100.00);

INSERT INTO CHECKIN_Ingresso (
    Data_Hora, Status, Preco, ID_Ingresso, Data_Visita, Data_Hora_Checkin, Status_Ingresso, fk_Compra_ID_Compra, fk_Tipo_ID_Tipo
) VALUES
('2025-04-15 09:05:00', 'Ativo', 50.00, 1, '2025-05-01', '2025-05-01 09:05:00', 'Usado', 
    (SELECT ID_Compra FROM Compra WHERE ID_Compra = 1), 
    (SELECT ID_Tipo FROM Tipo WHERE Tipo_Ingresso = 'Adulto')),
('2025-04-15 09:10:00', 'Ativo', 25.00, 2, '2025-05-02', '2025-05-02 09:10:00', 'Usado', 
    (SELECT ID_Compra FROM Compra WHERE ID_Compra = 2), 
    (SELECT ID_Tipo FROM Tipo WHERE Tipo_Ingresso = 'Criança')),
('2025-04-15 09:15:00', 'Ativo', 30.00, 3, '2025-05-03', '2025-05-03 09:15:00', 'Usado', 
    (SELECT ID_Compra FROM Compra WHERE ID_Compra = 3), 
    (SELECT ID_Tipo FROM Tipo WHERE Tipo_Ingresso = 'Idoso')),
('2025-04-15 09:20:00', 'Ativo', 40.00, 4, '2025-05-04', '2025-05-04 09:20:00', 'Usado', 
    (SELECT ID_Compra FROM Compra WHERE ID_Compra = 4), 
    (SELECT ID_Tipo FROM Tipo WHERE Tipo_Ingresso = 'Estudante')),
('2025-04-15 09:25:00', 'Ativo', 100.00, 5, '2025-05-05', '2025-05-05 09:25:00', 'Usado', 
    (SELECT ID_Compra FROM Compra WHERE ID_Compra = 5), 
    (SELECT ID_Tipo FROM Tipo WHERE Tipo_Ingresso = 'VIP'));

INSERT INTO Avaliacao (ID_Avaliacao, Nota, Comentarios, Data_Avaliacao, fk_Visitante_ID_Visitante, fk_Ingresso_ID_Ingresso) VALUES
(1, 5, 'Excelente experiência', '2025-05-02',
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Ana Silva'),
    (SELECT ID_CHECKIN  FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 1)),
(2, 4, 'Muito bom, porém poderia melhorar', '2025-05-03',
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Bruno Costa'),
    (SELECT ID_CHECKIN  FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 2)),
(3, 3, 'Ok, mas fila longa', '2025-05-04',
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Carla Souza'),
    (SELECT ID_CHECKIN  FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 3)),
(4, 5, 'Adorei!', '2025-05-05',
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Diego Rocha'),
    (SELECT ID_CHECKIN  FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 4)),
(5, 2, 'Pouca organização', '2025-05-06',
    (SELECT ID_Visitante FROM Visitante WHERE Nome = 'Elisa Martins'),
    (SELECT ID_CHECKIN  FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 5));

INSERT INTO Reembolso (ID_Reembolso, Data_Solicitacao, Status, Valor_Reembolso, Motivo, fk_CHECKIN_Ingresso_ID) VALUES
(1, '2025-05-07', 'Aprovado', 50.00, 'Mudança de planos',
    (SELECT ID_CHECKIN FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 1)),
(2, '2025-05-08', 'Pendente', 25.00, 'Problema de saúde',
    (SELECT ID_CHECKIN FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 2)),
(3, '2025-05-09', 'Negado',   0.00,  'Atraso no check-in',
    (SELECT ID_CHECKIN FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 3)),
(4, '2025-05-10', 'Aprovado',100.00, 'Evento cancelado',
    (SELECT ID_CHECKIN FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 5)),
(5, '2025-05-11', 'Pendente', 40.00, 'Problema de transporte',
    (SELECT ID_CHECKIN FROM CHECKIN_Ingresso WHERE ID_CHECKIN = 4));
