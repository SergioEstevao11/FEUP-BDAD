.mode columns
.headers	on
.nullvalue	NULL

SELECT nomeEstacao, COUNT(idBilhete) AS visits
FROM(
    SELECT *
    FROM Estacao JOIN Informacao USING(nomeEstacao) JOIN Viagem USING(idRota) JOIN Bilhete USING(idViagem) 
    WHERE strftime('%Y-%m', dataDePartida) = '2021-05' OR strftime('%Y-%m', dataDeChegada) = '2021-05'
    ) GROUP BY(nomeEstacao)
ORDER BY visits DESC LIMIT 5;
 