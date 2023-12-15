DROP TABLE viaja;
DROP TABLE classe;
DROP TABLE voo;
DROP TABLE piloto;
DROP TABLE pessoa;
DROP TABLE aeroporto;
-- ----------------------------------------------------------------------
USE Tests;

CREATE TABLE aeroporto (
 sigla CHAR(9),
 nome VARCHAR(20) NOT NULL,
 cidade VARCHAR(15) NOT NULL,
 pais CHAR(2) NOT NULL, -- codigo do pais (exo. PT, FR, NL)
--
 CONSTRAINT pk_aeroporto
 PRIMARY KEY (sigla),
--
 CONSTRAINT un_aeroporto_nome
 UNIQUE (nome)
);
CREATE TABLE pessoa(
 nic NUMERIC(8),
 nif NUMERIC(9) NOT NULL,
 nome VARCHAR(40) NOT NULL,
 genero CHAR(1) NOT NULL,
 ano NUMERIC(4) NOT NULL, -- ano de nascimento
 pais CHAR(2) NOT NULL, -- codigo do pais
--
 CONSTRAINT pk_pessoa
 PRIMARY KEY (nic),
--
 CONSTRAINT nn_pessoa_nif
 UNIQUE (nif),
--
 CONSTRAINT ck_pessoa_nic
 CHECK (nic BETWEEN 1 AND 99999999),
--
 CONSTRAINT ck_pessoa_nif
 CHECK (nif BETWEEN 1 AND 999999999),
 --
 CONSTRAINT ck_pessoa_genero
 CHECK (genero IN ("F","M")),
--
 CONSTRAINT ck_pessoa_ano
 CHECK (ano BETWEEN 1900 AND 2100)
);
CREATE TABLE piloto(
 nic NUMERIC(8),
 carta NUMERIC(6) NOT NULL,
 ano NUMERIC(4) NOT NULL, -- inicio de actividade
 padrinho NUMERIC(8), -- padrinho de voo
--
 CONSTRAINT pk_piloto
 PRIMARY KEY (nic),
--
 CONSTRAINT un_piloto_carta -- carta unica
 UNIQUE (carta),
--
 CONSTRAINT ck_piloto_carta
 CHECK (carta > 0),
--
 CONSTRAINT ck_piloto_ano
 CHECK (ano BETWEEN 1900 AND 2100),
--
 CONSTRAINT fk_piloto_nic
 FOREIGN KEY (nic)
 REFERENCES pessoa (nic) ON DELETE CASCADE,
--
 CONSTRAINT fk_piloto_padrinho
 FOREIGN KEY (padrinho)
 REFERENCES piloto (nic)
);
CREATE TABLE voo (
 codigo NUMERIC(7),
 data DATE NOT NULL,
 duracao NUMERIC(4) NOT NULL, -- em minutos
 tipo CHAR(1) NOT NULL, -- plain, cargo ou charter
 origem CHAR(9) NOT NULL,
 destino CHAR(9) NOT NULL,
 comandante NUMERIC(8) NOT NULL,
 co_piloto NUMERIC(8) NOT NULL,
--
 CONSTRAINT pk_voo
 PRIMARY KEY (codigo),
--
--
 CONSTRAINT ck_voo_duracao
 CHECK (duracao > 0),
--
 CONSTRAINT ck_voo_tipo
 CHECK (tipo IN ("P","C","T")), -- tipo:(P)lain, (C)argo ou Char(T)er
 --
 CONSTRAINT fk_voo_origem
 FOREIGN KEY (origem)
 REFERENCES aeroporto (sigla),
--
 CONSTRAINT fk_voo_destino
 FOREIGN KEY (destino)
 REFERENCES aeroporto (sigla),
--
 CONSTRAINT fk_voo_comandante
 FOREIGN KEY (comandante)
 REFERENCES piloto (nic),
--
 CONSTRAINT fk_voo_co_piloto
 FOREIGN KEY (co_piloto)
 REFERENCES piloto (nic)
);
CREATE TABLE classe (
 nome CHAR(10), -- exo. ‘first’, ‘executive’ ...
 descricao VARCHAR(30) NOT NULL,
--
 CONSTRAINT pk_classe
 PRIMARY KEY (nome),
--
 CONSTRAINT un_classe_descricao
 UNIQUE (descricao) -- descricao unica
);
CREATE TABLE viaja (
 pessoa NUMERIC(8),
 voo NUMERIC(7),
 classe CHAR(10) NOT NULL,
--
 CONSTRAINT pk_viaja
 PRIMARY KEY (pessoa,voo),
--
 CONSTRAINT fk_viaja_pessoa
 FOREIGN KEY (pessoa)
 REFERENCES pessoa (nic),
--
 CONSTRAINT fk_viaja_voo
 FOREIGN KEY (voo)
 REFERENCES voo (codigo),
--
 CONSTRAINT fk_viaja_classe
 FOREIGN KEY (classe)
 REFERENCES classe (nome)
);