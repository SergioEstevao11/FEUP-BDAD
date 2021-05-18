.mode columns
.headers	on
.nullvalue	NULL

SELECT nomeEstacao, sum(preco) as total
FROM Bilhete NATURAL JOIN BilhetePreco 
                     JOIN Bilheteiro USING(nifBilheteiro) 
                     JOIN Estacao USING(nomeEstacao) GROUP BY nomeEstacao;
