.mode columns
.headers	on
.nullvalue	NULL

--COMPLETA

SELECT nomeEstacao, COUNT(idBilhete) AS visits
FROM(
    SELECT *
    FROM Estacao JOIN Informacao USING(nomeEstacao) JOIN Viagem USING(idRota) JOIN Bilhete USING(idViagem) 
    WHERE strftime('%Y-%m-%d', dataDePartida) = '2021-05-10' OR strftime('%Y-%m-%d', dataDeChegada) = '2021-05-10'
    ) GROUP BY(nomeEstacao)
ORDER BY visits DESC LIMIT 5;
 