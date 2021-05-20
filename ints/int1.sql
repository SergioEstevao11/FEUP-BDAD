.mode columns
.headers	on
.nullvalue	NULL

--COMPLETO

SELECT idViagem, dataDePartida, dataDeChegada
FROM(
    SELECT idRota, tempoDeChegada AS TPorto
       FROM Rota JOIN Informacao USING(idRota) JOIN Estacao USING(nomeEstacao)
       WHERE localidade='Porto'
       ) JOIN (
           SELECT idRota, tempoDeChegada AS TLisboa
           FROM Rota JOIN Informacao USING(idRota) JOIN Estacao USING(nomeEstacao)
           WHERE localidade='Lisboa'
       ) USING(idRota) JOIN Viagem USING (idRota)
    WHERE TPorto < TLisboa AND strftime('%m-%d', dataDePartida) = '05-11' AND strftime('%m-%d', dataDeChegada) = '05-11';
