.mode columns
.headers	on
.nullvalue	NULL


SELECT marca, modelo, lugares
FROM ComboioCaracteristicas 
WHERE  marca = ‘Stadler’ AND lugares > 115;
