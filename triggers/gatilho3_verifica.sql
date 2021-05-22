.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

INSERT INTO Viagem(   
                    idViagem,
                    dataDePartida,
                    idComboio,
                    idRota,
                    nifMaquinista
                )
                VALUES(
                    301,
                    '2021-08-03 09:30',
                    2,
                    1,
                    '052416241'        
                );

select idComboio
FROM Viagem
WHERE idViagem = 301;


INSERT INTO Viagem(   
                    idViagem,
                    dataDePartida,
                    idComboio,
                    idRota,
                    nifMaquinista
                )
                VALUES(
                    302,
                    '2021-08-03 09:30',
                    2,
                    7,
                    '659387578'        
                );

select idComboio
FROM Viagem
WHERE idViagem = 302;

INSERT INTO Viagem(   
                    idViagem,
                    dataDePartida,
                    idComboio,
                    idRota,
                    nifMaquinista
                )
                VALUES(
                    303,
                    '2021-08-09 09:30',
                    10,
                    1,
                    '052416241'        
                );

select idComboio
FROM Viagem
WHERE idViagem = 303;

INSERT INTO Viagem(   
                    idViagem,
                    dataDePartida,
                    idComboio,
                    idRota,
                    nifMaquinista
                )
                VALUES(
                    304,
                    '2021-08-09 09:30',
                    10,
                    7,
                    '659387578'        
                );

select idComboio
FROM Viagem
WHERE idViagem = 304;