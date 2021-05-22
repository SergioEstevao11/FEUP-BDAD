.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

CREATE TRIGGER IF NOT EXISTS atribuirComboiodePassageiros
AFTER INSERT ON Viagem
FOR EACH ROW
WHEN (
    (SELECT nomeServico
    FROM Servico JOIN Rota USING (nomeServico)
    WHERE idRota = new.idRota) != 'Cargas' AND (
        SELECT lugares
        FROM Comboio NATURAL JOIN ComboioCaracteristicas
        WHERE idComboio = new.idComboio) IS NULL
) 
BEGIN 
    UPDATE Viagem
    SET idComboio = (SELECT idComboio FROM Comboio NATURAL JOIN ComboioCaracteristicas WHERE lugares = (SELECT min(lugares) FROM ComboioCaracteristicas))
    WHERE idViagem = new.idViagem;
END;


CREATE TRIGGER IF NOT EXISTS atribuirComboiodeCarga
AFTER INSERT ON Viagem
FOR EACH ROW
WHEN (
    (SELECT nomeServico
    FROM Servico JOIN Rota USING (nomeServico)
    WHERE idRota = new.idRota) = 'Cargas' AND (
        SELECT maxCarga
        FROM Comboio NATURAL JOIN ComboioCaracteristicas
        WHERE idComboio = new.idComboio) IS NULL
) 
BEGIN 
    UPDATE Viagem
    SET idComboio = (SELECT idComboio FROM Comboio NATURAL JOIN ComboioCaracteristicas WHERE maxCarga = (SELECT min(maxCarga) FROM ComboioCaracteristicas))
    WHERE idViagem = new.idViagem;
END;