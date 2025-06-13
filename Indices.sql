CREATE INDEX IDX_Visitante_CPF_Email
ON Visitante (CPF, Email);

CREATE INDEX IDX_Checkin_DataVisita_Tipo
ON CHECKIN_Ingresso (Data_Visita, fk_Tipo_ID_Tipo, fk_Compra_ID_Compra);

CREATE INDEX IDX_Compra_Data_Visitante
ON Compra (Data_Compra, fk_Visitante_ID_Visitante);
