.mode columns
.headers	on
.nullvalue	NULL


SELECT nome
FROM Cliente 
WHERE nifCliente NOT IN (
        SELECT nifCliente
        FROM Cliente JOIN Assinatura USING(nifCliente)
    )
    AND nifCliente IN (
        SELECT nifCliente
        FROM Cliente JOIN Bilhete USING(nifCliente) 
    );


