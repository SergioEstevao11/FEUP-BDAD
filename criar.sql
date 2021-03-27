PRAGMA foreign_keys = on;

.mode columns
.headers on

DROP TABLE IF EXISTS Assinatura;
DROP TABLE IF EXISTS Bilhete1;
DROP TABLE IF EXISTS Bilhete2;
DROP TABLE IF EXISTS Cliente;
DROP TABLE IF EXISTS Informacao;
DROP TABLE IF EXISTS RevisorViagem;
DROP TABLE IF EXISTS Viagem1;
DROP TABLE IF EXISTS Viagem2;
DROP TABLE IF EXISTS Rota;
DROP TABLE IF EXISTS Servico;
DROP TABLE IF EXISTS Estacao;
DROP TABLE IF EXISTS Maquinista;
DROP TABLE IF EXISTS Revisor;
DROP TABLE IF EXISTS Bilheteiro;
DROP TABLE IF EXISTS Trabalhador;
DROP TABLE IF EXISTS ComboioCarga;
DROP TABLE IF EXISTS ComboioPassageiros;
DROP TABLE IF EXISTS Comboio1;
DROP TABLE IF EXISTS Comboio2;

CREATE TABLE Cliente(
    nif TEXT PRIMARY KEY,
    nome TEXT,
    CHECK(LENGTH(nif) == 9),
    CHECK(nif NOT GLOB '*[^0-9]*'),
    CHECK(nome NOT GLOB '*[^a-zA-Z ]*')
);

CREATE TABLE Servico(
    nome TEXT PRIMARY KEY
);

CREATE TABLE Assinatura(
    nif TEXT REFERENCES Cliente,
    nomeServico TEXT REFERENCES Servico,
    IDPasse INTEGER CHECK(IDPasse > 0),
    PRIMARY KEY(nif, nomeServico),
    UNIQUE(nomeServico, IDPasse)
);

CREATE TABLE Estacao(
    morada TEXT PRIMARY KEY,
    codigoPostal TEXT,
    localidade TEXT,
    CHECK(localidade NOT GLOB '*[^a-zA-Z ]*')
);

CREATE TABLE Rota(
    id INTEGER PRIMARY KEY,
    titulo TEXT,
    nomeServico TEXT REFERENCES Servico,
    CHECK(titulo NOT GLOB '*[^a-zA-Z ]*')
);

CREATE TABLE Informacao(
    morada TEXT REFERENCES Estacao,
    idRota INTEGER REFERENCES Rota,
    tempoDeChegada INTEGER CHECK(tempoDeChegada >= 0)
);

CREATE TABLE Trabalhador(
    nif TEXT PRIMARY KEY,
    nome TEXT,
    idade INTEGER CHECK(idade >= 18),
    numTelefone TEXT,
    CHECK(LENGTH(nif) == 9),
    CHECK(nif NOT GLOB '*[^0-9]*'),
    CHECK(nome NOT GLOB '*[^a-zA-Z ]*'),
    CHECK(LENGTH(numTelefone) == 9),
    CHECK(numTelefone NOT GLOB '*[^0-9]*')
);

CREATE TABLE Maquinista(
    nifMaquinista TEXT REFERENCES Trabalhador(nif),
    numLicensa TEXT,
    PRIMARY KEY(nifMaquinista),
    CHECK(LENGTH(numLicensa) == 12),
    CHECK(numLicensa NOT GLOB '*[^0-9]*')
);

CREATE TABLE Revisor(
    nifRevisor TEXT REFERENCES Trabalhador(nif),
    identificacao TEXT,
    PRIMARY KEY(nifRevisor),
    CHECK(LENGTH(identificacao) == 9),
    CHECK(identificacao NOT GLOB '*[^0-9]*')
);

CREATE TABLE Bilheteiro(
    nifBilheteiro TEXT REFERENCES Trabalhador(nif),
    morada TEXT REFERENCES Estacao,
    PRIMARY KEY(nifBilheteiro)
);

CREATE TABLE Comboio1(
    id INTEGER PRIMARY KEY,
    marca TEXT,
    modelo TEXT,
    CHECK(marca NOT GLOB '*[^a-zA-Z ]*')
);

CREATE TABLE Comboio2(
    marca TEXT,
    modelo TEXT,
    velMaxima INTEGER CHECK (velMaxima > 0),
    CHECK(marca NOT GLOB '*[^a-zA-Z ]*'),
    PRIMARY KEY(marca,modelo)
);

CREATE TABLE ComboioCarga(
    id INTEGER REFERENCES Comboio1(id),
    maxCarga INTEGER CHECK (maxCarga > 0)
);

CREATE TABLE ComboioPassageiros(
    id INTEGER REFERENCES Comboio1(id),
    maxCarga INTEGER CHECK (maxCarga > 0)
);


CREATE TABLE Viagem1(
    id INTEGER PRIMARY KEY,
    data INTEGER,
    horaDePartida INTEGER,
    idComboio INTEGER REFERENCES Comboio,
    idRota INTEGER REFERENCES Rota,
    nifMaquinista REFERENCES Maquinista
);

CREATE TABLE Viagem2(
    horaDePartida INTEGER,
    idRota INTEGER REFERENCES Rota,
    horaDeChegada INTEGER,
    CHECK(horaDeChegada > horaDePartida),
    PRIMARY KEY(horaDePartida, idRota)
);

CREATE TABLE RevisorViagem(
    nifRevisor TEXT REFERENCES Revisor,
    idViagem INTEGER REFERENCES Viagem,
    PRIMARY KEY(nifRevisor, idViagem)
);

CREATE TABLE Bilhete1(
    id INTEGER PRIMARY KEY,
    lugarDestinado TEXT,
    nifCliente REFERENCES Cliente,
    moradaEstacaoPartida REFERENCES Estacao,
    moradaEstacaoChegada REFERENCES Estacao,
    idViagem REFERENCES Viagem,
    nifBilheteiro REFERENCES Bilheteiro
);

CREATE TABLE Bilhete2(
    moradaEstacaoPartida REFERENCES Estacao,
    moradaEstacaoChegada REFERENCES Estacao,
    idViagem REFERENCES Viagem,
    preco FLOAT CHECK(preco > 0),
    PRIMARY KEY(moradaEstacaoPartida, moradaEstacaoChegada,idViagem)
);
