.mode columns
.headers	on
.nullvalue	NULL

SELECT nome, max(chegada - partida) as duracaoMaxima
FROM Cliente JOIN(
    SELECT nifCliente, tempoDeChegada as chegada
    FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING (idRota)
    WHERE nomeEstacaoChegada = nomeEstacao
) USING (nifCliente)
JOIN (
    SELECT nifCliente, tempoDeChegada as partida
    FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Viagem USING(idViagem) JOIN Rota USING(idRota) JOIN Informacao USING (idRota)
    WHERE nomeEstacaoPartida = nomeEstacao
) USING (nifCliente) GROUP BY nifCliente;