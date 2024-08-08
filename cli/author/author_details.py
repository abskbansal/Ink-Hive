from db import database
from book import Book
from author import Author

class AuthorDetails:
    def __init__(self, author: Author, books_written: list[Book], books_reviewed: list[Book]) -> None:
        self.author = author
        self.written = books_written
        self.reviewed = books_reviewed

    def __eq__(self, __value: object) -> bool:
        return self.author == __value.author
    
    @classmethod
    def get_author_details(cls, id):
        database.cursor.execute(
            f'''
SELECT a.*, bw.bookID, br.bookID
FROM author AS a
INNER JOIN written_by  AS w  ON w.authorID = a.authorID
INNER JOIN books       AS bw ON  bw.bookID = w.bookID
INNER JOIN reviewed_by AS r  ON r.authorID = a.authorID
INNER JOIN books       AS br ON  br.bookID = r.bookID
WHERE a.authorID={id};
'''
        )

        rows = database.cursor.fetchall()

        if (len(rows) == 0): return None
        author = Author(*(rows[0][:4]))
        written = []
        reviewed = []

        for row in rows:
            w, r = Book.get_one_book(row[4]), Book.get_one_book(row[5])
            if (w not in written): written.append(w)
            if (r not in reviewed): reviewed.append(r)

        return cls(author, written, reviewed)
