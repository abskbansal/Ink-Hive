import mysql.connector as connector

class Database:
    def __init__(self, database, host='localhost', user='root', password='admin') -> None:
        self.connection = connector.connect(
            host=host,
            user=user,
            password=password,
            database=database
        )

        self.cursor = self.connection.cursor()

    def setup(self):
        self.cursor.execute('source C:/Users/Abhishek/Desktop/Programming/Python/DBMS/cli/db/initialize_db.sql;')
        self.connection.commit()

database = Database('dbms_proj')