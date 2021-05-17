.mode columns
.headers	on
.nullvalue	NULL


SELECT nome
FROM Cliente 
WHERE nome NOT IN (
        SELECT nome 
        FROM Cliente JOIN Assinatura USING(nifCliente)
    ); 


