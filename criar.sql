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
    nome TEXT NOT NULL,
    CHECK(LENGTH(nif) == 9),
    CHECK(nif NOT GLOB '*[^0-9]*')
);

CREATE TABLE Servico(
    nome TEXT PRIMARY KEY,
    CHECK ((nome == "Alfa-Pendular" OR
            nome == "Intercidades"  OR
            nome == "Regional"      OR
            nome == "Urbano"        ))
);

CREATE TABLE Assinatura(
    nif TEXT REFERENCES Cliente ON DELETE CASCADE ON UPDATE CASCADE,
    nomeServico TEXT REFERENCES Servico ON DELETE CASCADE ON UPDATE CASCADE,
    IDPasse INTEGER CHECK(IDPasse > 0),
    PRIMARY KEY(nif, nomeServico),
    UNIQUE(nomeServico, IDPasse)
);

CREATE TABLE Estacao(
    nome TEXT PRIMARY KEY,
    morada TEXT NOT NULL,
    codigoPostal TEXT NOT NULL,
    localidade TEXT NOT NULL
);

CREATE TABLE Rota(
    id INTEGER PRIMARY KEY,
    titulo TEXT,
    nomeServico TEXT REFERENCES Servico ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Informacao(
    nomeEstacao TEXT REFERENCES Estacao ON DELETE CASCADE ON UPDATE CASCADE,
    idRota INTEGER REFERENCES Rota ON DELETE CASCADE ON UPDATE CASCADE,
    tempoDeChegada INTEGER CHECK(tempoDeChegada >= 0)
);

CREATE TABLE Trabalhador(
    nif TEXT PRIMARY KEY,
    nome TEXT,
    idade INTEGER CHECK(idade >= 18),
    numTelefone TEXT,
    CHECK(LENGTH(nif) == 9),
    CHECK(nif NOT GLOB '*[^0-9]*'),
    CHECK(LENGTH(numTelefone) == 9),
    CHECK(numTelefone NOT GLOB '*[^0-9]*')
);

CREATE TABLE Maquinista(
    nifMaquinista TEXT REFERENCES Trabalhador(nif) ON DELETE CASCADE ON UPDATE CASCADE,
    numLicensa TEXT,
    PRIMARY KEY(nifMaquinista),
    CHECK(LENGTH(numLicensa) == 12),
    CHECK(numLicensa NOT GLOB '*[^0-9]*')
);

CREATE TABLE Revisor(
    nifRevisor TEXT REFERENCES Trabalhador(nif) ON DELETE CASCADE ON UPDATE CASCADE,
    identificacao TEXT,
    PRIMARY KEY(nifRevisor),
    CHECK(LENGTH(identificacao) == 9),
    CHECK(identificacao NOT GLOB '*[^0-9]*')
);

CREATE TABLE Bilheteiro(
    nifBilheteiro TEXT REFERENCES Trabalhador(nif) ON DELETE CASCADE ON UPDATE CASCADE,
    morada TEXT REFERENCES Estacao ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(nifBilheteiro)
);

CREATE TABLE Comboio1(
    id INTEGER PRIMARY KEY,
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    CHECK(marca NOT GLOB '*[^a-zA-Z ]*')
);

CREATE TABLE Comboio2(
    marca TEXT NOT NULL,
    modelo TEXT NOT NULL,
    velMaxima INTEGER CHECK (velMaxima > 0),
    CHECK(marca NOT GLOB '*[^a-zA-Z ]*'),
    PRIMARY KEY(marca,modelo)
);

CREATE TABLE ComboioCarga(
    id INTEGER REFERENCES Comboio1(id) ON DELETE CASCADE ON UPDATE CASCADE,
    maxCarga INTEGER CHECK (maxCarga > 0 AND maxCarga < 5)
);

CREATE TABLE ComboioPassageiros(
    id INTEGER REFERENCES Comboio1(id) ON DELETE CASCADE ON UPDATE CASCADE,
    lugares INTEGER CHECK (lugares > 0)
);


CREATE TABLE Viagem1(
    id INTEGER PRIMARY KEY,
    data INTEGER NOT NULL,
    horaDePartida INTEGER NOT NULL,
    idComboio INTEGER REFERENCES Comboio ON DELETE CASCADE ON UPDATE CASCADE,
    idRota INTEGER REFERENCES Rota ON DELETE CASCADE ON UPDATE CASCADE,
    nifMaquinista REFERENCES Maquinista ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Viagem2(
    horaDePartida INTEGER NOT NULL,
    idRota INTEGER REFERENCES Rota ON DELETE CASCADE ON UPDATE CASCADE,
    horaDeChegada INTEGER NOT NULL,
    CHECK(horaDeChegada > horaDePartida),
    PRIMARY KEY(horaDePartida, idRota)
);

CREATE TABLE RevisorViagem(
    nifRevisor TEXT REFERENCES Revisor ON DELETE CASCADE ON UPDATE CASCADE,
    idViagem INTEGER REFERENCES Viagem ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(nifRevisor, idViagem)
);

CREATE TABLE Bilhete1(
    id INTEGER PRIMARY KEY,
    lugarDestinado TEXT NOT NULL,
    nifCliente REFERENCES Cliente ON DELETE CASCADE ON UPDATE CASCADE,
    nomeEstacaoPartida REFERENCES Estacao ON DELETE CASCADE ON UPDATE CASCADE,
    nomeEstacaoChegada REFERENCES Estacao ON DELETE CASCADE ON UPDATE CASCADE,
    idViagem REFERENCES Viagem ON DELETE CASCADE ON UPDATE CASCADE,
    nifBilheteiro REFERENCES Bilheteiro ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Bilhete2(
    moradaEstacaoPartida REFERENCES Estacao ON DELETE CASCADE ON UPDATE CASCADE,
    moradaEstacaoChegada REFERENCES Estacao ON DELETE CASCADE ON UPDATE CASCADE,
    idViagem REFERENCES Viagem ON DELETE CASCADE ON UPDATE CASCADE,
    preco FLOAT CHECK(preco > 0),
    PRIMARY KEY(moradaEstacaoPartida, moradaEstacaoChegada,idViagem)
);
