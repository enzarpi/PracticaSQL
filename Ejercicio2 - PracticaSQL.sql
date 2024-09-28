-- Insertar datos en las tablas
INSERT INTO Alumnos (nombre, apellidos, email, fecha_nacimiento) VALUES
('Carlos', 'García López', 'carlos.garcia@keepcoding.com', '1990-05-14'),
('María', 'Fernández Pérez', 'maria.fernandez@keepcoding.com', '1988-09-21'),
('Juan', 'Rodríguez Gómez', 'juan.rodriguez@keepcoding.com', '1992-03-10'),
('Ana', 'Martínez Sánchez', 'ana.martinez@keepcoding.com', '1991-12-05'),
('Luis', 'Hernández Díaz', 'luis.hernandez@keepcoding.com', '1993-07-22');

INSERT INTO Bootcamps (nombre, descripcion, fecha_inicio, fecha_fin) VALUES
('BigData', 'Análisis de datos masivos', '2024-01-10', '2024-09-10'),
('Ciberseguridad', 'Seguridad informática avanzada', '2024-02-15', '2024-07-15'),
('IA', 'Inteligencia artificial aplicada', '2024-03-20', '2024-08-20'),
('Java', 'Desarrollo de aplicaciones en Java', '2024-04-25', '2024-09-25'),
('Blockchain', 'Tecnología blockchain para negocios', '2024-05-30', '2024-10-30');

INSERT INTO Modulos (nombre, descripcion, bootcamp_id) VALUES
('Introducción a Big Data', 'Conceptos básicos de Big Data', 1),
('Seguridad en Redes', 'Ciberseguridad aplicada en redes', 2),
('Aprendizaje Automático', 'Técnicas de machine learning', 3),
('Fundamentos de Java', 'Programación básica en Java', 4),
('Smart Contracts', 'Uso de contratos inteligentes en Blockchain', 5);

INSERT INTO Profesores (nombre, apellidos, email, especialidad) VALUES
('Pedro', 'López García', 'pedro.lopez@keepcoding.com', 'Big Data'),
('Lucía', 'Martínez Fernández', 'lucia.martinez@keepcoding.com', 'Ciberseguridad'),
('Carlos', 'Hernández Pérez', 'carlos.hernandez@keepcoding.com', 'Inteligencia Artificial'),
('Ana', 'Gómez Rodríguez', 'ana.gomez@keepcoding.com', 'Desarrollo Java'),
('Miguel', 'Sánchez Torres', 'miguel.sanchez@keepcoding.com', 'Blockchain');

INSERT INTO Inscripciones (alumno_id, bootcamp_id, fecha_inscripcion) VALUES
(1, 1, '2024-01-05'),  -- Alumno 1 inscrito en el Bootcamp de Big Data
(2, 2, '2024-02-01'),  -- Alumno 2 inscrito en el Bootcamp de Ciberseguridad
(3, 3, '2024-03-15'),  -- Alumno 3 inscrito en el Bootcamp de IA
(4, 4, '2024-04-10'),  -- Alumno 4 inscrito en el Bootcamp de Java
(5, 5, '2024-05-20');  -- Alumno 5 inscrito en el Bootcamp de Blockchain

INSERT INTO Profesores_Bootcamps (profesor_id, bootcamp_id) VALUES
(1, 1),  -- Profesor 1 (Big Data) asignado al Bootcamp 1 (Big Data)
(2, 2),  -- Profesor 2 (Ciberseguridad) asignado al Bootcamp 2 (Ciberseguridad)
(3, 3),  -- Profesor 3 (IA) asignado al Bootcamp 3 (IA)
(4, 4),  -- Profesor 4 (Java) asignado al Bootcamp 4 (Java)
(5, 5);  -- Profesor 5 (Blockchain) asignado al Bootcamp 5 (Blockchain)

INSERT INTO Modulos_Profesores (modulo_id, profesor_id) VALUES
(1, 1),  -- Módulo 1 (Introducción a Big Data) asignado al Profesor 1 (Big Data)
(2, 2),  -- Módulo 2 (Seguridad en Redes) asignado al Profesor 2 (Ciberseguridad)
(3, 3),  -- Módulo 3 (Aprendizaje Automático) asignado al Profesor 3 (IA)
(4, 4),  -- Módulo 4 (Fundamentos de Java) asignado al Profesor 4 (Java)
(5, 5);  -- Módulo 5 (Smart Contracts) asignado al Profesor 5 (Blockchain)

-- Tabla Alumnos
CREATE TABLE Alumnos (
    alumno_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre CHAR(50) NOT NULL,
    apellidos CHAR(50) NOT NULL,
    email CHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

-- Tabla Bootcamps
CREATE TABLE Bootcamps (
    bootcamp_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre CHAR(50) NOT NULL,
    descripcion CHAR(50) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL
);

-- Tabla Módulos
CREATE TABLE Modulos (
    modulo_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre CHAR(50) NOT NULL,
    descripcion CHAR(50) NOT NULL,
    bootcamp_id INT NOT NULL,
    CONSTRAINT fk_bootcamp
        FOREIGN KEY (bootcamp_id)
        REFERENCES Bootcamps (bootcamp_id)
        ON DELETE CASCADE
);

-- Tabla Profesores
CREATE TABLE Profesores (
    profesor_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre CHAR(50) NOT NULL,
    apellidos CHAR(50) NOT NULL,
    email CHAR(50) NOT NULL,
    especialidad CHAR(50) NOT NULL
);

-- Tabla Inscripciones (relación Alumnos-Bootcamps)
CREATE TABLE Inscripciones (
    inscripcion_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    alumno_id INT NOT NULL,
    bootcamp_id INT NOT NULL,
    fecha_inscripcion DATE NOT NULL,
    CONSTRAINT fk_alumno
        FOREIGN KEY (alumno_id)
        REFERENCES Alumnos (alumno_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_bootcamp_inscripcion
        FOREIGN KEY (bootcamp_id)
        REFERENCES Bootcamps (bootcamp_id)
        ON DELETE CASCADE
);

-- Tabla Profesores_Bootcamps (relación Profesores-Bootcamps)
CREATE TABLE Profesores_Bootcamps (
    profesores_bootcamps_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    profesor_id INT NOT NULL,
    bootcamp_id INT NOT NULL,
    CONSTRAINT fk_profesor
        FOREIGN KEY (profesor_id)
        REFERENCES Profesores (profesor_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_bootcamp_profesor
        FOREIGN KEY (bootcamp_id)
        REFERENCES Bootcamps (bootcamp_id)
        ON DELETE CASCADE
);

-- Tabla Modulos_Profesores (relación Profesores-Módulos)
CREATE TABLE Modulos_Profesores (
    modulos_profesores_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    modulo_id INT NOT NULL,
    profesor_id INT NOT NULL,
    CONSTRAINT fk_modulo
        FOREIGN KEY (modulo_id)
        REFERENCES Modulos (modulo_id)
        ON DELETE CASCADE,
    CONSTRAINT fk_profesor_modulo
        FOREIGN KEY (profesor_id)
        REFERENCES Profesores (profesor_id)
        ON DELETE CASCADE
);