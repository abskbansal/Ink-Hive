class Publication:
    def __init__(self, id, name, email) -> None:
        self.id = id
        self.name = name
        self.email = email

    def __eq__(self, __value: object) -> bool:
        return self.id == __value.id
    
    def __repr__(self) -> str:
        return self.name