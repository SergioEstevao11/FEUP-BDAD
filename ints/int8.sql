.mode columns
.headers	on
.nullvalue	NULL


SELECT nome, preco
	FROM ( 
        SELECT nome, nifCliente, preco
		FROM Bilhete JOIN BilhetePreco USING(idViagem) JOIN Cliente USING(nifCliente)
    );