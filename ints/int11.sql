.mode columns
.headers	on
.nullvalue	NULL


-- SELECT distinct nome, idViagem, nomeEstacaoPartida as nomeEstacao, nomeEstacaoChegada
-- FROM Cliente JOIN Bilhete USING(nifCliente);

-- SELECT  nifCliente , nomeEstacaoPartida,  nomeEstacaoChegada, nomeEstacao, idViagem, tempoDeChegada  
-- FROM Bilhete JOIN INFORMACAO
-- WHERE nomeEstacao = nomeEstacaoPartida OR nomeEstacao = nomeEstacaoChegada;

SELECT nome, duracaoMaxima
FROM Cliente JOIN(
    SELECT nifCliente, max(tempoDeChegada) as duracaoMaxima
    FROM(
        SELECT  *
        FROM Bilhete JOIN Viagem USING(idViagem) JOIN Informacao USING(idRota)
        WHERE nomeEstacao = nomeEstacaoChegada
    )   GROUP BY nifCliente
) USING(nifCliente);