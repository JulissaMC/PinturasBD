import pandas as pd
import mysql.connector as msql

"""conexion = msql.connect(host="localhost", #conexión local
    user="root", #por defecto root
    passwd="admin",
    db="Curina")"""


conexion = msql.connect(user="janmcort", password="Administrador1@", 
                              host="pinturas.mysql.database.azure.com", port=3306, 
                              database="Curina", ssl_ca="DigiCertGlobalRootCA.crt.pem.", ssl_disabled=False)



cursor = conexion.cursor()

sp_insertar_cliente = "InsertarCliente"
sp_actualizar_cliente = "ActualizarCliente"
sp_eliminar_repartidor = "EliminarRepartidor"

tablas = ["Cliente","Repartidor","Artista","Obra_arte","Envio","Tipo_transaccion","Pago"]

tablas_columnas = {"Cliente":["Correo", "Nombre", "Pais", "Ciudad", "Telefono"],
                   "Repartidor":["ID", "Nombre", "Correo", "Telefono", "Paqueteria"],
                 "Artista":["Correo", "Nombre", "Telefono", "Año_nacimiento", "Pais"], 
                 "Obra_arte":["ID", "Nombre", "Medio", "Orientacion", "Estilo", "Tamaño", "Paleta", "Color", "ID_Artista", "Opcion", "Precio"],
                 "Envio":["ID", "Repartidor", "Instalacion", "Direccion", "ID_Arte"],
                 "Tipo_transaccion":["ID", "Total", "Precio", "Nota", "ID_Cliente", "Es_Alquiler", "Es_Compra"],
                 "Pago":["ID", "Precio", "Monto_total", "NumTransaccion", "ID_ObraArte"]}


def consulta_Tabla(tabla):
  if tabla in tablas:
    print(pd.read_sql(f"SELECT * FROM {tabla};",conexion))

def ingresar_datos_tabla(tabla, columnas):
    try:
        tabla = tabla.title()
        if tabla in tablas:
            print(f"Ingrese los datos para la tabla {tabla}")
            
            # Solicitar los valores para las columnas de la tabla
            datos = {}
            for columna in columnas:
                valor = input(f"Ingrese {columna}: ")
                datos[columna] = valor
            
            # Construir la consulta de inserción
            columnas = ", ".join(datos.keys())
            valores = ", ".join([f"'{valor}'" for valor in datos.values()])
            
            if tabla == "Cliente":
                query = f"CALL {sp_insertar_cliente}({valores});"
            else:
                query = f"INSERT INTO {tabla} ({columnas}) VALUES ({valores});"
            
            cursor.execute(query)
            conexion.commit()
            print("Datos ingresados correctamente.")
        else:
            print("Tabla no encontrada.")
    except Exception as e:
        print("Error:", e)



def actualizar_registro(tabla):
    if tabla in tablas:
        id_registro = input(f"Ingrese el ID del registro que desea actualizar en la tabla {tabla}: ")
        
        if tabla in ["Cliente", "Artista"]:
            # Verificar que el correo exista en la tabla correspondiente
            select_query = f"SELECT * FROM {tabla} WHERE Correo = '{id_registro}';"
        else:
            # Verificar que el ID sea un número válido
            select_query = f"SELECT * FROM {tabla} WHERE ID = '{id_registro}';"
            if not id_registro.isdigit():
                print("El ID debe ser un número válido.")
                return
            
            select_query = f"SELECT * FROM {tabla} WHERE ID = {id_registro};"

        cursor.execute(select_query)
        registro_actual = cursor.fetchone()
        
        if not registro_actual:
            print(f"No se encontró un registro con el ID/correo '{id_registro}' en la tabla '{tabla}'.")
            return
        
        print(f"Valores del registro con ID/correo '{id_registro}' en la tabla '{tabla}':")
        columnas = tablas_columnas[tabla]
        for col, val in zip(columnas, registro_actual):
            print(f"{col}: {val}")
        
        nuevos_datos = {}
        for columna in columnas:
            if columna != "ID" and columna != "Correo":
                if columna in tablas_columnas[tabla]:
                    if columna in tablas:
                        print(f"No puede actualizar la clave foránea '{columna}'.")
                    else:
                        nuevos_datos[columna] = input(f"Ingrese valor para {columna}: ")
        
        # Construir la consulta de actualización
        set_vals = ", ".join([f"{col} = '{val}'" for col, val in nuevos_datos.items()])
        if tabla == "Cliente":
            # Llamada al procedimiento almacenado para actualizar un cliente
            query = f"CALL {sp_actualizar_cliente}({set_vals}, '{id_registro}');"
        else:
            # Construir la consulta SQL para actualizar registros
            if tabla in ["Artista"]:
                where_clause = f"WHERE Correo = '{id_registro}'"
            else:
                where_clause = f"WHERE ID = {id_registro}"
            
            query = f"UPDATE {tabla} SET {set_vals} {where_clause};"
            
        try:
            cursor.execute(query)
            conexion.commit()
            print("Registro actualizado exitosamente.")
        except Exception as e:
            print("Error:", e)


def eliminar_registro(tabla, id_eliminar):
    tabla = tabla.title()
    try:
        if tabla in tablas:
            if tabla in ["Cliente", "Artista"]:
                id_columna_nombre = "Correo"
                id_columna_valor = f"'{id_eliminar}'"
            else:
                id_columna_index = columnas.index("ID")
                id_columna_nombre = columnas[id_columna_index]
                id_columna_valor = id_eliminar
            
            # Verificar si hay restricciones de clave foránea
            foreign_key_referencias = []
            for otra_tabla, columnas_otra_tabla in tablas_columnas.items():
                if id_columna_nombre in columnas_otra_tabla and otra_tabla != tabla:
                    foreign_key_columna_index = columnas_otra_tabla.index(id_columna_nombre)
                    foreign_key_columna_nombre = columnas_otra_tabla[foreign_key_columna_index]
                    foreign_key_tabla = otra_tabla

                    query_foreign_key = f"SELECT COUNT(*) FROM {foreign_key_tabla} WHERE {foreign_key_columna_nombre} = {id_columna_valor};"
                    cursor.execute(query_foreign_key)
                    count = cursor.fetchone()[0]

                    if count > 0:
                        foreign_key_referencias.append((foreign_key_tabla, id_columna_valor))

            if len(foreign_key_referencias) > 0:
                print(f"No se puede eliminar el registro en {tabla} debido a referencias en otras tablas:")
                for tabla_referencia, id_referencia in foreign_key_referencias:
                    print(f"Tabla: {tabla_referencia}, ID: {id_referencia}")
            else:
                # Si no hay referencias, eliminar el registro principal
                if tabla == "Repartidor":
                    query_eliminar = f"CALL {sp_eliminar_repartidor}({id_columna_valor});"
                    cursor.execute(query_eliminar)
                else:
                    query_eliminar = f"DELETE FROM {tabla} WHERE {id_columna_nombre} = {id_columna_valor};"
                    cursor.execute(query_eliminar)

                conexion.commit()
                print("Registro eliminado exitosamente.")
        else:
            print("Tabla no encontrada.")
    except Exception as e:
        print("Error:", e)


while True:
    print("1. Consultar tabla")
    print("2. Insertar datos en tabla")
    print("3. Actualizar datos en tabla")
    print("4. Eliminar datos en tabla")
    print("5. Salir")
    opcion = input("Seleccione una opción: ")

    if opcion == "1":
        tabla_consulta = input("Ingrese el nombre de la tabla a consultar: ")
        if tabla_consulta in tablas:
            consulta_query = f"SELECT * FROM {tabla_consulta};"
            df = pd.read_sql(consulta_query, conexion)
            print(df)
        else:
            print("La tabla ingresada no existe en la base de datos.")
    elif opcion == "2":
        tabla_insertar = input("Ingrese el nombre de la tabla en la que desea insertar datos: ")
        if tabla_insertar in tablas:
            columnas = tablas_columnas[tabla_insertar]
            datos_ingresados = ingresar_datos_tabla(tabla_insertar, columnas)
        else:
            print("La tabla ingresada no existe en la base de datos.")
    elif opcion == "3":
        tabla_actualizar = input("Ingrese el nombre de la tabla en la que desea actualizar datos: ")
        actualizar_registro(tabla_actualizar)
    elif opcion == "4":
        tabla_eliminar = input("Ingrese el nombre de la tabla de la que desea eliminar un registro: ")
        id_eliminar = input("Ingrese el ID del registro que desea eliminar: ")
        eliminar_registro(tabla_eliminar, id_eliminar)
    elif opcion == "5":
        break
    else:
        print("Opción no válida.")



conexion.close()      


conexion.close()        
        
