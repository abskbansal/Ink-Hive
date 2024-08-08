from prettytable import PrettyTable
from book import Book, BookDetails
from customer import Customer
from admin import Admin
from order import Order
from utils import *

def customer_menu(customer: Customer):
    print(green(f"\nWelcome, {customer.name}\n"))

    options = [
        "Show all books",
        "Show cart",
        "Show order history",
        "Exit"
    ]

    while True:
        for index, option in enumerate(options):
            print(f"{index+1}. {option}")
        print()

        choice = getInt("Enter your choice: ")
        if choice == 1:
            table = PrettyTable(['BookID', 'Name', "Genre", "Price", "Year", "Quantity"])
            books = Book.get_all_books()
            table.add_rows(
                [
                    [
                        book.id, 
                        book.name, 
                        book.genre, 
                        book.price, 
                        book.year, 
                        green(str(book.qty)) if book.qty > 0 else red(str(book.qty))
                    ] for book in books
                ]
            )
            print(table)
            print()
            
            ids = []
            for book in books:
                ids.append(book.id)

            max_id = max(ids)
            print(f"Enter ID of book to show details and buy OR {max_id + 1} to EXIT.")
            bookID = getInt("Enter your choice: ")

            if bookID == max_id + 1:
                continue
            elif bookID not in ids:
                print(red("Enter valid ID.\n"))
                continue
            else:
                details = BookDetails.get_book_details(bookID)
                print(f"Book ID: {details.book.id}")
                print(f"Book Name: {details.book.name}")
                print(f"Genre: {details.book.genre}")
                print(f"Price: {details.book.price}")
                print(f"Authors: {details.authors}")
                print(f"Publication: {details.publication}")
                print(f"Supplier: {details.supplier}")

                buy_or_not = getString("Do you want to add this book to your cart? (Y/N): ").lower()
                if buy_or_not =='y':
                    qty = getInt("Enter quantity: ")
                    if (qty > details.book.qty):
                        print(red("You cannot add more books than available.\n"))
                    else: customer.add_to_cart(details.book.id, qty)
                else:
                    continue

        elif choice == 2:
            total_cost = 0
            table =PrettyTable(["BookID", "Book Name", "Quantity", "Price", "Cost"])

            if customer.cart:
                for bookID, qty in customer.cart.books.items():
                    book = Book.get_one_book(bookID)
                    table.add_row([book.id, book.name, qty, book.price, book.price * qty])
                    total_cost += book.price * qty

                table.add_row(["", "", "", "Total cost: ", total_cost])

                print(f"Your Cart:")
                print(table)

                print("1. Remove item from cart")
                print("2. Buy cart")
                print("3. Exit")

                remove_or_buy = getInt("Enter your choice: ")

                if remove_or_buy == 1:
                    bookID = getInt("Enter bookID to remove from cart: ")
                    qty = getInt("Enter qty to be removed: ")

                    removed = customer.remove_item(bookID, qty);
                
                    if removed:
                        print(green("Book removed."))
                    else:
                        print(red("No book with this ID in list."))
                elif remove_or_buy == 2:
                    customer.order_cart(total_cost)
                else:
                    continue
            else:
                print(red("Your cart is empty.\n"))
                continue
            print()

        elif choice == 3:
            orders: list[Order] = Order.get_all_orders(customer.id)
            if not orders:
                print("You have not placed any orders yet.")
            else:
                for index, order in enumerate(orders):
                    print(f"Order {index+1}: ")
                    for bookID, qty in order.books.items():
                        book = Book.get_one_book(bookID)
                        print(f"\t{book.name}: {qty} copies")
            print()

        elif choice == 4:
            break

        else: print(red("Invalid Input. Please try again...\n"))

def admin_menu(admin: Admin):
    print(green(f"\nWelcome, Admin {admin.name}\n"))

    options = [
        "Show customer logistics",
        "Show book logistics",
        "Exit"
    ]

    while True:
        for index, option in enumerate(options):
            print(f"{index+1}. {option}")
        print()

        choice = getInt("Enter your choice: ")
        if choice == 1:
            table = PrettyTable(['Customer ID', 'Name', 'Orders Placed', 'Total Order Value'])
            results = Customer.get_customer_logistics()
            table.add_rows([result for result in results])

            print(table)

        elif choice == 2:
            table = PrettyTable(['Book ID', 'Name', 'Total Copies Sold', ' Copies in Carts'])
            results = Book.get_customer_logistics()
            table.add_rows([result for result in results])

            print(table)

        elif choice == 3: break
        else: print(red("Invalid Input. Please try again...\n"))

if __name__ == "__main__":
    print(green("             Welcome to INK HIVE"))

    while True:
        print("1. Login")
        print("2. Register")
        print("3. Exit")
        print()

        choice = getInt("Enter your choice: ")
        print()

        if choice == 1:
            email = getString("Enter your email: ")
            passwd = getpass(blue("Enter your password: "))

            customer = Customer.authenticate_customer(email, passwd)

            if customer == "not found":
                admin = Admin.authenticate_admin(email, passwd)
                if admin == "not found": print(red("No account found with this email.\n"))
                elif admin == "password": print(red("Wrong password.\n"))
                else: admin_menu(admin)
            elif customer == "blocked": print(red("Your account has been blocked because of many failed attempts.\n"))
            elif customer == "password": print(red("Wrong password.\n"))
            else: customer_menu(customer)

        elif choice == 2:
            name = getString("Enter your name: ")
            phone = getString("Enter your phone: ")
            email = getString("Enter your email: ")
            passwd = getPass("Enter your password: ")

            result = Customer.add_customer(name, phone, email, passwd)
            if (not result):
                print(red("Email already registered."))
            else:
                print(green("Registration Successful"))
        elif choice == 3:
            print(blue("Thank you for using INK HIVE. Hope you have a good day!"))
            break
        else:
            print(red("Invalid Input. Please try again...\n"))