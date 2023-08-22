import pandas as pd
import mysql.connector as msql

conexion = msql.connect(host="localhost", #conexión local
    user="root", #por defecto root
    passwd="admin",
    db="Curina")

cursor = conexion.cursor()

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
    print(f"Ingrese los datos para la tabla {tabla}")
    datos = {}
    for columna in columnas:
        datos[columna] = input(f"Ingrese {columna}: ")
    return datos

def actualizar_registro(tabla):
    if tabla in tablas:
        id_registro = input("Ingrese el ID del registro que desea actualizar: ")
        if not id_registro.isdigit():
            print("El ID debe ser un número válido.")
            return
        
        columnas = tablas_columnas[tabla]
        
        # Obtener información del registro existente
        select_query = f"SELECT * FROM {tabla} WHERE ID = {id_registro};"
        cursor.execute(select_query)
        registro_actual = cursor.fetchone()
        
        if not registro_actual:
            print("No se encontró un registro con el ID proporcionado.")
            return
        
        print(f"Valores del registro con ID {id_registro}:")
        for col, val in zip(columnas, registro_actual):
            print(f"{col}: {val}")
        
        nuevos_datos = {}
        for columna in columnas:
            if columna != "ID":
                if columna in tablas_columnas[tabla]:
                    if columna in tablas:
                        print(f"No puede actualizar la clave foránea '{columna}'.")
                    else:
                        nuevos_datos[columna] = input(f"Ingrese nuevo valor para {columna}: ")
        
        try:
            set_vals = ", ".join([f"{col} = '{val}'" for col, val in nuevos_datos.items()])
            query = f"UPDATE {tabla} SET {set_vals} WHERE ID = {id_registro};"
            cursor.execute(query)
            conexion.commit()
            print("Registro actualizado exitosamente.")
        except Exception as e:
            print("Error:", e)
    else:
        print("La tabla ingresada no existe en la base de datos.")


def eliminar_registro(tabla, id_registro):
    try:
        if tabla in tablas:
            columnas = tablas_columnas[tabla]
            if "ID" in columnas:
                id_column_index = columnas.index("ID")
                id_column_name = columnas[id_column_index]
                id_column_value = id_registro
                
                # Verificar si hay restricciones de clave foránea
                for otra_tabla, columnas_otra_tabla in tablas_columnas.items():
                    if id_column_name in columnas_otra_tabla and otra_tabla != tabla:
                        foreign_key_column_index = columnas_otra_tabla.index(id_column_name)
                        foreign_key_column_name = columnas_otra_tabla[foreign_key_column_index]
                        foreign_key_table = otra_tabla
                        
                        query_foreign_key = f"SELECT COUNT(*) FROM {foreign_key_table} WHERE {foreign_key_column_name} = {id_column_value};"
                        cursor.execute(query_foreign_key)
                        count = cursor.fetchone()[0]
                        
                        if count > 0:
                            print(f"No se puede eliminar el registro ya que existe una referencia en la tabla {foreign_key_table}.")
                            return
            
            query = f"DELETE FROM {tabla} WHERE ID = {id_registro};"
            cursor.execute(query)
            conexion.commit()
            print("Registro eliminado exitosamente.")
        else:
            print("Tabla no encontrada.")
    except Exception as e:



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
            
            column_names = ", ".join(columnas)
            values = ", ".join([f"'{valor}'" for valor in datos_ingresados.values()])
            insert_query = f"INSERT INTO {tabla_insertar} ({column_names}) VALUES ({values})"           
            cursor.execute(insert_query)
            conexion.commit()        
            print("Datos ingresados correctamente.")
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
        print("Error:", e)
