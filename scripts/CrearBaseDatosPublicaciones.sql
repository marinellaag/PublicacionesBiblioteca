--Crear la base de datos
CREATE DATABASE PublicacionesBiblioteca
GO

USE PublicacionesBiblioteca
GO

--Crear la tabla UBICACION
CREATE TABLE Ubicacion (
	Id INT IDENTITY(1, 1) NOT NULL,
	Ubicacion VARCHAR(100) NOT NULL,
	CONSTRAINT pkUbicacion_Id PRIMARY KEY(Id)
)
GO

--Crear los indices de la tabla UBICACION
CREATE UNIQUE INDEX ixUbicacion_Ubicacion
	ON Ubicacion(Ubicacion)
GO

--Crear la tabla TIPOAUTOR
CREATE TABLE TipoAutor (
	Id INT IDENTITY(1, 1) NOT NULL,
	Tipo VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoAutor_Id PRIMARY KEY(Id)
)
GO

--Crear los indices de la tabla TIPOAUTOR
CREATE UNIQUE INDEX ixTipoAutor_Tipo
	ON TipoAutor(Tipo)
GO

--Crear la tabla TIPOPUBLICACION
CREATE TABLE TipoPublicacion (
	Id INT IDENTITY(1, 1) NOT NULL,
	Tipo VARCHAR(100) NOT NULL,
	CONSTRAINT pkTipoPublicacion_Id PRIMARY KEY(Id)
)
GO

--Crear los indices de la tabla TIPOPUBLICACION
CREATE UNIQUE INDEX ixTipoPublicacion_Tipo
	ON TipoPublicacion(Tipo)
GO

--Crear la tabla DESCRIPTOR
CREATE TABLE Descriptor (
	Id INT IDENTITY(1, 1) NOT NULL,
	Descriptor VARCHAR(100) NOT NULL,
	CONSTRAINT pkDescriptor_Id PRIMARY KEY(Id)
)
GO

--Crear los indices de la tabla DESCRIPTOR
CREATE UNIQUE INDEX ixDescriptor_Descriptor
	ON Descriptor(Descriptor)
GO

--Crear la tabla EDITORIAL
CREATE TABLE Editorial (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdUbicacion INT NOT NULL,
	CONSTRAINT pkEditorial_Id PRIMARY KEY(Id),
	CONSTRAINT fkEditorial_Ubicacion FOREIGN KEY(IdUbicacion) REFERENCES Ubicacion(Id)
)
GO

--Crear los indices de la tabla EDITORIAL
CREATE UNIQUE INDEX ixEditorial_Nombre
	ON Editorial(Nombre)
GO

--Crear la tabla AUTOR
CREATE TABLE Autor (
	Id INT IDENTITY(1, 1) NOT NULL,
	Nombre VARCHAR(100) NOT NULL,
	IdTipoAutor INT NOT NULL,
	CONSTRAINT pkAutor_Id PRIMARY KEY(Id),
	CONSTRAINT fkAutor_TipoAutor FOREIGN KEY(IdTipoAutor) REFERENCES TipoAutor(Id)
)
GO

--Crear los indices de la tabla AUTOR
CREATE UNIQUE INDEX ixAutor_Nombre
	ON Autor(Nombre, IdTipoAutor)
GO

--Crear la tabla PUBLICACION
CREATE TABLE Publicacion (
	Id INT IDENTITY(1, 1) NOT NULL,
	Titulo VARCHAR(200) NOT NULL,
	Anio INT NOT NULL,
	IdTipoPublicacion INT NOT NULL,
	IdEditorial INT NOT NULL,
	CONSTRAINT pkPublicacion_Id PRIMARY KEY(Id),
	CONSTRAINT fkPublicacion_TipoPublicacion FOREIGN KEY(IdTipoPublicacion) REFERENCES TipoPublicacion(Id),
	CONSTRAINT fkPublicacion_Editorial FOREIGN KEY(IdEditorial) REFERENCES Editorial(Id)
)
GO

--Crear los indices de la tabla PUBLICACION
CREATE UNIQUE INDEX ixPublicacion_Titulo
	ON Publicacion(Titulo, Anio)
GO

--Crear la tabla VOLUMEN
CREATE TABLE Volumen (
	Id INT IDENTITY(1, 1) NOT NULL,
	Numero INT NOT NULL,
	Serie VARCHAR(50) NULL,
	IdPublicacion INT NOT NULL,
	CONSTRAINT pkVolumen_Id PRIMARY KEY(Id),
	CONSTRAINT fkVolumen_Publicacion FOREIGN KEY(IdPublicacion) REFERENCES Publicacion(Id)
)
GO

--Crear los indices de la tabla VOLUMEN
CREATE UNIQUE INDEX ixVolumen_Numero
	ON Volumen(IdPublicacion, Numero)
GO

--Crear la tabla PUBLICACION-AUTOR
CREATE TABLE PublicacionAutor (
	IdPublicacion INT NOT NULL,
	IdAutor INT NOT NULL,
	CONSTRAINT pkPublicacionAutor PRIMARY KEY (IdPublicacion, IdAutor),
	CONSTRAINT fkPublicacionAutor_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
	CONSTRAINT fkPublicacionAutor_Autor FOREIGN KEY (IdAutor) REFERENCES Autor(Id)
)
GO

--Crear la tabla PUBLICACION-DESCRIPTOR
CREATE TABLE PublicacionDescriptor (
	IdPublicacion INT NOT NULL,
	IdDescriptor INT NOT NULL,
	CONSTRAINT pkPublicacionDescriptor PRIMARY KEY (IdPublicacion, IdDescriptor),
	CONSTRAINT fkPublicacionDescriptor_Publicacion FOREIGN KEY (IdPublicacion) REFERENCES Publicacion(Id),
	CONSTRAINT fkPublicacionDescriptor_Descriptor FOREIGN KEY (IdDescriptor) REFERENCES Descriptor(Id)
)
GO
