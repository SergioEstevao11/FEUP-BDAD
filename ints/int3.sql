.mode columns
.headers	on
.nullvalue	NULL

--Numero de Serviços de cada Estação 

SELECT nomeEstacao, COUNT(nomeServico) 
FROM (
    SELECT  nomeEstacao, idRota, nomeServico
    FROM (
        SELECT nomeEstacao, idRota 
        FROM Estacao JOIN Informacao USING (nomeEstacao)) JOIN Rota USING (idRota)
    ) GROUP BY nomeEstacao;