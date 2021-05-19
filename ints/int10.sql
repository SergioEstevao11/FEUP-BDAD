.mode columns
.headers	on
.nullvalue	NULL

--COMPLETA

SELECT nome AS Nome
FROM Cliente 
WHERE nifCliente NOT IN (
        SELECT nifCliente
        FROM Cliente JOIN Assinatura USING(nifCliente)
    )
    AND nifCliente IN (
        SELECT nifCliente
        FROM Cliente JOIN Bilhete USING(nifCliente) JOIN Bilheteiro USING(nifBilheteiro)
        WHERE idade > 30
    );


