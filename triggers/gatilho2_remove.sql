.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS calcularDataDeChegada;
DROP TRIGGER IF EXISTS calcularDataDeChegadaUpdate;