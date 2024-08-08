from db import database

class Order:
    def __init__(self, id: int, books: dict[int, int]) -> None:
        self.id = id
        self.books = books

    @staticmethod
    def get_all_orders(customerID: int):
        database.cursor.execute(
            f"""
            SELECT o.orderID, cont.bookID, cont.no_of_copies
            FROM orders AS o
            JOIN contains AS cont ON o.orderID = cont.orderID
            WHERE o.customerID = {customerID};
            """
        )

        results = database.cursor.fetchall()
        d = {}
        for record in results:
            if record[0] in d:
                d[record[0]][record[1]] = record[2]
            else: d[record[0]] = {record[1] : record[2]} 

        orders = []
        for orderID, books in d.items():
            orders.append(Order(orderID, books))
        return orders