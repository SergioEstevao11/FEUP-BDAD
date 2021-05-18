.mode columns
.headers	on
.nullvalue	NULL

SELECT DISTINCT idComboio
FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota) JOIN (
    SELECT idComboio
    FROM ComboioCaracteristicas NATURAL JOIN Comboio
    WHERE  marca = 'Stadler' AND lugares > 115
    ) USING (idComboio)
    WHERE nomeEstacao = 'Coimbra-B';