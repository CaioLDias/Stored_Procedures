-- Criando tabela para Aluno
CREATE TABLE Aluno (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Sobrenome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    DataNascimento DATE,
    CursoID INT,
    FOREIGN KEY (CursoID) REFERENCES Curso(ID)
);

-- Criando tabela para Curso
CREATE TABLE Curso (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    NomeCurso VARCHAR(100) NOT NULL,
    Descricao TEXT,
    ProfessorID INT,
    FOREIGN KEY (ProfessorID) REFERENCES Professor(ID)
);

-- Criando tabela para Professor
CREATE TABLE Professor (
    ID INT PRIMARY KEY AUTO_INCREMENT,
    Nome VARCHAR(50) NOT NULL,
    Sobrenome VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- Criando Stored Procedure para inserir cursos
DELIMITER //
CREATE PROCEDURE InserirCurso(
    IN nome_curso VARCHAR(100),
    IN descricao TEXT,
    IN professor_id INT
)
BEGIN
    INSERT INTO Curso (NomeCurso, Descricao, ProfessorID)
    VALUES (nome_curso, descricao, professor_id);
END //
DELIMITER ;

-- Criando Stored Procedure para selecionar todos os cursos
DELIMITER //
CREATE PROCEDURE SelecionarCursos()
BEGIN
    SELECT * FROM Curso;
END //
DELIMITER ;

-- Alterando a trigger para gerar e atualizar o email do aluno com número de aluno
DELIMITER //
CREATE TRIGGER GerarEmailAluno
BEFORE INSERT ON Aluno
FOR EACH ROW
BEGIN
    DECLARE novo_email VARCHAR(100);
    SET novo_email = CONCAT(NEW.Nome, '.', NEW.Sobrenome, NEW.ID, '@gmail.com');
    SET NEW.Email = novo_email;
END //
DELIMITER ;

-- Inserindo exemplos de alunos na tabela Aluno
INSERT INTO Aluno (ID, Nome, Sobrenome, Email, DataNascimento, CursoID) VALUES
(1, 'João', 'Silva', '', '1995-03-15', 1),
(2, 'Maria', 'Oliveira', '', '1998-07-20', 2),
(3, 'Pedro', 'Santos', '', '1997-11-10', 1),
(4, 'Ana', 'Costa', '', '1996-05-05', 3),
(5, 'Lucas', 'Pereira', '', '1994-09-28', 2),
(6, 'Juliana', 'Souza', '', '1999-01-18', 1),
(7, 'Rafael', 'Lima', '', '1993-12-02', 3),
(8, 'Isabela', 'Martins', '', '1997-04-22', 2),
(9, 'Carlos', 'Ferreira', '', '1995-08-14', 1),
(10, 'Camila', 'Rodrigues', '', '1998-06-30', 3);

-- Inserindo exemplos de professores na tabela Professor
INSERT INTO Professor (ID, Nome, Sobrenome, Email) VALUES
(1, 'André', 'Silva', 'andre.silva@gmail.com'),
(2, 'Maria', 'Santos', 'maria.santos@gmail.com'),
(3, 'José', 'Oliveira', 'jose.oliveira@gmail.com');

-- Inserindo exemplos de cursos na tabela Curso
INSERT INTO Curso (ID, NomeCurso, Descricao, ProfessorID) VALUES
(1, 'Engenharia Civil', 'Curso de graduação em Engenharia Civil', 1),
(2, 'Medicina', 'Curso de graduação em Medicina', 2),
(3, 'Administração', 'Curso de graduação em Administração', 3);

-- Chamando a Stored Procedure --
call SelecionarCursos();

-- Chamando a Stored Procedure para adicionar novos cursos --
CALL InserirCurso('Engenharia Mecânica', 'Curso de graduação em Engenharia Mecânica', 1);
CALL InserirCurso('Engenharia Química', 'Curso de graduação em Engenharia Química', 2);

-- Adicionando novos alunos com email vazio, para a trigger adicionar --
INSERT INTO Aluno () 
VALUES (11, 'João', 'Silva', '', '1985-10-25', 1);

INSERT INTO Aluno () 
VALUES (12, 'Maria', 'Oliveira', '', '1998-05-29', 3);

-- Adicionando novos alunos com email vazio, para a trigger adicionar --
INSERT INTO Aluno () 
VALUES (13, 'Daniel', 'Silva', '', '1978-08-30', 2);

-- Ver tabela aluno --
select * from aluno