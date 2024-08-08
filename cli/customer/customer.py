from db import database
from datetime import datetime
from cart import Cart

class Customer:
    def __init__(self, id: int, name: str, phone: int, email: str, status: str, passwd: str, attempts: int, cart: Cart | None) -> None:
        self.id = id
        self.name = name
        self.phone = phone
        self.email = email
        self.status = status
        self.passwd = passwd
        self.attempts = attempts
        self.cart = cart

    def decrease_attempt(self):
        self.attempts -= 1
        database.cursor.execute(f"UPDATE customers SET attempts_left={self.attempts} WHERE customerID={self.id};")
        database.connection.commit()

    def reset_attempts(self):
        self.attempts = 3
        database.cursor.execute(f"UPDATE customers SET attempts_left={self.attempts}, `status`='active', block_time=NULL WHERE customerID={self.id};")
        database.connection.commit()

    def add_to_cart(self, book: int, qty: int):
        self.cart.add(book, qty)

    def order_cart(self, amount: int):
        books = self.cart.books

        database.cursor.execute(f"""
                                INSERT INTO orders 
                                (amount, date_of_order, customerID, payment_method, shipperID, `status`) 
                                VALUES 
                                ({amount}, CURDATE(), {self.id}, 'Cash', 1, 'Pending');
                                """)
        database.connection.commit()

        orderID = database.cursor.lastrowid
        for bookID, qty in books.items():
            database.cursor.execute(f"UPDATE books SET qty=qty-{qty} WHERE bookID={bookID};")
            database.cursor.execute(f"INSERT INTO contains(orderID, bookID, no_of_copies) VALUES ({orderID}, {bookID}, {qty});")
            database.connection.commit()

        self.cart.empty_cart()

    def remove_item(self, bookID: int, qty: int) -> bool:
        removed = self.cart.remove(bookID, qty)
        if (removed and self.cart.is_empty()):
            self.cart = None
        return removed
        
    @classmethod
    def get_customer(cls, email):
        database.cursor.execute(f"""
                       SELECT customerID, `name`, phone, email, `status`, passwd, attempts_left
                       FROM customers
                       WHERE email='{email}';
                       """)
        record = database.cursor.fetchone()
        if not record: return None
        else:
            customerID = record[0]
            database.cursor.execute(f"SELECT bookID, qty FROM carts WHERE customerID={customerID};")
            records = database.cursor.fetchall()
            books = {}
            for _record in records:
                books[_record[0]] = books.get(_record[0], 0) + _record[1]
            return cls(*record, Cart(customerID, books))
    
    @classmethod
    def authenticate_customer(cls, email, passwd):
        customer = cls.get_customer(email)

        if customer == None:
            return "not found"
        elif customer.status == 'blocked':
            database.cursor.execute(f"SELECT block_time FROM customers WHERE customerID={customer.id};")
            bt = database.cursor.fetchone()[0]
            now = datetime.now()
            diff = (now-bt).seconds // 60
            if diff >= 10:
                if customer.passwd == passwd:
                    customer.reset_attempts()
                    return customer
                else: return "password"
            else: return "blocked"
        elif customer.passwd != passwd:
            customer.decrease_attempt()
            return "password"
        else:
            customer.reset_attempts()
            return customer
        
    @staticmethod
    def add_customer(name, phone, email, password):
        customer = Customer.get_customer(email)
        if customer: return False

        database.cursor.execute(f"""INSERT INTO customers (name, phone, email, passwd) VALUES ('{name}', {phone}, '{email}', '{password}');""")
        database.connection.commit()
        return True

    @staticmethod
    def get_customer_logistics():
        database.cursor.execute(
            """
            SELECT c.customerID, c.name, x.order_count, x.total_amount
            FROM customers AS c
            INNER JOIN (
                SELECT customerID, SUM(o.amount) AS total_amount, COUNT(*) AS order_count
                FROM orders AS o
                GROUP BY customerID
            ) AS x ON c.customerID = x.customerID;
            """
        )
        records = database.cursor.fetchall()
        return records;