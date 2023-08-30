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
insert into Cliente Values ("cris@gmail.com","Cristhian","Ecuador","Guayaquil","098585565");
insert into Cliente Values ("daniel@gmail.com","Daniel","USA","Boston","099541222");
insert into Cliente Values ("jose@gmail.com","Jose","Canada","Toronto","098563785");
insert into Cliente Values ("jhon@gmail.com","Jhon","USA","New York","0999987514");
insert into Cliente Values ("nelson@gmail.com","Nelson","USA","New Jersey","098886547");
insert into Cliente Values ("andres@gmail.com","Andres","Canada","Toronto","0989896357");
insert into Cliente Values ("rolando@gmail.com","Rolando","USA","Orlando","098787854");
insert into Cliente Values ("kevin@gmail.com","Kevin","Canada","Ottowa","096969694");
insert into Cliente Values ("ari@gmail.com","Ariana","USA","Miami","095151523");
insert into Cliente Values ("kelly@gmail.com","Kelly","USA","Boston","094545417");

insert into Repartidor values ("098564269712","Bianca","bianca@gmail.com","085525121212","FedEX");
insert into Repartidor values ("096969898985","Daniela","daniela@gmail.com","098552524141","Servientrega");
insert into Repartidor values ("045212126321","Brian","brian@gmail.com","097878748563","FedEX");
insert into Repartidor values ("022121478951","Lizbeth","liz@gmail.com","098585852102","Servientrega");
insert into Repartidor values ("0923454747474","Leonel","leo@gmail.com","098753621547","Servientrega");
insert into Repartidor values ("093236312451","Piero","piero@gmail.com","098745114141","FedEX");
insert into Repartidor values ("089877477751","Walter","walter@gmail.com","098989665677","Servientrega");
insert into Repartidor values ("093333558874","Stalin","stalin@gmail.com","098898897741","FedEX");
insert into Repartidor values ("084474444512","Patricia","patricia@gmail.com","096323210210","FedEX");
insert into Repartidor values ("099966558784","Aida","aida@gmail.com","090088004512","Servientrega");

insert into Artista values ("jluis@gmail.com","Juanse","095565555221",2000,"USA");
insert into Artista values ("ddani@gmail.com","Danilo","098852213211",1992,"Argentina");
insert into Artista values ("denisse@gmail.com","Denisse","096632120101",1993,"USA");
insert into Artista values ("javier@gmail.com","Javier","039962141101",1985,"Argentina");
insert into Artista values ("lucas@gmail.com","Lucas","095210012544",1990,"USA");
insert into Artista values ("lorenzo@gmail.com","Lorenzo","096333224457",1999,"USA");
insert into Artista values ("gabo@gmail.com","Gabo","099885522310",1985,"USA");
insert into Artista values ("joaquin@gmail.com","Joaquin","069531224517",1980,"Argentina");
insert into Artista values ("james@gmail.com","James","099988522001",1980,"USA");
insert into Artista values ("mauricio@gmail.com","Mauricio","090001102354",1992,"Ecuador");

insert into Obra_Arte values("1234","El grito","Dibujo","Retrato","Minimo","Medio","Frio","Purpura","ddani@gmail.com","Alquiler",250);
insert into Obra_Arte values("2513","El cambio","Collage","Retrato","Abstracto","Pequeño","Neutral","Rojo","gabo@gmail.com","Alquiler",220);
insert into Obra_Arte values("7894","El flujo","Cuadro","Cuadrado","Naturaleza","Medio","Frio","Verde","mauricio@gmail.com","Compra",100);
insert into Obra_Arte values("9630","El dios","Fotografia","Paisaje","Abstracto","Pequeño","Neutral","Purpura","ddani@gmail.com","Alquiler",320);
insert into Obra_Arte values("8520","El demonio","Dibujo","Cuadrado","Naturaleza","Pequeño","Frio","Rojo","joaquin@gmail.com","Compra",140);
insert into Obra_Arte values("7410","El avance","Dibujo","Retrato","Minimo","Grande","Calido","Verde","denisse@gmail.com","Compra",110);
insert into Obra_Arte values("0264","El jefe","Textil","Paisaje","Abstracto","Pequeño","Frio","Rojo","lorenzo@gmail.com","Compra",90);
insert into Obra_Arte values("1257","El progreso","Dibujo","Cuadrado","Naturaleza","Grande","Neutral","Purpura","mauricio@gmail.com","Compra",50);
insert into Obra_Arte values("9999","El retraso","Textil","Paisaje","Abstracto","Pequeño","Calido","Rojo","lucas@gmail.com","Alquiler",220);
insert into Obra_Arte values("0021","Luz","Textil","Cuadrado","Abstracto","Grande","Calido","Verde","mauricio@gmail.com","Compra",400);

insert into Envio values("444","098564269712",false,"Cdla Mallorca","1234");
insert into Envio values("123","096969898985",false,"Cdla Milan","2513");
insert into Envio values("147","045212126321",false,"Cdla Milan","7894");
insert into Envio values("852","022121478951",false,"Cdla Napoli","9630");
insert into Envio values("963","0923454747474",false,"Cdla Milan","8520");
insert into Envio values("456","089877477751",false,"Cdla Napoli","7410");
insert into Envio values("789","093333558874",false,"Cdla Milan","0264");
insert into Envio values("111","084474444512",false,"Cdla Mallorca","1257");
insert into Envio values("020","084474444512",false,"Cdla Napoli","9999");
insert into Envio values("010","099966558784",false,"Cdla Milan","0021");

insert into Tipo_transaccion values ("11",200,150,"Envio Rapido","cris@gmail.com","Es Alquiler","null");
insert into Tipo_transaccion values ("22",120,152,"Envio Rapido","daniel@gmail.com","Es Alquiler","null");
insert into Tipo_transaccion values ("33",200,220,"Envio Moderado","jose@gmail.com","null","Es compra");
insert into Tipo_transaccion values ("44",140,162,"Envio Rapido","jhon@gmail.com","Es Alquiler","null");
insert into Tipo_transaccion values ("55",110,185,"Envio Moderado","nelson@gmail.com","null","Es compra");
insert into Tipo_transaccion values ("66",130,200,"Envio Moderado","andres@gmail.com","Es Alquiler","null");
insert into Tipo_transaccion values ("77",170,180,"Envio Rapido","rolando@gmail.com","Es Alquiler","null");
insert into Tipo_transaccion values ("88",300,150,"Envio Moderado","kevin@gmail.com","null","Es compra");
insert into Tipo_transaccion values ("99",144,200,"Envio Rapido","ari@gmail.com","Es Alquiler","null");
insert into Tipo_transaccion values ("00",120,147,"Envio Moderado","kelly@gmail.com","Es Alquiler","null");

insert into Pago values ("555",150,200,"11","1234");
insert into Pago values ("200",152,120,"22","2513");
insert into Pago values ("141",220,200,"33","7894");
insert into Pago values ("111",162,140,"44","9630");
insert into Pago values ("222",185,110,"55","8520");
insert into Pago values ("325",200,130,"66","7410");
insert into Pago values ("225",180,170,"77","0264");
insert into Pago values ("888",150,300,"88","1257");
insert into Pago values ("999",200,144,"99","9999");
insert into Pago values ("001",147,120,"00","0021");


SELECT c.Nombre AS Nombre_Cliente, a.Nombre AS Nombre_Artista, o.Nombre AS Nombre_Obra_Arte
FROM Cliente c
INNER JOIN Tipo_transaccion t ON c.Correo = t.ID_Cliente
INNER JOIN Pago p ON t.ID = p.NumTransaccion
INNER JOIN Obra_arte o ON p.ID_ObraArte = o.ID
INNER JOIN Artista a ON o.ID_Artista = a.Correo
WHERE a.Año_nacimiento >= 1990;

SELECT o.Paleta, COUNT(o.Paleta) AS Cantidad_Veces_Comprada, c.Nombre AS Nombre_Cliente
FROM Obra_arte o
INNER JOIN Pago p ON o.ID = p.ID_ObraArte
INNER JOIN Tipo_transaccion t ON p.NumTransaccion = t.ID
INNER JOIN Cliente c ON t.ID_Cliente = c.Correo
GROUP BY o.Paleta, c.Nombre
ORDER BY Cantidad_Veces_Comprada DESC
LIMIT 1;

SELECT e.ID, r.Nombre AS Nombre_Repartidor, e.Direccion
FROM Envio e
LEFT JOIN Repartidor r ON e.Repartidor = r.ID;

SELECT t.ID AS Pedido_ID, t.Total AS Monto_total, t.ID_Cliente, p.ID AS Pago_ID, p.Monto_total, p.NumTransaccion, p.ID_ObraArte 
FROM Tipo_transaccion t 
INNER JOIN Pago p ON t.ID = p.NumTransaccion 
WHERE t.ID = '99';

SELECT a.Nombre AS Nombre_Artista, COUNT(p.ID_ObraArte) AS Total_Obras_Vendidas
FROM Artista a
LEFT JOIN Obra_arte o ON a.Correo = o.ID_Artista
LEFT JOIN Pago p ON o.ID = p.ID_ObraArte
GROUP BY a.Nombre
HAVING COUNT(p.ID_ObraArte) > 0
ORDER BY Total_Obras_Vendidas DESC;


----- 2 triggers -----
Delimiter /
create trigger actualizar_monto_total
after insert on Pago
for each row
begin
    update Tipo_transaccion
    set Monto_total = Monto_total + new.Precio
    where Tipo_transaccion.ID = new.NumTransaccion;
end /
Delimiter;

Delimiter |
create trigger eliminar_obra
before insert on tipo_transaccion.ID
for each row
begin 
Delete from obra_arte where pago.NumTransaccion=(new.valor)  and pago.ID_ObraArte=obra_arte.ID;
End;
| 

    -- 4 reportes 
create view total_compras_cliente as 
select c.Nombre,c.Pais, sum(tt.total)
from tipo_transaccion as tt join cliente as c on c.correo=tt.ID_Cliente
Group by tt.ID_cliente;

create view pintura_comprada_cliente as
select c.Correo, c.Nombre, oa.Nombre as Pintura
from ((tipo_transaccion as tt join pago as p on tt.ID=p.NumTransaccion) join obra_arte as oa on p.ID_ObraArte=oa.ID) join cliente as c on c.Correo=tt.ID_Cliente
where tt.ID =p.NumTransaccion and oa.Opcion like "Compra";

create view pinturas_disponibles as
select Nombre as Pintura, Opcion 
from obra_arte as oa join pago as p on oa.ID=p.ID_ObraArte
where p.NumTransaccion like "null";

create view pintura_alquilada_cliente as 
select c.Correo, c.Nombre, oa.Nombre as Pintura
from ((tipo_transaccion as tt join pago as p on tt.ID=p.NumTransaccion) join obra_arte as oa on p.ID_ObraArte=oa.ID) join cliente as c on c.Correo=tt.ID_Cliente
where tt.ID =p.NumTransaccion and oa.Opcion like "Alquiler";



----- SP ----- 
DELIMITER //
CREATE PROCEDURE InsertarCliente(
    IN p_Correo varchar(30),
    IN p_Nombre varchar(30),
    IN p_Pais varchar(30),
    IN p_Ciudad varchar(30),
    IN p_Telefono varchar(30)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error en la inserción de Cliente';
    END;
    START TRANSACTION;
    INSERT INTO Cliente (Correo, Nombre, Pais, Ciudad, Telefono)
    VALUES (p_Correo, p_Nombre, p_Pais, p_Ciudad, p_Telefono);

    COMMIT;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE ActualizarCliente(
    IN p_Correo varchar(30),
    IN p_Nombre varchar(30),
    IN p_Pais varchar(30),
    IN p_Ciudad varchar(30),
    IN p_Telefono varchar(30)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error en la actualización de Cliente';
    END;
    START TRANSACTION;
    UPDATE Cliente
    SET Nombre = p_Nombre, Pais = p_Pais, Ciudad = p_Ciudad, Telefono = p_Telefono
    WHERE Correo = p_Correo;

    COMMIT;
END //
DELIMITER ;



DELIMITER //
CREATE PROCEDURE EliminarRepartidor(
    IN p_ID varchar(30)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error en la eliminación de Repartidor';
    END;
    START TRANSACTION;
    DELETE FROM Repartidor
    WHERE ID = p_ID;
    COMMIT;
END //
DELIMITER ;

-- Añadir por lo menos 5 usuarios 
create user "Artista1" identified by "12345";
Grant Insert,Delete, Update on curina.obra_arte to "Artista1";
Grant Delete,Insert, Update on curina.artista to "Artista1";

create user "Repartidor1" identified by "1111";
Grant Insert,Delete,Update on curina.repartidor to "Repartidor1";

create user "Cliente1" identified by "2222";
Grant Insert,Delete,update on curina.cliente to "Cliente1";
Grant Select on curina.obra_arte to "Cliente1";


create user "Administrador" identified by "3333";
Grant all privileges on curina.* to "Admin" with grant option;

create user "contador" identified by "4444";
Grant Select on curina.* to "contador";

-- Debe existir por lo menos 2 permisos a vistas
Grant references on curina.pinturas_disponibles to "Cliente1";
Grant references on curina.total_compras_cliente to "contador";

-- Debe existir por lo menos 5 indices
CREATE UNIQUE INDEX indice_nombre ON Cliente (Nombre) USING BTREE ;

CREATE UNIQUE INDEX indice_correo ON Repartidor (Correo) USING BTREE;

CREATE UNIQUE INDEX indice_telefono ON Artista (Telefono) USING BTREE;

CREATE UNIQUE INDEX indice_estilo ON Obra_arte (Estilo) USING BTREE;

CREATE UNIQUE INDEX indice_instalación ON Envio (Instalacion) USING BTREE;
