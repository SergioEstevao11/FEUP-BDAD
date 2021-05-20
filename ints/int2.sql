.mode columns
.headers	on
.nullvalue	NULL

--COMPLETA

SELECT nome, max(chegada - partida) AS duracaoMaxima
FROM (
    SELECT nome,nifCliente, tempoDeChegada AS chegada
    FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING (idRota)
    WHERE nomeEstacaoChegada = nomeEstacao
)
JOIN (
    SELECT nome,nifCliente, tempoDeChegada AS partida
    FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING (idRota)
    WHERE nomeEstacaoPartida = nomeEstacao
) USING (nifCliente, nome) GROUP BY nifCliente
HAVING duracaoMaxima > 60
ORDER BY duracaoMaxima DESC;

