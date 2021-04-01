PRAGMA foreign_keys = on;

.mode columns
.headers on

DROP TABLE IF EXISTS Assinatura;
DROP TABLE IF EXISTS Bilhete;
DROP TABLE IF EXISTS BilhetePreco;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Informacao;
DROP TABLE IF EXISTS RevisorViagem;
DROP TABLE IF EXISTS Viagem;
DROP TABLE IF EXISTS Rota;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Estacao;
DROP TABLE IF EXISTS Maquinista;
DROP TABLE IF EXISTS Revisor;
DROP TABLE IF EXISTS Bilheteiro;
DROP TABLE IF EXISTS Trabalhador;
DROP TABLE IF EXISTS ComboioCarga;
DROP TABLE IF EXISTS ComboioPassageiros;
DROP TABLE IF EXISTS Comboio;
DROP TABLE IF EXISTS ComboioVel;

CREATE TABLE Cliente(
    nif  TEXT   PRIMARY KEY    
                CONSTRAINT ck_cliente_nif CHECK(LENGTH(nif) == 9 AND nif NOT GLOB '*[^0-9]*')
                CONSTRAINT nn_cliente_nif NOT NULL,
    nome TEXT
);

CREATE TABLE Servico(
    nome TEXT   PRIMARY KEY   
                CONSTRAINT ck_servico_nome CHECK(( nome == "Alfa-Pendular" OR
                                                   nome == "Intercidades"  OR
                                                   nome == "Regional"      OR
                                                   nome == "Urbano"        ))
                CONSTRAINT nn_servico_nome NOT NULL
);

CREATE TABLE Assinatura(
    nif         TEXT    CONSTRAINT fk_assinatura_cliente REFERENCES Cliente ON DELETE CASCADE 
                                                                            ON UPDATE CASCADE
                        CONSTRAINT nn_assinatura_nif NOT NULL,
    nomeServico TEXT    CONSTRAINT fk_assinatura_servico REFERENCES Servico ON DELETE CASCADE 
                                                                            ON UPDATE CASCADE
                        CONSTRAINT nn_assinatura_nomeServico NOT NULL,
    IDPasse     INTEGER CONSTRAINT ck_assinatura_idPasse CHECK(IDPasse > 0)
                        CONSTRAINT nn_assinatura_idPasse NOT NULL,
    PRIMARY KEY(nif, nomeServico),
    CONSTRAINT uq_servico_idPasse_nomeServico UNIQUE(nomeServico, IDPasse)
);

CREATE TABLE Estacao(
    nome         TEXT PRIMARY KEY
                      CONSTRAINT nn_estacao_nome NOT NULL,
    morada       TEXT CONSTRAINT nn_estacao_morada NOT NULL,
    codigoPostal TEXT CONSTRAINT ck_estacao_codigoPostal CHECK(codigoPostal LIKE('____-___') AND codigoPostal NOT GLOB '*[^0-9-]*')
                      CONSTRAINT nn_estacao_codigoPostal NOT NULL,
    localidade   TEXT CONSTRAINT nn_estacao_localidade NOT NULL,
    CONSTRAINT uq_estacao_morada_codigoPostal UNIQUE(morada, codigoPostal)
);

CREATE TABLE Rota(
    id          INTEGER PRIMARY KEY AUTOINCREMENT
                        CONSTRAINT nn_rota_id NOT NULL,
    titulo      TEXT,
    nomeServico TEXT    CONSTRAINT fk_rota_servico REFERENCES Servico ON DELETE CASCADE
                                                                      ON UPDATE CASCADE
                        CONSTRAINT nn_rota_nomeServico NOT NULL
);

CREATE TABLE Informacao(
    nomeEstacao    TEXT    CONSTRAINT fk_informacao_estacao REFERENCES Estacao ON DELETE CASCADE 
                                                                               ON UPDATE CASCADE
                           CONSTRAINT nn_informacao_nomeEstacao NOT NULL,
    idRota         INTEGER CONSTRAINT fk_informacao_rota REFERENCES Rota ON DELETE CASCADE 
                                                                         ON UPDATE CASCADE
                           CONSTRAINT nn_informacao_idRota NOT NULL,
    tempoDeChegada INTEGER CONSTRAINT ck_informacao_tempoDeChegada CHECK(tempoDeChegada >= 0)
                           CONSTRAINT nn_informacao_tempoDeChegada NOT NULL,
    PRIMARY KEY(nomeEstacao, idRota)
);

CREATE TABLE Trabalhador(
    nif         TEXT    PRIMARY KEY 
                        CONSTRAINT ck_trabalhador_nif CHECK(LENGTH(nif) == 9 AND nif NOT GLOB '*[^0-9]*')
                        CONSTRAINT nn_trabalhador_nif NOT NULL,
    nome        TEXT,
    idade       INTEGER CONSTRAINT ck_trabalhador_idade CHECK(idade >= 18)
                        CONSTRAINT nn_trabalhador_idade NOT NULL,
    numTelefone TEXT    CONSTRAINT ck_trabalhador_numTelefone CHECK(LENGTH(numTelefone) == 9 AND nif NOT GLOB '*[^0-9]*')
);

CREATE TABLE Maquinista(
    nifMaquinista TEXT PRIMARY KEY
                       CONSTRAINT fk_maquinista_trabalhador REFERENCES Trabalhador(nif) ON DELETE CASCADE 
                                                                                        ON UPDATE CASCADE
                       CONSTRAINT nn_maquinista_nifMaquinista NOT NULL,
    numLicensa    TEXT CONSTRAINT ck_maquinista_numLicensa CHECK(LENGTH(numLicensa) == 12 AND numLicensa NOT GLOB '*[^0-9]*')
                       CONSTRAINT nn_maquinista_numLicensa NOT NULL
);

CREATE TABLE Bilheteiro(
    nifBilheteiro TEXT PRIMARY KEY
                       CONSTRAINT fk_bilheteiro_trabalhador REFERENCES Trabalhador(nif) ON DELETE CASCADE 
                                                                                        ON UPDATE CASCADE
                       CONSTRAINT nn_bilheteiro_nifBilheteiro NOT NULL,
    nomeEstacao TEXT   CONSTRAINT fk_bilheteiro_estacao REFERENCES Estacao ON DELETE CASCADE 
                                                                           ON UPDATE CASCADE
                       CONSTRAINT nn_bilheteiro_nomeEstacao NOT NULL
);

CREATE TABLE Revisor(
    nifRevisor    TEXT PRIMARY KEY
                       CONSTRAINT fk_revisor_trabalhador REFERENCES Trabalhador(nif) ON DELETE CASCADE 
                                                                                     ON UPDATE CASCADE
                       CONSTRAINT nn_revisor_nifRevisor NOT NULL,                                                                 
    identificacao TEXT CONSTRAINT ck_revisor_identificacao  CHECK(LENGTH(identificacao) == 9 AND identificacao NOT GLOB '*[^0-9]*')
                       CONSTRAINT nn_revisor_identificacao NOT NULL
);

CREATE TABLE Comboio(
    id     INTEGER PRIMARY KEY AUTOINCREMENT,
    marca  TEXT    CONSTRAINT nn_comboio_marca NOT NULL,
    modelo TEXT    CONSTRAINT nn_comboio_modelo NOT NULL
);

CREATE TABLE ComboioVel(
    marca     TEXT    CONSTRAINT nn_comboio_marca NOT NULL,
    modelo    TEXT    CONSTRAINT nn_comboio_modelo NOT NULL,
    velMaxima INTEGER CONSTRAINT ck_comboio_velMaxima CHECK (velMaxima > 0)
                      CONSTRAINT nn_comboio_velMaxima NOT NULL, 
    PRIMARY KEY(marca,modelo)
);

CREATE TABLE ComboioCarga(
    id       INTEGER PRIMARY KEY 
                     CONSTRAINT fk_comboioCarga_comboio REFERENCES Comboio(id) ON DELETE CASCADE 
                                                                               ON UPDATE CASCADE   
                     CONSTRAINT nn_comboioCarga_id NOT NULL,                                                                    
    maxCarga FLOAT   CONSTRAINT ck_comboioCarga_maxCarga CHECK (maxCarga > 0 AND maxCarga < 5)
                     CONSTRAINT nn_comboioCarga_maxCarga NOT NULL
);

CREATE TABLE ComboioPassageiros(
    id      INTEGER PRIMARY KEY 
                    CONSTRAINT fk_comboioPassageiros_comboio REFERENCES Comboio(id) ON DELETE CASCADE 
                                                                                     ON UPDATE CASCADE   
                    CONSTRAINT nn_comboioPassageiros_id NOT NULL,
    lugares INTEGER CONSTRAINT ck_comboioPassageiros_lugares CHECK (lugares > 0)
                    CONSTRAINT nn_comboioPassageiros_lugares NOT NULL
);


CREATE TABLE Viagem(
    id            INTEGER PRIMARY KEY AUTOINCREMENT
                          CONSTRAINT nn_viagem_id NOT NULL,
    dataDePartida DATE    CONSTRAINT nn_viagem_id NOT NULL,
    dataDeChegada DATE    CONSTRAINT nn_viagem_id NOT NULL,
    idComboio     INTEGER CONSTRAINT fk_viagem_comboio REFERENCES Comboio ON DELETE CASCADE 
                                                                          ON UPDATE CASCADE
                          CONSTRAINT nn_viagem_idComboio NOT NULL,
    idRota        INTEGER CONSTRAINT fk_viagem_rota REFERENCES Rota ON DELETE CASCADE 
                                                                    ON UPDATE CASCADE
                          CONSTRAINT nn_viagem_idRota NOT NULL,
    nifMaquinista TEXT    REFERENCES Maquinista ON DELETE CASCADE 
                                                ON UPDATE CASCADE
                          CONSTRAINT nn_viagem_id NOT NULL,     
    CONSTRAINT uq_viagem_dataDePartida_idRota UNIQUE(dataDePartida,idRota)
);

CREATE TABLE RevisorViagem(
    nifRevisor TEXT    CONSTRAINT fk_revisorViagem_revisor REFERENCES Revisor ON DELETE CASCADE 
                                                                              ON UPDATE CASCADE
                       CONSTRAINT nn_revisorViagem_nifRevisor NOT NULL,
    idViagem   INTEGER CONSTRAINT fk_revisorViagem_Viagem REFERENCES Viagem ON DELETE CASCADE 
                                                                            ON UPDATE CASCADE
                       CONSTRAINT nn_revisorViagem_idViagem NOT NULL,
    PRIMARY KEY(nifRevisor, idViagem)
);

CREATE TABLE Bilhete(
    id                 INTEGER PRIMARY KEY AUTOINCREMENT
                               CONSTRAINT nn_bilhete_id NOT NULL,
    lugarDestinado     TEXT,
    nifCliente         TEXT    CONSTRAINT fk_bilhete_cliente REFERENCES Cliente ON DELETE CASCADE 
                                                                                ON UPDATE CASCADE
                               CONSTRAINT nn_bilhete_nifCliente NOT NULL,
    nomeEstacaoPartida TEXT    CONSTRAINT fk_bilhete_estacao REFERENCES Estacao ON DELETE CASCADE 
                                                                                ON UPDATE CASCADE
                               CONSTRAINT nn_bilhete_nomeEstacaoPartida NOT NULL,
    nomeEstacaoChegada TEXT    CONSTRAINT fk_bilhete_estacao REFERENCES Estacao ON DELETE CASCADE 
                                                                                ON UPDATE CASCADE
                               CONSTRAINT nn_bilhete_nomeEstacaoChegada NOT NULL,
    idViagem           INTEGER CONSTRAINT fk_bilhete_viagem REFERENCES Viagem  ON DELETE CASCADE 
                                                                               ON UPDATE CASCADE
                               CONSTRAINT nn_bilhete_idViagem NOT NULL,
    nifBilheteiro      INTEGER CONSTRAINT fk_bilhete_bilheteiro REFERENCES Bilheteiro ON DELETE CASCADE 
                                                                                      ON UPDATE CASCADE,
    CONSTRAINT ck_bilhete_nomeEstacaoPartida_nomeEstacaoChegada CHECK(nomeEstacaoChegada != nomeEstacaoPartida)
);


CREATE TABLE BilhetePreco(
    nomeEstacaoPartida TEXT    CONSTRAINT fk_bilhetePreco_estacao REFERENCES Estacao ON DELETE CASCADE 
                                                                                ON UPDATE CASCADE
                               CONSTRAINT nn_bilhetePreco_nomeEstacaoPartida NOT NULL,
    nomeEstacaoChegada TEXT    CONSTRAINT fk_bilhetePreco_estacao REFERENCES Estacao ON DELETE CASCADE 
                                                                                ON UPDATE CASCADE
                               CONSTRAINT nn_bilhetePreco_nomeEstacaoChegada NOT NULL,
    idViagem           INTEGER CONSTRAINT fk_bilhetePreco_viagem REFERENCES Viagem  ON DELETE CASCADE 
                                                                               ON UPDATE CASCADE
                               CONSTRAINT nn_bilhetePreco_idViagem NOT NULL,
    preco              FLOAT   CONSTRAINT fk_bilhetePreco_preco CHECK(preco > 0),
    PRIMARY KEY(nomeEstacaoPartida, nomeEstacaoChegada,idViagem)
);
