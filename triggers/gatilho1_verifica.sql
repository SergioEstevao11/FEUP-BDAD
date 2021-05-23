.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;


.print ''
.print 'Inserido comboio com um lugar disponível de marca e modelo Dummy'
.print ''

INSERT INTO ComboioCaracteristicas(   
                        marca,
                        modelo,
                        velMaxima,
                        maxCarga,
                        lugares
                    )
                    VALUES(
                        'Dummy',
                        'Dummy',
                        103,
                        NULL,
                        1
                    );

.print ''
.print 'Inserido comboio com id = 300 de marca e modelo Dummy'
.print ''

INSERT INTO Comboio (   
                        idComboio,
                        marca,
                        modelo
                    )
                    VALUES(
                        300,
                        'Dummy',
                        'Dummy'
                    );

.print ''
.print 'Inserida viagem com id = 200 e associada ao comboio de id = 300 na rota de id = 1 (Passageiros)'
.print ''

INSERT INTO Viagem(   
                    idViagem,
                    dataDePartida,
                    idComboio,
                    idRota,
                    nifMaquinista
                )
                VALUES(
                    200,
                    '2021-09-10 09:30',
                    300,
                    1,
                    '119608152'   
                );


.print ''
.print 'Inserido bilhete com um idViagem ( = 13 ) correspondente a uma viagem de Carga'
.print ''

INSERT INTO Bilhete(
                    idBilhete,  
                    lugarDestinado,
                    nifCliente,
                    nomeEstacaoPartida,
                    nomeEstacaoChegada,
                    idViagem
                )
                VALUES(
                    300,
                    '08C',
                    '131199282',
                    'Campanha',
                    'Santa Apolonia',
                    13
                );


.print ''
.print 'Inserido bilhete cuja estação Coimbra-A não está presente na rota de id = 1'
.print ''


INSERT INTO Bilhete(
                    idBilhete,  
                    lugarDestinado,
                    nifCliente,
                    nomeEstacaoPartida,
                    nomeEstacaoChegada,
                    idViagem
                )
                VALUES(
                    300,
                    '08C',
                    '131199282',
                    'Coimbra-A',
                    'Oriente',
                    200
                );

.print ''
.print 'Inserido bilhete cujas estações de partida e chegada não estão pela ordem correta'
.print ''

INSERT INTO Bilhete(
                    idBilhete,  
                    lugarDestinado,
                    nifCliente,
                    nomeEstacaoPartida,
                    nomeEstacaoChegada,
                    idViagem
                )
                VALUES(
                    300,
                    '08C',
                    '131199282',
                    'Oriente',
                    'Campanha',
                    200
                );

.print ''
.print 'Inserido bilhete que respeita todos os triggers com idBilhete = 300 e idViagem = 200'
.print ''

INSERT INTO Bilhete(
                    idBilhete,  
                    lugarDestinado,
                    nifCliente,
                    nomeEstacaoPartida,
                    nomeEstacaoChegada,
                    idViagem
                )
                VALUES(
                    300,
                    '08C',
                    '131199282',
                    'Campanha',
                    'Oriente',
                    200
                );

.print ''
.print 'Bilhetes devidamente atualizados:'
.print ''

SELECT * 
FROM Bilhete 
WHERE idBilhete = 300;

.print ''
.print 'Updated bilhete com id = 300 para uma viagem de carga com id = 13'
.print ''

UPDATE Bilhete 
SET idViagem = 13
WHERE idBilhete  = 300;

.print ''
.print 'Bilhetes devidamente atualizados:'
.print ''

SELECT * 
FROM Bilhete 
WHERE idBilhete = 300;

.print ''
.print 'Segundo bilhete inserido na viagem de id = 200 que está associada a um comboio com apenas 1 lugar'
.print ''

INSERT INTO Bilhete(
                    idBilhete,  
                    lugarDestinado,
                    nifCliente,
                    nomeEstacaoPartida,
                    nomeEstacaoChegada,
                    idViagem
                )
                VALUES(
                    301,
                    '08D',
                    '131199282',
                    'Campanha',
                    'Oriente',
                    200
                );


