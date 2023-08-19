pip install mysql-connector-python
import mysql.connector as msql
conexion = msql.connect(host="localhost", #conexión local
    user="root", #por defecto root
    passwd="password",
    db="dataBase")

cursor = conexion.cursor()
conexion.commit()
conexion.rollback()
