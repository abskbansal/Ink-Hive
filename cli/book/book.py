from db import database

class Book:
    def __init__(self, id, name, genre, price, year, qty) -> None:
        self.id = id
        self.name = name
        self.genre = genre
        self.price = price
        self.year = year
        self.qty = qty

    def __eq__(self, __value: object) -> bool:
        return self.id == __value.id
    
    def __repr__(self) -> str:
        return self.name

    @staticmethod
    def get_all_books():
        database.cursor.execute('SELECT bookID, name, genre, price, year_of_publishing, qty FROM books;')
        rows = database.cursor.fetchall()
        return [Book(*row) for row in rows]
    
    @classmethod
    def get_one_book(cls, id):
        database.cursor.execute(f'SELECT bookID, name, genre, price, year_of_publishing, qty FROM books WHERE bookID={id};')
        row = database.cursor.fetchone()
        return Book(*row)

    @staticmethod
    def get_book_logistics():
        database.cursor.execute(
            """
            SELECT 
                b.bookID, b.name,
                COALESCE(SUM(cont.no_of_copies), 0) AS total_copies_sold,
                COALESCE(SUM(c.qty), 0) AS copies_in_cart
            FROM books b
            LEFT JOIN contains cont ON b.bookID = cont.bookID
            LEFT JOIN `orders` o ON cont.orderID = o.orderID
            LEFT JOIN carts c ON b.bookID = c.bookID
            GROUP BY b.bookID, b.name;
            """
        )
        records = database.cursor.fetchall()
        return records