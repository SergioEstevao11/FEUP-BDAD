.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

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

SELECT * 
FROM Bilhete 
WHERE idBilhete = 300;

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


