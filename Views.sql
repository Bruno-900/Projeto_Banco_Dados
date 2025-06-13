CREATE VIEW V_Relatorio_Vendas_Mensais_Por_Tipo AS
SELECT
    DATE_FORMAT(C.Data_Compra, '%Y-%m') AS Mes_Ano_Compra,
    T.Tipo_Ingresso,
    COUNT(CI.ID_CHECKIN) AS Quantidade_Vendida,
    SUM(CI.Preco) AS Receita_Total_Por_Tipo,
    AVG(CI.Preco) AS Preco_Medio_Por_Tipo
FROM Compra C
JOIN CHECKIN_Ingresso CI ON C.ID_Compra = CI.fk_Compra_ID_Compra
JOIN Tipo T ON CI.fk_Tipo_ID_Tipo = T.ID_Tipo
GROUP BY
    Mes_Ano_Compra,
    T.Tipo_Ingresso
ORDER BY
    Mes_Ano_Compra DESC,
    Receita_Total_Por_Tipo DESC;


CREATE VIEW V_Relatorio_Desempenho_Promocoes AS
SELECT
    P.Codigo_Promocional,
    P.Tipo_Desconto,
    P.Desconto_Valor,
    COUNT(C.ID_Compra) AS Numero_Vendas_Com_Promocao,
    SUM(C.Valor_Total) AS Valor_Total_Vendas_Com_Promocao,
    P.Data_Inicio,
    P.Data_Fim
FROM Promocao P
LEFT JOIN Compra C ON P.ID_Promocao = C.fk_Promocao_ID_Promocao -- Usar LEFT JOIN para incluir promoções sem vendas
GROUP BY
    P.ID_Promocao,
    P.Codigo_Promocional,
    P.Tipo_Desconto,
    P.Desconto_Valor,
    P.Data_Inicio,
    P.Data_Fim
ORDER BY
    Numero_Vendas_Com_Promocao DESC,
    Valor_Total_Vendas_Com_Promocao DESC;


CREATE VIEW V_Relatorio_Perfil_Engajamento_Visitantes AS
SELECT
    V.ID_Visitante,
    V.Nome AS Nome_Visitante,
    V.Idade AS Idade_Visitante,
    COUNT(DISTINCT C.ID_Compra) AS Total_Compras_Realizadas,
    SUM(C.Valor_Total) AS Gasto_Total_Visitante,
    AVG(C.Valor_Total) AS Gasto_Medio_Por_Compra,
    (SELECT AVG(A.Nota) FROM Avaliacao A WHERE A.fk_Visitante_ID_Visitante = V.ID_Visitante) AS Media_Avaliacoes_Dadas
FROM Visitante V
LEFT JOIN Compra C ON V.ID_Visitante = C.fk_Visitante_ID_Visitante
GROUP BY
    V.ID_Visitante,
    V.Nome,
    V.Idade
ORDER BY
    Gasto_Total_Visitante DESC,
    Total_Compras_Realizadas DESC;


CREATE VIEW V_Relatorio_Status_Pagamentos_Metodos AS
SELECT
    P.Metodo AS Metodo_Pagamento,
    P.Status_Compra,
    COUNT(P.ID_Pagamento) AS Quantidade_Transacoes,
    SUM(C.Valor_Total) AS Valor_Total_Transacionado,
    DATE_FORMAT(P.Data_Processamento, '%Y-%m') AS Mes_Ano_Processamento
FROM Pagamento P
JOIN Compra C ON P.ID_Pagamento = C.fk_Pagamento_ID_Pagamento
GROUP BY
    Mes_Ano_Processamento,
    P.Metodo,
    P.Status_Compra
ORDER BY
    Mes_Ano_Processamento DESC,
    P.Metodo,
    Quantidade_Transacoes DESC;
    
CREATE VIEW V_Relatorio_Ocupacao_Checkins AS
SELECT
    CI.Data_Visita,
    T.Tipo_Ingresso,
    COUNT(CI.ID_CHECKIN) AS Numero_Checkins,
    MIN(CI.Data_Hora_Checkin) AS Horario_Primeiro_Checkin,
    MAX(CI.Data_Hora_Checkin) AS Horario_Ultimo_Checkin
FROM CHECKIN_Ingresso CI
JOIN Tipo T ON CI.fk_Tipo_ID_Tipo = T.ID_Tipo
GROUP BY
    CI.Data_Visita,
    T.Tipo_Ingresso
ORDER BY
    CI.Data_Visita DESC,
    Numero_Checkins DESC;

