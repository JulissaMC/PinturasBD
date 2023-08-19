create database Curina;
use Curina;

create table Cliente(
Correo varchar (30)  PRIMARY KEY Not null,
Nombre varchar(30)  NOT NULL,
Pais varchar (30)  NOT NULL,
Ciudad varchar(30)  NOT NULL,
Telefono varchar(30)  NOT NULL
);

create table Repartidor(
ID varchar (30) PRIMARY KEY NOT NULL,
Nombre varchar(30)  NOT NULL,
Correo varchar(30)  UNIQUE,
Telefono varchar(30)  NOT NULL,
Paqueteria varchar(30)  NOT NULL
);

create table Artista(
Correo varchar(30) PRIMARY KEY NOT NULL,
Nombre varchar(30)  UNIQUE,
Telefono varchar(30)  NOT NULL,
Año_nacimiento int  NOT NULL,
Pais varchar(30)  NOT NULL
);

create table Obra_arte(
ID varchar(30) PRIMARY KEY NOT NULL,
Nombre varchar(30)  NOT NULL,
Medio varchar(30)  NOT NULL,
Orientacion varchar(30)  NOT NULL,
Estilo varchar(30)  NOT NULL,
Tamaño varchar(30)  NOT NULL,
Paleta varchar(30)  NOT NULL,
Color varchar(30)  NOT NULL,
ID_Artista varchar(30)  NOT NULL,
Opcion varchar(30)  NOT NULL,
Precio int  NOT NULL,
FOREIGN KEY (ID_Artista) references Artista(Correo)
);

create table Envio(
ID varchar(30) PRIMARY KEY NOT NULL,
Repartidor varchar(30)  NOT NULL,
Instalacion boolean,
Direccion varchar(30)  NOT NULL,
ID_Arte varchar(30)  NOT NULL,
foreign key (Repartidor) references Repartidor(ID),
foreign key (ID_Arte) references Obra_Arte(ID)
);

create table Tipo_transaccion(
ID varchar(30) PRIMARY KEY NOT NULL,
Total int  NOT NULL,
Precio int  NOT NULL,
Nota varchar(200)  NOT NULL,
ID_Cliente varchar(30)  NOT NULL,
Es_Alquiler varchar(30)  default null,
Es_Compra varchar(30)  default null,
foreign key (ID_Cliente) references Cliente(Correo)
);

create table Pago(
ID varchar(30) PRIMARY KEY NOT NULL,
Precio int  not null,
Monto_total int NOT NULL,
NumTransaccion varchar(30)  NOT NULL,
ID_ObraArte varchar(30)  NOT NULL,
foreign key (NumTransaccion) references Tipo_transaccion(ID),
foreign key (ID_ObraArte) references Obra_Arte(ID)
);
