.mode columns
.headers	on
.nullvalue	NULL



SELECT nome AS Nome, preco_sum AS Preco
FROM  ( 
      SELECT nome, nifCliente, sum(preco) as preco_sum
		  FROM Bilhete JOIN BilhetePreco USING(idViagem) JOIN Cliente USING(nifCliente) GROUP BY nifCliente
    ) 
    ORDER BY preco_sum DESC;