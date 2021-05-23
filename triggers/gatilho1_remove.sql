.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS verificaPassageiros;
DROP TRIGGER IF EXISTS verificaPassageirosUpdate;
DROP TRIGGER IF EXISTS verificaEstacoes;
DROP TRIGGER IF EXISTS verificaEstacoesUpdate;
DROP TRIGGER IF EXISTS verificaLugares;
DROP TRIGGER IF EXISTS verificaLugaresUpdate;