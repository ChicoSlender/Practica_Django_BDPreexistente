CREATE DATABASE IF NOT EXISTS PruebaLibreria;

USE PruebaLibreria;

CREATE TABLE IF NOT EXISTS Autor (
    id BIGINT unsigned AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    apellido VARCHAR(255) NOT NULL,
    fecha_nacimiento DATE,
    sexo ENUM('M','F') NOT NULL
);

CREATE TABLE IF NOT EXISTS Categoria (
    id BIGINT unsigned AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS Libro (
    id BIGINT unsigned AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    descripcion VARCHAR(500),
    img VARCHAR(255),
    id_autor BIGINT unsigned,
        CONSTRAINT libro_fk_autor FOREIGN KEY (id_autor) REFERENCES Autor(id)
); 

CREATE TABLE IF NOT EXISTS CategoriasXLibros (
    id_libro BIGINT unsigned,
    id_categoria BIGINT unsigned,
        CONSTRAINT categoriasxlibros_pk PRIMARY KEY (id_libro, id_categoria),
        CONSTRAINT categoriasxlibros_fk_libro FOREIGN KEY (id_libro) REFERENCES Libro(id),
        CONSTRAINT categoriasxlibros_fk_categoria FOREIGN KEY (id_categoria) REFERENCES Categoria(id)
);

INSERT INTO Categoria(nombre, descripcion) VALUES
    ('Fantasia', ''),
    ('Policial', ''),
    ('Misterio', ''),
    ('Aventura', ''),
    ('Juvenil', '');

INSERT INTO Autor(nombre, apellido, fecha_nacimiento, sexo) VALUES
    ('Isabel', 'Allende', CAST('1942-08-02' as DATE), 'F'),
    ('JK', 'Rowling', CAST('1965-07-31' as DATE), 'F'),
    ('Arthur', 'Conan Doyle', CAST('1859-05-22' as DATE), 'M');

INSERT INTO Libro (titulo, descripcion, img, id_autor) VALUES
    ('Harry potter y la piedra filosofal', 'Novela de exito, la primera de la saga Harry potter. Nuestro protagonista Harry potter descrube que es un mago y debe ir a la escuela Hogwarts de magia y hechicheria', 'Harry_Potter_y_la_Piedra_Filosofal_Portada_Español.PNG', 2),
    ('La ciudad de las bestias', 'La primera parte de la trilogía "Las memorias del aguila y el jaguar. Alexander Cold, de 15 años, viaja con su abuela al amazonas con el fin de documentar la existencia de una criatura apodada "la bestia"', 'la-ciudad-de-las-bestias.jpg', 1),
    ('El sabueso de los Baskerville', 'La historia transcurre en 1889 cuando Sir Charles Baskerville es encontrado muerto en un sendero en el páramo de Devonshire, el doctor Mortimer acude a Londres para buscar la ayuda de Sherlock Holmes', 'el-sabueso-de-los-baskerville.jpg', 3);

INSERT INTO CategoriasXLibros (id_libro, id_categoria) VALUES
    (1, 1),
    (1, 5),
    (2, 1),
    (2, 4),
    (2, 5),
    (3, 2),
    (3, 3);


CREATE USER IF NOT EXISTS 'test'@'localhost' IDENTIFIED BY 'test123';

GRANT DELETE, INSERT, SELECT, UPDATE, CREATE ON PruebaLibreria.* TO 'test'@'localhost';