.mode columns
.header on
.nullvalue NULL

PRAGMA foreign_keys = ON;

DROP TRIGGER IF EXISTS atribuirComboiodePassageiros;
DROP TRIGGER IF EXISTS atribuirComboiodePassageirosUpdate;
DROP TRIGGER IF EXISTS atribuirComboiodeCarga;
DROP TRIGGER IF EXISTS atribuirComboiodeCargaUpdate;