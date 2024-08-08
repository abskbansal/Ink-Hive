from db import database

class Author:
    def __init__(self, id, name, phone, email) -> None:
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email

    def __eq__(self, __value: object) -> bool:
        return self.id == __value.id
    
    def __repr__(self) -> str:
        return self.name
    
    @staticmethod
    def get_all_authors():
        database.cursor.execute('SELECT * FROM authors;')
        rows = database.cursor.fetchall()
        return [Author(*row) for row in rows]
