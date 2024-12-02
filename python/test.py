# Muatable data types
mydict = { i: i**2  for i in range(1,10)}
print(mydict)

mylist = [i for i in range(1,10)]
print(mylist)

#Immutable data types

mytuple =(i for i in range(10,20))

print(mytuple)


with open('file.txt', 'w') as file:
    file.write('TEST')

# Decorators

def my_decorator(func):
    def wrapper():
        print("Before func")
        func()
        print("After func")
    return wrapper

@my_decorator
def sayTest():
    print("Hi Test")

sayTest()

class fileManager:
    def __init__(self, filename, mode):
        self.filename = filename
        self.mode = mode
    def __enter__(self):
        self.file = open(self.filename, self.mode)
        return self.file
    def __exit__(self, exec_type, exec_value, traceback):
        self.file.close()

with fileManager('testManage.txt', 'w') as f:
    f.write('Hello World!')


def replaceString(word, change):
    result = ''
    for i in text:
        if i == ' ':
            i = change
        result += i
    return result


text = "D t C mpBl ckFrid yS le"
ch = "a"

print(replaceString(text, ch))


str = "Hello World"
# for i in range(0, len(str)):
#     print(str[i])

print(str[0:-5:1])
print(str.count('l'))
# print(str[::-2])

def remove_dup(str):
    return ''.join(sorted(set(str), key=str.index))

print(remove_dup(str))

testset1 = ("green", "yellow")

(apple, mango) = testset1

print(apple)
