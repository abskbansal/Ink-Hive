def red(s: str) -> str:
    return "\33[31m" + s + "\33[0m"

def green(s: str) -> str:
    return "\33[32m" + s + "\33[0m"

def blue(s: str) -> str:
    return "\33[34m" + s + "\33[0m"

if __name__ == "__main__":
    print(red("hello"))
    print(green("hello"))
    print(blue("hello"))