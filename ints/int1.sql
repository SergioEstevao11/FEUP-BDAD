.mode columns
.headers	on
.nullvalue	NULL


-- SELECT idRota
-- FROM Rota
-- WHERE idRota IN (
--     SELECT idRota
--     FROM Rota JOIN Informacao USING(idRota) JOIN Estacao USING(nomeEstacao)
--     WHERE localidade = 'Porto'
-- ) AND idRota IN (
--     SELECT idRota
--     FROM Rota JOIN Informacao USING(idRota) JOIN Estacao USING(nomeEstacao)
--     WHERE localidade = 'Lisboa'
-- );

SELECT * FROM Viagem JOIN Rota USING(idRota) 
WHERE titulo = 'Porto/Lisboa';
