.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

.print ''
.print 'Adicionada uma nova Viagem com idViagem = 301, idComboio = 2 (Comboio de carga) e idRota = 1 (Passageiros)'
.print ''

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

.print ''
.print 'Comboio associado à viagem com idViagem = 301'
.print ''

select idComboio
FROM Viagem
WHERE idViagem = 301;

.print ''
.print 'Adicionada uma nova Viagem com idViagem = 302, idComboio = 2 (Comboio de carga) e idRota = 7 (Cargas)'
.print ''

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

.print ''
.print 'Comboio associado à viagem com idViagem = 302'
.print ''

select idComboio
FROM Viagem
WHERE idViagem = 302;

.print ''
.print 'Adicionada uma nova Viagem com idViagem = 303, idComboio = 10 (Comboio de passageiros) e idRota = 1 (Passageiros)'
.print ''

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

.print ''
.print 'Comboio associado à viagem com idViagem = 303'
.print ''

select idComboio
FROM Viagem
WHERE idViagem = 303;

.print ''
.print 'Adicionada uma nova Viagem com idViagem = 304, idComboio = 10 (Comboio de passageiros) e idRota = 7 (Cargas)'
.print ''

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

.print ''
.print 'Comboio associado à viagem com idViagem = 304'
.print ''

select idComboio
FROM Viagem
WHERE idViagem = 304;


.print ''
.print 'Updated Viagem com id = 303 para ter idComboio igual a um comboio de carga ( idComboio = 2 ) '
.print ''

UPDATE Viagem
SET idComboio = 2
WHERE idViagem  = 303;


.print ''
.print 'Comboio associado à viagem com idViagem = 303'
.print ''

select idComboio
FROM Viagem
WHERE idViagem = 303;