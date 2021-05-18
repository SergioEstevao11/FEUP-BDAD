.mode columns
.headers	on
.nullvalue	NULL

--taxa de ocupação média de cada serviço
--                 de cada viagem

--SELECT idViagem, lugares, idRota FROM Viagem JOIN Comboio USING(idComboio) JOIN ComboioCaracteristicas Using(marca, modelo) WHERE lugares NOT NULL


--select idViagem, idBilhete from Viagem left join Bilhete using(idViagem);

SELECT idViagem, coalesce(ROUND(COUNT(idBilhete) *100.0/lugares, 2), 0) AS 'ocupacao(%)', idRota 
FROM (
    SELECT idViagem, lugares, idRota FROM Viagem JOIN Comboio USING(idComboio) JOIN ComboioCaracteristicas Using(marca, modelo) WHERE lugares NOT NULL
    ) LEFT JOIN Bilhete USING(idViagem) GROUP BY idViagem;

