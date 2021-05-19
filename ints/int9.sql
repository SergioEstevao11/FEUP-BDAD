.mode columns
.headers	on
.nullvalue	NULL

--COMPLETA

SELECT DISTINCT idComboio, marca, modelo, lugares
FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota) JOIN (
    SELECT idComboio,marca, modelo, lugares
    FROM ComboioCaracteristicas JOIN Comboio USING(marca, modelo)
    WHERE  marca = 'Stadler' AND lugares > 100
    ) USING (idComboio)
WHERE nomeEstacao = 'Coimbra-B';
