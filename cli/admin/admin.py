from db import database

class Admin:
    def __init__(self, id, name, date_of_joining, salary, email, phone, passwd) -> None:
        self.id = id
        self.name = name
        self.date_of_joining = date_of_joining
        self.salary = salary
        self.email = email
        self.phone = phone
        self.passwd = passwd

    @classmethod
    def get_admin(cls, email):
        database.cursor.execute(f"""
                SELECT employeeID, `name`, date_of_joining, salary, email, phone, passwd
                FROM employees
                WHERE email='{email}';
                """)
        
        record = database.cursor.fetchone()
        if not record: return None
        else:
            return cls(*record)
    
    @classmethod
    def authenticate_admin(cls, email, passwd):
        admin = cls.get_admin(email)

        if admin == None: return "not found"
        elif admin.passwd != passwd: return "password"
        else: return admin