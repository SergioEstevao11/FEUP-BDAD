.mode columns
.headers	on
.nullvalue	NULL

--COMPLETO

SELECT idRota, titulo, ROUND(avg(ocupacaoViagem), 3) AS 'OcupacaoMediaRota(%)'
FROM Rota NATURAL JOIN (
    SELECT idViagem, COUNT(idBilhete) *100.0/lugares AS 'ocupacaoViagem', idRota 
    FROM (
        SELECT idViagem, lugares, idRota 
        FROM Viagem JOIN Comboio USING(idComboio) JOIN ComboioCaracteristicas USING(marca, modelo) 
        WHERE lugares NOT NULL
        ) LEFT JOIN Bilhete USING(idViagem) 
        GROUP BY idViagem
    ) 
    GROUP BY idRota;

