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
                    300,
                    '2021-08-02 09:30',
                    2,
                    1,
                    '052416241'        
                );



select dataDeChegada
from Viagem
where idViagem = 300;