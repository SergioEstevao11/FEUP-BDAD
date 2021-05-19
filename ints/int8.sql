.mode columns
.headers	on
.nullvalue	NULL

--COMPLETED

SELECT nome, preco_sum as PrecoTotal, nifCliente
FROM  ( 
      SELECT nome, nifCliente, sum(preco) as preco_sum
      FROM Bilhete JOIN BilhetePreco USING(idViagem) JOIN Cliente USING(nifCliente) 
      GROUP BY nifCliente
      )
WHERE nifCliente NOT IN(
      SELECT nifCliente
      FROM Cliente JOIN Assinatura USING(nifCliente) 
      GROUP BY nifCliente
)
ORDER BY PrecoTotal DESC;