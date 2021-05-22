.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Adicionada uma nova Viagem, sem dataDeChegada pois ainda não foi calculada'
.print ''

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


.print ''
.print 'Data de chegada devidamente calculada:'
.print ''

select dataDeChegada
from Viagem
where idViagem = 300;