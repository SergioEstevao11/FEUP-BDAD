.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

CREATE TRIGGER IF NOT EXISTS calcularDataDeChegada
AFTER INSERT ON Viagem
FOR EACH ROW
BEGIN 
    UPDATE Viagem
    SET dataDeChegada = datetime(strftime('%s',dataDePartida) + 60 * (SELECT max(tempoDeChegada) FROM Rota JOIN Informacao USING(idRota) WHERE idRota = new.idRota),'unixepoch')
    WHERE idViagem = new.idViagem;
END;