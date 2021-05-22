.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS verificaPassageiros;
DROP TRIGGER IF EXISTS verificaEstacoes;
DROP TRIGGER IF EXISTS verificaLugares;