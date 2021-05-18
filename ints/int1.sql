.mode columns
.headers	on
.nullvalue	NULL

-- SELECT * FROM Estacao WHERE localidade='Lisboa';

-- SELECT * FROM Estacao WHERE localidade='Porto';

-- SELECT * FROM Rota WHERE EXISTS()

select * from (
        SELECT idRota 
        FROM Estacao 
        WHERE localidade='Lisboa') intersect (
            SELECT idRota
            FROM Estacao 
            WHERE localidade='Porto');

-- SELECT *
-- FROM Viagem WHERE Viagem.idRota IN(
--         SELECT idRota 
--         FROM Estacao 
--         WHERE localidade='Lisboa') AND Viagem.idRota IN (
--             SELECT idRota
--             FROM Estacao 
--             WHERE localidade='Porto');

-- SELECT *
-- FROM Viagem JOIN (
--     SELECT idRota, titulo 
--     FROM Rota 
--     WHERE titulo='Lisboa/Porto') USING(idRota);

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
