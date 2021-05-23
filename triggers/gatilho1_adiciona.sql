.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

CREATE TRIGGER IF NOT EXISTS verificaPassageiros

AFTER INSERT
ON Bilhete FOR EACH ROW
WHEN (
    SELECT nomeServico
    FROM Viagem JOIN Rota USING(idRota)
    WHERE idViagem = new.idViagem
) = 'Cargas'
BEGIN 
    SELECT RAISE(ROLLBACK, 'Bilhete ilegal: As viagem não é de passageiros');
END;

CREATE TRIGGER IF NOT EXISTS verificaPassageirosUpdate

BEFORE UPDATE 
ON Bilhete FOR EACH ROW
WHEN (
    SELECT nomeServico
    FROM Viagem JOIN Rota USING(idRota)
    WHERE idViagem = new.idViagem
) = 'Cargas'
BEGIN 
    SELECT RAISE(ROLLBACK, 'Bilhete ilegal: As viagem não é de passageiros');
END;

CREATE TRIGGER IF NOT EXISTS verificaEstacoes

AFTER INSERT 
ON Bilhete FOR EACH ROW
WHEN new.nomeEstacaoChegada NOT IN(
    SELECT nomeEstacao
    FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    WHERE idViagem = new.idViagem
) OR new.nomeEstacaoPartida NOT IN(
    SELECT nomeEstacao
    FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    WHERE idViagem = new.idViagem
) OR (
    (SELECT tempoDeChegada
    FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    WHERE idViagem = new.idViagem AND nomeEstacao = new.nomeEstacaoPartida) >= (
        SELECT tempoDeChegada
        FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
        WHERE idViagem = new.idViagem AND nomeEstacao = new.nomeEstacaoChegada)
)
BEGIN 
    SELECT RAISE(ROLLBACK, 'Bilhete ilegal: As estacoes de partida e/ou chegada sao invalidas');
END;

CREATE TRIGGER IF NOT EXISTS verificaEstacoesUpdate

BEFORE UPDATE
ON Bilhete FOR EACH ROW
WHEN new.nomeEstacaoChegada NOT IN(
    SELECT nomeEstacao
    FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    WHERE idViagem = new.idViagem
) OR new.nomeEstacaoPartida NOT IN(
    SELECT nomeEstacao
    FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    WHERE idViagem = new.idViagem
) OR (
    (SELECT tempoDeChegada
    FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
    WHERE idViagem = new.idViagem AND nomeEstacao = new.nomeEstacaoPartida) >= (
        SELECT tempoDeChegada
        FROM Viagem JOIN Rota USING(idRota) JOIN Informacao USING(idRota)
        WHERE idViagem = new.idViagem AND nomeEstacao = new.nomeEstacaoChegada)
)
BEGIN 
    SELECT RAISE(ROLLBACK, 'Bilhete ilegal: As estacoes de partida e/ou chegada sao invalidas');
END;

CREATE TRIGGER IF NOT EXISTS verificaLugares

AFTER INSERT 
ON Bilhete FOR EACH ROW
WHEN (
    (SELECT count(idBilhete)
    FROM Bilhete
    WHERE idViagem = new.idViagem) > (
        SELECT lugares
        FROM Comboio NATURAL JOIN ComboioCaracteristicas JOIN Viagem USING (idComboio)
        WHERE idViagem = new.idViagem)
) 
BEGIN 
    SELECT RAISE(ROLLBACK, 'Bilhete ilegal: Não existem lugares disponíveis nesse comboio');
END;

CREATE TRIGGER IF NOT EXISTS verificaLugaresUpdate

BEFORE UPDATE 
ON Bilhete FOR EACH ROW
WHEN (
    (SELECT count(idBilhete)
    FROM Bilhete
    WHERE idViagem = new.idViagem) > (
        SELECT lugares
        FROM Comboio NATURAL JOIN ComboioCaracteristicas JOIN Viagem USING (idComboio)
        WHERE idViagem = new.idViagem)
) 
BEGIN 
    SELECT RAISE(ROLLBACK, 'Bilhete ilegal: Não existem lugares disponíveis nesse comboio');
END;