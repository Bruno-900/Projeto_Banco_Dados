O objetivo principal é criar um sistema que permita o controle informatizado de visitantes, vendas de ingressos, promoções, pagamentos e avaliações. A automação desses processos visa melhorar a experiência do visitante, aumentar a eficiência operacional e fornecer dados precisos para a gestão estratégica do negócio.
MER:

 Gestão de Visitantes:
•	Cada visitante deve ser único, identificado por um CPF exclusivo.
•	É importante registrar informações de contato (e-mail, endereço) para futuras comunicações e promoções.
•	A idade do visitante é relevante para futuras segmentações e ofertas específicas.
Gestão de Promoções:
•	O zoológico pode oferecer diferentes tipos de descontos (percentual ou valor fixo) com códigos promocionais únicos.
•	Cada promoção terá um período de validade (data de início e fim).
•	Descontos percentuais devem estar entre 0% e 100%, enquanto descontos de valor fixo devem ser maiores que zero.
•	A data de fim de uma promoção deve ser sempre igual ou posterior à data de início.
 Processo de Compra:
•	Uma compra é realizada por um visitante e pode ou não utilizar um código promocional.
•	É necessário registrar o valor total da compra e a data em que foi efetuada.
•	Cada compra está associada a um único visitante e pode estar vinculada a uma única promoção.
Gestão de Pagamentos:
•	O sistema deve registrar o status de cada pagamento (aprovado, pendente, recusado).
•	A data e hora do processamento do pagamento devem ser armazenadas.
•	Cada pagamento está vinculado a uma única compra.
Detalhes do Pagamento:
•	O sistema deve suportar diferentes métodos de pagamento: cartão de crédito, cartão de débito, boleto bancário e PIX.
•	Para pagamentos com cartão, é necessário registrar o nome do titular, a validade e os últimos quatro dígitos do cartão.
•	Para pagamentos com PIX, a chave PIX deve ser armazenada.
•	Para pagamentos com boleto, o código de barras (44 dígitos) deve ser registrado.
•	Apenas um método de pagamento deve ser preenchido por transação.
Gestão de Tipos de Ingressos:
•	Diferentes tipos de ingressos (exemplo: adulto, infantil, estudante) possuem preços e descrições distintas.
•	É crucial controlar a quantidade disponível de cada tipo de ingresso.
•	O preço de cada tipo de ingresso deve ser maior que zero, e a quantidade disponível não pode ser negativa.
Gestão de Ingressos:
•	Cada ingresso possui uma data específica para a visita.
•	O sistema deve registrar a data e hora do check-in do visitante (quando o ingresso é utilizado).
•	O status do ingresso pode ser pendente, utilizado ou cancelado.
•	Um ingresso pode estar associado a um tutor (campo booleano para indicar se há um tutor).
•	Cada ingresso está vinculado a uma única compra e a um único tipo de ingresso.
•	Se houver um tutor associado ao ingresso, o ID do tutor deve ser registrado. 
MR do banco:

VIEWS para Relatórios Gerenciais 

1. VIEW: Relatório de Vendas Mensais por Tipo de Ingresso
Ajudará a entender quais tipos de ingresso são mais populares e como as vendas e a receita de cada tipo variam mês a mês.

Análise Gerencial:
•	Identificar os tipos de ingresso mais rentáveis.
•	Analisar tendências de vendas mensais para cada tipo de ingresso.
•	Ajustar estratégias de precificação e marketing com base na popularidade e receita.
•	Gerenciar o estoque de ingressos (Quantidade_Disponivel na tabela Tipo).

2. VIEW: Relatório de Desempenho de Promoções

Esta view permitirá avaliar a eficácia de diferentes promoções, mostrando quantas vendas cada uma gerou e o valor total dessas vendas.
Análise Gerencial:
•	Identificar quais promoções geram mais vendas e receita.
•	Avaliar o ROI (Retorno Sobre o Investimento) de cada promoção.
•	Decidir se uma promoção deve ser continuada, modificada ou descontinuada.
•	Planejar futuras campanhas promocionais com base no desempenho histórico.

3. VIEW: Relatório de Perfil e Engajamento de Visitantes

Esta view ajuda a entender o perfil dos visitantes (idade) e seu engajamento, como frequência de compras e gasto total, além da média de avaliação fornecida.

Análise Gerencial:
•	Segmentar visitantes por idade e comportamento de compra.
•	Identificar os visitantes mais valiosos (alto gasto, alta frequência).
•	Personalizar ofertas e comunicação para diferentes segmentos de visitantes.
•	Entender a satisfação geral dos visitantes através das avaliações.

4. VIEW: Relatório de Status de Pagamentos e Tendências de Métodos

Esta view oferece uma visão geral dos status de pagamento, métodos mais utilizados e possíveis problemas em processamentos.

Análise Gerencial:
•	Monitorar a taxa de sucesso e falha de pagamentos por método.
•	Identificar os métodos de pagamento mais populares entre os clientes.
•	Detectar tendências ou problemas com processadoras de pagamento específicas.
•	Otimizar a oferta de métodos de pagamento.

5. VIEW: Relatório de Ocupação e Check-ins por Data e Tipo de Ingresso

Esta view ajuda a gerenciar a capacidade e entender os padrões de visita, mostrando o número de check-ins por data e tipo de ingresso.

Análise Gerencial:
•	Analisar os dias e horários de pico de visitação.
•	Planejar a alocação de staff e recursos com base na previsão de ocupação.
•	Entender a demanda por diferentes tipos de ingresso em dias específicos.
•	Avaliar a necessidade de ingressos com acompanhamento de tutor.

Criação de 3 Índices para Agilizar Consultas Frequentes

1. Índice na tabela Compra para otimizar buscas por data e visitante.
Consultas que filtram compras por data ou por um visitante específico são comuns para relatórios e análises.

Justificativa:
•	Data_Compra: Frequentemente usado em cláusulas WHERE para filtrar por períodos (dia, mês, ano) e em ORDER BY.
•	fk_Visitante_ID_Visitante: Usado em JOINs com a tabela Visitante e em filtros para obter o histórico de um cliente.

2. Índice na tabela CHECKIN_Ingresso para otimizar consultas por data de visita e tipo de ingresso.

Esta tabela é central para relatórios de check-in, ocupação e validação de ingressos.

Justificativa:
•	Data_Visita: Essencial para filtrar check-ins por dia específico.
•	fk_Tipo_ID_Tipo: Usado em JOINs com a tabela Tipo e para agregar dados por tipo de ingresso.
•	fk_Compra_ID_Compra: Usado em JOINs com a tabela Compra para relacionar o check-in à transação original.
3. Índice na tabela Visitante para buscas por CPF e Email.

CPF e Email são campos frequentemente utilizados para localizar um visitante específico ou para verificar duplicidade.

Justificativa:
•	CPF: É um identificador único e frequentemente usado em buscas diretas.
•	Email: Também usado para identificar visitantes e em comunicações, sendo um campo comum em cláusulas WHERE.

Conclusão

Esta abordagem modular e cuidadosamente estruturada permite que o zoológico obtenha um controle eficiente de todos os processos envolvendo visitantes, vendas, pagamentos e feedback, além de garantir que a segurança e a integridade do espaço sejam mantidas. Ao automatizar essas funções, o sistema não só melhora a experiência do visitante, mas também fornece dados precisos para tomadas de decisão estratégicas, assegurando a sustentabilidade e a qualidade dos serviços prestados.


