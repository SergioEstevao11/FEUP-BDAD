.mode columns
.headers	on
.nullvalue	NULL

SELECT nome, max(chegada - partida) as duracaoMaxima
FROM (
    SELECT nome,nifCliente, tempoDeChegada as chegada
    FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING (idRota)
    WHERE nomeEstacaoChegada = nomeEstacao
)
JOIN (
    SELECT nome,nifCliente, tempoDeChegada as partida
    FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING (idRota)
    WHERE nomeEstacaoPartida = nomeEstacao
) USING (nifCliente, nome) GROUP BY nifCliente
ORDER BY duracaoMaxima DESC;