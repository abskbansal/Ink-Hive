from db import database

class Cart:
    def __init__(self, customerID: int, books: dict[int, int]) -> None:
        self.customerID = customerID
        self.books = books

    def __eq__(self, __value: object) -> bool:
        return self.customerID == __value.customerID
    
    def __len__(self):
        return len(self.books)
    
    def add(self, book: int, qty: int) -> None:
        if book in self.books:
            self.books[book] = self.books[book] + qty
            database.cursor.execute(f"UPDATE carts SET qty={self.books[book]} WHERE customerID={self.customerID} AND bookID={book};")
            database.connection.commit()
        else:
            self.books[book] = qty
            database.cursor.execute(f"INSERT INTO carts (customerID, bookID, qty) VALUES ({self.customerID}, {book}, {qty});")
            database.connection.commit()

    def remove(self, book: int, qty: int):
        if book not in self.books:
            return False
        elif self.books[book] > qty:
            self.books[book] = self.books[book] - qty
            database.cursor.execute(f"UPDATE carts SET qty={self.books[book]} WHERE customerID={self.customerID} AND bookID={book};")
            database.connection.commit()
        else:
            del self.books[book]
            database.cursor.execute(f"DELETE FROM carts WHERE customerID={self.customerID} AND bookID={book};")
            database.connection.commit()

        return True

    def is_empty(self):
        return len(self.books) == 0

    def empty_cart(self):
        database.cursor.execute(f"DELETE FROM carts WHERE customerID={self.customerID};")
        database.connection.commit()

        self.books = {}