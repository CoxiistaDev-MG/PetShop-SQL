-- Active: 1781488322655@@127.0.0.1@5432@estudo
CREATE TABLE estado(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(20) NOT NULL
);

CREATE TABLE cidade(
    id SERIAL PRIMARY KEY,
    id_estado INTEGER NOT NULL,

    FOREIGN KEY( id_estado) REFERENCES estado (id)
);

CREATE TABLE bairro(
    id SERIAL PRIMARY KEY,
    id_cidade INTEGER NOT NULL ,
    nome varchar(60),

    FOREIGN KEY (id_cidade) REFERENCES cidade (id)
);

CREATE TABLE rua(
    id SERIAL PRIMARY KEY,
    id_bairro INTEGER NOT NULL,
    FOREIGN KEY (id_bairro) REFERENCES bairro (id)
);

CREATE TABLE pessoa(
    id SERIAL PRIMARY KEY,
    primeiro_nome VARCHAR(30),
    sobrenome VARCHAR(40)
);

CREATE TABLE pessoa_telefone(
    id SERIAL PRIMARY KEY,
    id_pessoa INTEGER NOT NULL,
    telefone VARCHAR(14)
);

CREATE TABLE endereco_pessoa(
    id SERIAL PRIMARY KEY,
    id_rua INTEGER NOT NULL,
    numero SMALLINT NOT NULL,
    complemento VARCHAR(50),
    cep varchar(9)

);
CREATE TABLE cliente(
    codigo_cliente SERIAL PRIMARY KEY,
    data_de_inscricao DATE NOT NULL,
    id_pessoa INTEGER UNIQUE NOT NULL,
    FOREIGN KEY (id_pessoa) REFERENCES pessoa (id)
);

CREATE TABLE cargo(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(25),
    salario DECIMAL(6, 2),
    descricao TEXt
);

CREATE TABLE funcionario(
    codigo_de_contrato SERIAL PRIMARY KEY,
    id_pessoa INTEGER NOT NULL,
    id_cargo INTEGER NOT NULL,
    data_admissao DATE NOT NULL,
    atuando BOOLEAN DEFAULT TRUE,
    FOREIGN KEY(id_pessoa) REFERENCES pessoa (id),
    FOREIGN KEY (id_cargo) REFERENCES cargo (id)
);

CREATE TABLE demissao (
    id SERIAL PRIMARY KEY,
    codigo_de_contrato INTEGER NOT NULL,
    data_demissao DATE
);

CREATE TYPE unida_medida AS ENUM(
    'gramas',
    'unidade',
    'ml'
);
CREATE TABLE tipo_produto(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(30),
    unidade_de_medida unida_medida NOT NULL,
    descricao text
);

CREATE TABLE produto(
    id SERIAL PRIMARY KEY,
    id_tipo_produto INTEGER NOT NULL,
    nome VARCHAR(30),
    quantidade_unidade SMALLINT
);

CREATE TABLE tipo_animal(
    id SERIAL PRIMARY KEY,
    nome varchar(20)
);

CREATE TABLE animal_cliente(
    id SERIAL PRIMARY KEY,
    id_cliente INTEGER NOT NULL,
    id_tipo_animal INTEGER NOT NULL,
    nome_do_animal VARCHAR(30),
    raca VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES cliente (codigo_cliente),
    FOREIGN KEY (id_tipo_animal) REFERENCES tipo_animal (id)
);

CREATE TABLE produto_tipo_animal(
    id SERIAL PRIMARY KEY,
    id_tipo_animal INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    FOREIGN KEY(id_tipo_animal) REFERENCES tipo_animal (id),
    FOREIGN KEY(id_produto) REFERENCES produto (id)
);

CREATE TABLE estoque_venda(
    id SERIAL PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    quantidade SMALLINT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

CREATE TABLE estoque_uso_interno(
    id SERIAL PRIMARY KEY,
    id_produto INTEGER NOT NULL,
    quantidade SMALLINT NOT NULL,
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);

CREATE TABLE tipo_transacao(
    id SERIAL PRIMARY KEY,
    nome VARCHAR(20) NOT NULL,
    descricao TEXT
);

CREATE TABLE transacao(
    codigo_transacao SERIAL PRIMARY KEY,
    id_tipo_transacao INTEGER NOT NULL,
    codigo_funcionario INTEGER NOT NULL,
    id_cliente INTEGER NOT NULL,
    nome_animal VARCHAR(30),
    data_inicio DATE NOT NULL,
    data_termino DATE,
    preco DECIMAL(7,2) NOT NULL,
    FOREIGN KEY (id_tipo_transacao) REFERENCES tipo_transacao (id),
    FOREIGN KEY (codigo_funcionario) REFERENCES funcionario (codigo_de_contrato),
    FOREIGN KEY (id_cliente) REFERENCES cliente (codigo_cliente)
);

CREATE TABLE vendas(
    id SERIAL PRIMARY KEY,
    codigo_transacao INTEGER NOT NULL,
    id_produto INTEGER NOT NULL,
    quantidade SMALLINT,

    FOREIGN KEY (codigo_transacao) REFERENCES transacao(codigo_transacao),
    FOREIGN KEY (id_produto) REFERENCES produto(id)
);