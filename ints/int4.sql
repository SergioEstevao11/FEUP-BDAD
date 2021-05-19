.mode columns
.headers	on
.nullvalue	NULL

SELECT  bilheteiro_idade_media, maquinista_idade_media, revisor_idade_media
FROM   ((SELECT avg(idade) AS bilheteiro_idade_media 
        FROM Bilheteiro)
            INNER JOIN
        (SELECT avg(idade) AS maquinista_idade_media 
        FROM Maquinista)
            INNER JOIN
        (SELECT avg(idade) AS revisor_idade_media 
        FROM Revisor));




