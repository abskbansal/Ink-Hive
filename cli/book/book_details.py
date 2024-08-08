from db import database
from book import Book
from author import Author
from publication import Publication
from supplier import Supplier

class BookDetails:
    def __init__(self, book: Book, authors: list[Author], publication: Publication, supplier: Supplier) -> None:
        self.book = book
        self.publication = publication
        self.authors = authors
        self.supplier = supplier

    def __eq__(self, __value: object) -> bool:
        return self.book == __value.book

    @classmethod
    def get_book_details(cls, id):
        database.cursor.execute(
f'''
SELECT
    b.bookID, b.name, b.genre, b.price, b.year_of_publishing, b.qty,
    aw.*,
    p.*,
    s.*
FROM books AS b 
INNER JOIN written_by   AS w  ON        w.bookID = b.bookID 
INNER JOIN authors      AS aw ON      w.authorID = aw.authorID 
INNER JOIN publications AS p  ON p.publicationID = b.publicationID 
INNER JOIN suppliers    AS s  ON    s.supplierID = b.supplierID 
WHERE b.bookID={id};
'''
        )

        records = database.cursor.fetchall()
        if len(records) == 0:
            return None
        
        book = Book(*(records[0][:6]))
        authors = []
        publication = Publication(*records[0][10:13])
        supplier = Supplier(*records[0][13:])

        for record in records:
            author = Author(*(record[6:10]))
            if (author not in authors): authors.append(author)

        return cls(book, authors, publication, supplier)
