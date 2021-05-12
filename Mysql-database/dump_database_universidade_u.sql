/*remove o banco de dados*/
/*DROP DATABASE `universidade_y`;*/

/*cria o banco de dados*/
CREATE DATABASE `universidade_y`;

/*se conecta ao banco de dados*/
USE `universidade_u`;

/*instruções ddl para criação das tabelas do banco de dados*/
CREATE TABLE `aluno` (
  `idaluno` int(11) NOT NULL AUTO_INCREMENT,
  `sexo` char(1) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `nome` varchar(25) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `data_nascimento` date DEFAULT NULL,
  `ativo_sn` int(11) DEFAULT '1',
  PRIMARY KEY (`idaluno`),
  UNIQUE `uc_aluno_cpf` (`cpf`),
  UNIQUE `uc_aluno_email` (`email`)
);

CREATE TABLE `aluno_curso` (
  `fk_idaluno` int(11) NOT NULL,
  `fk_idcurso` int(11) NOT NULL,
  `data_inscricao_curso` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `valor_pago_curso` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`fk_idaluno`,`fk_idcurso`,`data_inscricao_curso`)
);

CREATE TABLE `curso` (
  `idcurso` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idcurso`)
);

CREATE TABLE `disciplina` (
  `iddisciplina` int(11) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(50) NOT NULL,
  `carga_horaria` int(11) DEFAULT NULL,
  `fk_idprofessor` int(11) DEFAULT NULL,
  `fk_idcurso` int(11) DEFAULT NULL,
  PRIMARY KEY (`iddisciplina`)
);

CREATE TABLE `endereco` (
  `idendereco` int(11) NOT NULL AUTO_INCREMENT,
  `logradouro` varchar(100) DEFAULT NULL,
  `numero` varchar(10) DEFAULT NULL,
  `complemento` varchar(20) DEFAULT NULL,
  `bairro` varchar(100) DEFAULT NULL,
  `cidade` varchar(50) DEFAULT NULL,
  `estado` char(2) DEFAULT NULL,
  `fk_idaluno` int(11) DEFAULT NULL,
  PRIMARY KEY (`idendereco`),
  UNIQUE `uc_endereco_fkidaluno` (`fk_idaluno`)
);

CREATE TABLE `funcionario` (
  `idmatricula` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `funcao` varchar(50) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `fk_idmatricula_supervisor` int(11) DEFAULT NULL,
  PRIMARY KEY (`idmatricula`)
);

CREATE TABLE `gasto` (
  `idgasto` int(11) NOT NULL AUTO_INCREMENT,
  `ano` int(11) NOT NULL,
  `tipo` enum('previsto','realizado') NOT NULL,
  `jan` float(10,2) DEFAULT NULL,
  `fev` float(10,2) DEFAULT NULL,
  `mar` float(10,2) DEFAULT NULL,
  `abr` float(10,2) DEFAULT NULL,
  `mai` float(10,2) DEFAULT NULL,
  `jun` float(10,2) DEFAULT NULL,
  `jul` float(10,2) DEFAULT NULL,
  `ago` float(10,2) DEFAULT NULL,
  `set` float(10,2) DEFAULT NULL,
  `out` float(10,2) DEFAULT NULL,
  `nov` float(10,2) DEFAULT NULL,
  `dez` float(10,2) DEFAULT NULL,
  PRIMARY KEY (`idgasto`)
);

CREATE TABLE `professor` (
  `idprofessor` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idprofessor`)
);

CREATE TABLE `projeto` (
  `idcodigo` int(11) NOT NULL AUTO_INCREMENT,
  `data_criacao` datetime DEFAULT CURRENT_TIMESTAMP,
  `nome` varchar(100) NOT NULL,
  PRIMARY KEY (`idcodigo`)
);

CREATE TABLE `projeto_funcionario` (
  `fk_idcodigo` int(11) NOT NULL,
  `fk_idmatricula` int(11) NOT NULL,
  `horas_estimadas` int(11) NOT NULL,
  `horas_realizadas` int(11) DEFAULT NULL,
  PRIMARY KEY (`fk_idcodigo`,`fk_idmatricula`)
);

CREATE TABLE `telefone` (
  `idtelefone` int(11) NOT NULL AUTO_INCREMENT,
  `numero` varchar(20) NOT NULL,
  `fk_idaluno` int(11) NOT NULL,
  `tipo` enum('res','com','cel') NOT NULL,
  PRIMARY KEY (`idtelefone`)
);

/*fks tabela aluno_curso*/
ALTER TABLE `aluno_curso` ADD CONSTRAINT `fk_aluno_curso` 
FOREIGN KEY (`fk_idaluno`) REFERENCES `aluno` (`idaluno`);

ALTER TABLE `aluno_curso` ADD CONSTRAINT `fk_curso_aluno` 
FOREIGN KEY (`fk_idcurso`) REFERENCES `curso` (`idcurso`);

/*fks tabela disciplina*/
ALTER TABLE `disciplina` ADD CONSTRAINT `fk_curso_disciplina` 
FOREIGN KEY (`fk_idcurso`) REFERENCES `curso` (`idcurso`);

ALTER TABLE `disciplina` ADD CONSTRAINT `fk_disciplina_professor` 
FOREIGN KEY (`fk_idprofessor`) REFERENCES `professor` (`idprofessor`);

/*fk tabela endereco*/
ALTER TABLE `endereco` ADD CONSTRAINT `fk_aluno_endereco` 
FOREIGN KEY (`fk_idaluno`) REFERENCES `aluno` (`idaluno`);

/*fk tabela funcionario*/
ALTER TABLE `funcionario` ADD CONSTRAINT `fk_funcionario_supervisor` 
FOREIGN KEY (`fk_idmatricula_supervisor`) REFERENCES `funcionario` (`idmatricula`);

/*fks tabela projeto_funcionario*/
ALTER TABLE `projeto_funcionario` ADD CONSTRAINT `projeto_funcionario_ibfk_1` 
FOREIGN KEY (`fk_idcodigo`) REFERENCES `projeto` (`idcodigo`);

ALTER TABLE `projeto_funcionario` ADD CONSTRAINT `projeto_funcionario_ibfk_2` 
FOREIGN KEY (`fk_idmatricula`) REFERENCES `funcionario` (`idmatricula`);

/*fk tabela telefone*/
ALTER TABLE `telefone` ADD CONSTRAINT `fk_aluno_telefone` 
FOREIGN KEY (`fk_idaluno`) REFERENCES `aluno` (`idaluno`);

/*inserts*/
INSERT INTO `aluno` (`sexo`, `email`, `nome`, `cpf`, `data_nascimento`) VALUES 
('M', 'jose@teste.com.br', 'José', '222.222.222-22', '1985-06-01'),
('F', 'maria@teste.com.br', 'Maria', '111.111.111-11', '1979-12-10'),
('F', 'rosa@teste.com.br', 'Rosa', '333.333.333-33', '1990-12-22'),
('M', 'joao@teste.com.br', 'João', '444.444.444-44', '1970-08-05'),
('M', 'pedro@teste.com.br', 'Pedro', '555.555.555-55', '1967-07-02'),
('F', 'bianca@teste.com.br', 'Bianca', '666.666.666-66', '1995-11-22'),
('M', 'jorge@teste.com.br', 'Jorge', '777.777.777-77', '1989-01-06'),
('F', 'mariana@teste.com.br', 'Mariana', '888.888.888-88', '1980-01-30'),
('M', 'antonio@teste.com.br', 'Antônio', '999.999.999-99', '1991-12-03');

INSERT INTO `endereco` (`logradouro`, `numero`, `bairro`, `cidade`, `estado`, `fk_idaluno`) VALUES
('Rua 9', 'nº 9', 'Bairro 9', 'São Paulo', 'SP', 9),
('Rua 5', 'nº 5', 'Bairro 5', 'Belo Horizonte', 'MG', 5),
('Rua 3', 'nº 3', 'Bairro 3', 'Natal', 'RN', 3),
('Rua 8', 'nº 8', 'Bairro 8', 'Rio de Janeiro', 'RJ', 8),
('Rua 4', 'nº 4', 'Bairro 4', 'Fortaleza', 'CE', 4),
('Rua 1', 'nº 1', 'Bairro 1', 'Manaus', 'AM', 1),
('Rua 7', 'nº 7', 'Bairro 7', 'Goiânia', 'GO', 7),
('Rua 2', 'nº 2', 'Bairro 2', 'Florianópolis', 'SC', 2),
('Rua 6', 'nº 6', 'Bairro 6', 'Vitória', 'ES', 6);

INSERT INTO `telefone` (`numero`, `fk_idaluno`, `tipo`) VALUES
('11 92222-2222', 9, 'cel'), 
('11 3333-2222', 9, 'com'), 
('31 5555-2222', 5, 'res'),
('21 4444-1111', 8, 'res'), 
('21 91111-2222', 9, 'cel'), 
('62 98888-7777', 7, 'cel'), 
('62 4444-4444', 7, 'com'), 
('62 6666-9999', 7, 'res'),
('27 95555-0000', 6, 'cel');

INSERT INTO `curso` (`descricao`) VALUES
('NodeJS e MongoDB'),
('Web Completo 2019'),
('ES6, TypeScript e Angular'),
('React Native'),
('Bancos de Dados Relacionais');

INSERT INTO `professor` (`nome`, `email`) VALUES 
('Laura', 'laura@teste.com.br'),
('Miguel', 'miguel@teste.com.br'),
('Sofia', 'sofia@teste.com.br'),
('Patrícia', 'patricia@teste.com.br'),
('Arthur', 'arthur@teste.com.br'),
('Breno', 'breno@teste.com.br'),
('Raquel', 'raquel@teste.com.br'),
('Hugo', 'hugo@teste.com.br'),
('Alex', 'alex@teste.com.br');

INSERT INTO `disciplina` (`descricao`, `carga_horaria`, `fk_idprofessor`, `fk_idcurso`) VALUES
('HTML', 4, 5, 2), 
('CSS', 3, null, 2), 
('Bootstrap', 5, 5, 2), 
('JavaScript', 10, null, 2), 
('PHP', 15, null, 2),
('NodeJS', 8, 3, 1), 
('MongoDB', 6, 3, 1), 
('Express', 4, 3, null), 
('ES6', 7, 3, 3), 
('TypeScript', 4, 3, 3), 
('Orientada a Objetos', 5, null, 3),
('Angular', 20, 4, 3), 
('ES6', 7, 3, null), 
('Ract Native', 7, 8, 4), 
('Redux', 4, 8, 4),
('MySQL', 7, null, 5);