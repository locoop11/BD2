-- EXERCICIO 7

select t3.* from (select origem, MAX(numvoos) as maxvoos from (select piloto.nic, voo.origem, count(*) as numvoos from piloto
join voo as voo on  piloto.nic = voo.comandante
where voo.tipo = "T"
group by piloto.nic, voo.origem
ORDER BY  voo.origem, numvoos desc) as t
GROUP BY origem) as t2 JOIN (select piloto.nic, voo.origem, count(*) as numvoos from piloto
join voo as voo on  piloto.nic = voo.comandante
where voo.tipo = "T"
group by piloto.nic, voo.origem
ORDER BY  voo.origem, numvoos desc) as t3
where t3.numvoos = t2.maxvoos
and t3.origem = t2.origem;

-- EXERCICIO 8


select DISTINCT pais 
from (select * FROM (select * from viaja join pessoa on pessoa.nic = pessoa ) as t join voo on voo.codigo = t.voo where tipo = "P") as t2



select pessoa, count (*) FROM (select * from viaja join pessoa on pessoa.nic = pessoa ) as t join voo on voo.codigo = t.voo where tipo = "P"
group by pessoa 