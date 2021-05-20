.mode columns
.headers	on
.nullvalue	NULL

--COMPLETA

SELECT nomeEstacao, COUNT(nomeServico) AS numeroServicos
FROM (
    SELECT  nomeEstacao, nomeServico
    FROM (
        SELECT nomeEstacao, idRota
        FROM Estacao JOIN Informacao USING (nomeEstacao)) JOIN Rota USING (idRota)
    ) GROUP BY nomeEstacao
HAVING numeroServicos > 3;
