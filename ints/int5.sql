.mode columns
.headers	on
.nullvalue	NULL

SELECT nomeEstacao, COUNT(idViagem) AS visits 
FROM(
    SELECT nomeEstacao, idViagem 
    FROM Estacao JOIN Informacao USING(nomeEstacao) JOIN Viagem USING(idRota)
    ) GROUP BY(nomeEstacao) ORDER BY visits DESC LIMIT 3;
