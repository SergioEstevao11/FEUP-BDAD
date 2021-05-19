.mode columns
.headers	on
.nullvalue	NULL


--  clientes que ja tenham passado em todas as estaçoes
--NOTA: não há clientes que tenham passado por todas as estações

SELECT * 
FROM(
    SELECT nifCliente, nome, COUNT(DISTINCT nomeEstacao) AS NumEstacao 
    FROM (Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    ) GROUP BY nifCliente
)
WHERE numEstacao > (SELECT COUNT(*) FROM Estacao);
