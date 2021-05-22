.mode columns
.headers	on
.nullvalue	NULL

SELECT nome, numServico
FROM Cliente JOIN (
    SELECT nifCliente, count(nomeServico) as numServico
    FROM Bilhete JOIN Cliente USING (nifCliente) 
                 JOIN Viagem USING (idViagem) 
                 JOIN Rota USING(idRota) 
                 JOIN Servico USING(nomeServico) GROUP BY nifCliente
    ) USING (nifCliente)
WHERE numServico > 1;