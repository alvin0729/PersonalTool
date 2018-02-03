idle3 - 终端运行Python命令
1.1 在交互式环境中输入表达式
操作符  操作           例子       求值为
**     指数           2**3       8
%      取模/取余数     22 % 8     6
//     整除/商数取整   22 // 8    2
/      除法           22/8       2.75
*      乘法           3*5        15
-      减法           5-2        3
+      加法           2+2        4


1.2 整型、浮点型和字符串数据类型


1.3 字符串连接和复制
>>> 'Alice' + 'Bob'
*操作符只能用于两个数字(作为乘法)，或一个字符串和一个整型(作为字符 串复制操作符)。
>>> 'Alice' * 5

1.4 在变量中保存值
1.4.1 赋值语句

1.5 第一个程序
str()、int()和 float()函数将分别求值为传入值的字符串、整数和浮点数形式。

2.3 布尔操作符
3 个布尔操作符(and、or 和 not)用于比较布尔值。
>>> not not not not True
>>> 2 + 2 == 4 and not 2 + 2 == 5 and 2 * 2 == 2 + 2
和算术操作符一样，布尔操作符也有操作顺序。在所有算术和比较操作符求值
后， Python 先求值 not 操作符， 然后是 and 操作符， 然后是 or 操作符。


2.7 控制流语句
>>> if name == 'Alice':print('Hi, Alice.')
else:print('Hello, stranger.')

2.7.3 elif 语句
>>> if name == 'Alice':print('Hi, Alice.')
elif age < 12:print('You are not Alice, kiddo.')
elif age > 2000:print('Unlike you, Alice is not an undead, immortal vampire.')
elif age > 100:print('You are not Alice, grannie.')


2.7.4 while 循环语句
>>> spam = 0
>>> while spam < 5:
	print('Hello, world.')
	spam = spam + 1

>>> while True:
	print('Please type your name.')
	name = input()
	if name == 'your name':
		break
	print('Thank you!')


2.7.7 continue 语句
>>> while True:
        print('Who are you?')
        name = input()
        if name != 'Joe':
                continue
        print('Hello, Joe. What is the password? (It is a fish.)')
        password = input()
        if password == 'swordfish':
                break
        print('Access granted.')


2.7.8 for 循环和 range()函数
 >>> for i in range(5):
	print('Jimmy Five Times (' + str(i) + ')')
	

2.7.10 range()的开始、 停止和步长参数

>>> for i in range(12, 16):
	print(i)
12
13
14
15
>>> 
>>> for i in range(5, -1, -1):
	print(i)	
5
4
3
2
1
0
>>>


2.8 导入模块
>>> import random
>>> for i in range(5):
	print(random.randint(1, 10))
from import 语句
import 语句的另一种形式包括 from 关键字，之后是模块名称， import 关键字和
一个星号， 例如 from random import *。
使用这种形式的 import 语句，调用 random模块中的函数时不需要 random.前缀。
但是， 使用完整的名称会让代码更可读， 所以最好是使用普通形式的 import 语句。


2.9 用 sys.exit()提前结束程序
import sys
while True:
    print('Type exit to exit.')
    response = input()
    if response == 'exit':
        sys.exit()
        print('You typed ' + response + '.')


3.1 def 语句和参数
import random

def getAnswer(answerNumber):
    if answerNumber == 1:
         return 'It is certain'
    elif answerNumber == 2:
         return 'It is decidedly so'
    elif answerNumber == 3:
         return 'Yes'
    elif answerNumber == 4:
         return 'Reply hazy try again'
    elif answerNumber == 5:
         return 'Ask again later'
    elif answerNumber == 6:
         return 'Concentrate and ask again'
    elif answerNumber == 7:
         return 'My reply is no'
    elif answerNumber == 8:
         return 'Outlook not so good'
    elif answerNumber == 9:
         return 'Very doubtful'
#r = random.randint(1, 9)
#fortune = getAnswer(r)
#print(fortune)
print(getAnswer(random.randint(1, 9)))



3.3 None 值

3.4 关键字参数和 print()
print('Hello', end='')
print('---')
print('cats', 'dogs', 'mice')
print('cats', 'dogs', 'mice', sep=',')


3.5 局部和全局作用域
3.6 global 语句
def spam():
    global eggs
    eggs = 'spam'
eggs = 'global'
spam()
print(eggs)

3.7 异常处理
def spam(divideBy):
    try:
       return 42 / divideBy
    except ZeroDivisionError:
       print('Error: Invalid argument.')
print(spam(2))
print(spam(12))
print(spam(0))
print(spam(1))


# This is a guess the number game.
import random
secretNumber = random.randint(1, 20)
print('I am thinking of a number between 1 and 20.')
# Ask the player to guess 6 times.
for guessesTaken in range(1, 7):
    print('Take a guess.')
    guess = int(input())
    if guess < secretNumber:
        print('Your guess is too low.')
    elif guess > secretNumber:
        print('Your guess is too high.')
    else:
        break # This condition is the correct guess!
if guess == secretNumber:
    print('Good job! You guessed my number in ' + str(guessesTaken) + ' guesses!')
else:
    print('Nope. The number I was thinking of was ' + str(secretNumber))


4.1 列表数据类型
[1, 2, 3]
spam = ['cat', 'bat', 'rat', 'elephant']
spam
spam = [['cat', 'bat'], [10, 20, 30, 40, 50]]
print(spam[1][4])


4.1.2 负数下标
spam = ['cat', 'bat', 'rat', 'elephant']
pingStr = 'The ' + spam[-1] + ' is afraid of the ' + spam[-3] + '.'
print(pingStr)
The elephant is afraid of the bat.

4.1.3 利用切片取得子列表
print(spam[1:3])     #['bat', 'rat']
print(spam[0:-1])    #['cat', 'bat', 'rat']
spam[1:]
spam[:]

4.1.4 用 len()取得列表的长度

4.1.5 用下标改变列表中的值
spam[1] = 'aardvark'


4.1.6 列表连接和列表复制
>>> [1, 2, 3] + ['A', 'B', 'C']
>>> ['X', 'Y', 'Z'] * 3


4.1.7 用 del 语句从列表中删除值
>>> spam = ['cat', 'bat', 'rat', 'elephant']
>>> del spam[2]
del 语句也可用于一个简单变量， 删除它， 作用就像是“取消赋值” 语句。如
果在删除之后试图使用该变量， 就会遇到 NameError 错误， 因为该变量已不再存在。


4.2 使用列表
catNames = []
while True:
    print('Enter the name of cat ' + str(len(catNames) + 1) +
' (Or enter nothing to stop.):')
    name = input()
    if name == '':
        break
    catNames = catNames + [name] # list concatenation
print('The cat names are:')
for name in catNames:
    print(' ' + name)


4.2.1 列表用于循环
supplies = ['pens', 'staplers', 'flame-throwers', 'binders']
for i in range(len(supplies)):
    print('Index ' + str(i) + ' in supplies is: ' + supplies[i])

4.2.2 in 和 not in 操作符
>>> 'howdy' in ['hello', 'hi', 'howdy', 'heyas']
True
>>> 'howdy' not in spam
False


4.2.3 多重赋值技巧
>>> cat = ['fat', 'black', 'loud']
>>> size = cat[0]
>>> color = cat[1]
>>> disposition = cat[2]

>>> cat = ['fat', 'black', 'loud']
>>> size, color, disposition = cat


4.3 增强的赋值操作
+=    *=


4.4 方法
4.4.1 用 index()方法在列表中查找值
>>> spam = ['hello', 'hi', 'howdy', 'heyas']
>>> spam.index('hello')


4.4.2 用 append()和 insert()方法在列表中添加值
>>> spam = ['cat', 'dog', 'bat']
>>> spam.append('moose')

>>> spam = ['cat', 'dog', 'bat']
>>> spam.insert(1, 'chicken')
>>> spam
['cat', 'chicken', 'dog', 'bat']


4.4.3 用 remove()方法从列表中删除值
>>> spam = ['cat', 'bat', 'rat', 'elephant']
>>> spam.remove('bat')
>>> spam

>>> spam = ['cat', 'bat', 'rat', 'cat', 'hat', 'cat']
>>> spam.remove('cat')
>>> spam
['bat', 'rat', 'cat', 'hat', 'cat']


4.4.4 用 sort()方法将列表中的值排序
>>> spam = [2, 5, 3.14, 1, -7]
>>> spam.sort()
>>> spam
>>> spam.sort(reverse=True)
>>> spam

spam = [1, 3, 2, 4, 'Alice', 'Bob']
spam.sort()将报错

>>> spam = ['Alice', 'ants', 'Bob', 'badgers', 'Carol', 'cats']
>>> spam.sort()
>>> spam
['Alice', 'Bob', 'Carol', 'ants', 'badgers', 'cats']
>>> spam.sort(key=str.lower)
>>> spam
['Alice', 'ants', 'badgers', 'Bob', 'Carol', 'cats']


Python 中缩进规则的例外
print('Four score and seven ' + \
'years ago...')
可以把\看成是“ 这条指令在下一行继续”。 \续行字符之后的一行中，缩进并不重要。


4.6 类似列表的类型：字符串和元组
对列表的许多操作， 也可以作用于字符串：按下标取值、 切片、 用于 for 循环、 用于 len()， 以及用于 in 和 not in 操作符。
4.6.1 可变和不可变数据类型
>>> eggs = [1, 2, 3]
>>> eggs = [4, 5, 6]
>>> eggs
这里 eggs 中的列表值并没有改变， 而是整个新的不同的列表值([4, 5, 6])，覆写了老的列表值。


4.6.2 元组数据类型
元组与列表的主要区别还在于，元组像字符串一样， 是不可变的。 元组不能让它们的值被修改、 添加或删除。
如果元组中只有一个值， 你可以在括号内该值的后面跟上一个逗号， 表明这种情况。 
>>> type(('hello',))
<class 'tuple'>
>>> type(('hello'))
<class 'str'>

4.6.3 用 list()和 tuple()函数来转换类型
函数 list()和 tuple()将返回传递给它们的值的列表和元组版本。
>>> tuple(['cat', 'dog', 5])
('cat', 'dog', 5)
>>> list(('cat', 'dog', 5))
['cat', 'dog', 5]
>>> list('hello')
['h', 'e', 'l', 'l', 'o']


4.7 引用
>>> spam = [0, 1, 2, 3, 4, 5]
>>> cheese = spam
>>> cheese[1] = 'Hello!'
>>> spam
[0, 'Hello!', 2, 3, 4, 5]
>>> cheese
[0, 'Hello!', 2, 3, 4, 5]


4.7.1 传递引用
def eggs(someParameter):
    someParameter.append('Hello')
spam = [1, 2, 3]
eggs(spam)
print(spam)


4.7.2 copy 模块的 copy()和 deepcopy()函数
>>> import copy
>>> spam = ['A', 'B', 'C', 'D']
>>> cheese = copy.copy(spam)
>>> cheese[1] = 42
>>> spam
['A', 'B', 'C', 'D']
>>> cheese
['A', 42, 'C', 'D']
deepcopy()函数将同时复制它们内部的列表


5.1 字典数据类型
>>> myCat = {'size': 'fat', 'color': 'gray', 'disposition': 'loud'}
>>> myCat['size']
字典仍然可以用整数值作为键， 就像列表使用整数值作为下标一样， 但它们不必从 0 开始，可以是任何数字。
>>> spam = {12345: 'Luggage Combination', 42: 'The Answer'}


5.1.1 字典与列表
>>> spam = ['cats', 'dogs', 'moose']
>>> bacon = ['dogs', 'moose', 'cats']
>>> spam == bacon
False
>>> eggs = {'name': 'Zophie', 'species': 'cat', 'age': '8'}
>>> ham = {'species': 'cat', 'age': '8', 'name': 'Zophie'}
>>> eggs == ham
True


birthdays = {'Alice': 'Apr 1', 'Bob': 'Dec 12', 'Carol': 'Mar 4'}
while True:
    print('Enter a name: (blank to quit)')
    name = input()
    if name == '':
       break
    if name in birthdays:
       print(birthdays[name] + ' is the birthday of ' + name)
    else:
       print('I do not have birthday information for ' + name)
       print('What is their birthday?')
       bday = input()
       birthdays[name] = bday
       print('Birthday database updated.')


5.1.2 keys()、 values()和 items()方法

spam = {'color': 'red', 'age': 42}
for v in spam.values():
    print(v)
for k in spam.keys():
    print(k)
for i in spam.items():
    print(i)
#如果希望通过这些方法得到一个真正的列表，就把类似列表的返回值传递给 list
函数。  
>>> spam.keys()
dict_keys(['color', 'age'])
>>> list(spam.keys())
['color', 'age']

>>> for k, v in spam.items():
    print('Key: ' + k + ' Value: ' + str(v))
Key: color Value: red
Key: age Value: 42


5.1.3 检查字典中是否存在键或值
in 和 not in 操作符可以检查值是否存在于列表中。也可以利用这些操作符，检查某个键或值是否存在于字典中。

>>> 'color' not in spam.keys()
True
>>> 'color' in spam
False
'color' in spam 本质上是一个简写版本。相当于'color' in spam.keys()。


5.1.4 get()方法
它有两个参数：要取得其值的键，以及如果该键不存在时，返回的备用值。
>>> picnicItems = {'apples': 5, 'cups': 2}
>>> 'I am bringing ' + str(picnicItems.get('cups', 0)) + ' cups.'
'I am bringing 2 cups.'
>>> 'I am bringing ' + str(picnicItems.get('eggs', 0)) + ' eggs.'
'I am bringing 0 eggs.'


5.1.5 setdefault()方法
>>> spam = {'name': 'Pooka', 'age': 5}
>>> spam.setdefault('color', 'black')
'black'
>>> spam
{'color': 'black', 'age': 5, 'name': 'Pooka'}
>>> spam.setdefault('color', 'white')
'black'
>>> spam
{'color': 'black', 'age': 5, 'name': 'Pooka'}

程序循环迭代 message 字符串中的每个字符，计算每个字符出现的次数。 
message = 'It was a bright cold day in April, and the clocks were striking thirteen.'
count = {}
for character in message:
    count.setdefault(character, 0)
    count[character] = count[character] + 1
print(count)


5.2 漂亮打印
import pprint
message = 'It was a bright cold day in April, and the clocks were striking thirteen.'
count = {}
for character in message:
    count.setdefault(character, 0)
    count[character] = count[character] + 1
pprint.pprint(count)


5.3.2 嵌套的字典和列表
allGuests = {'Alice': {'apples': 5, 'pretzels': 12},
'Bob': {'ham sandwiches': 3, 'apples': 2},
'Carol': {'cups': 3, 'apple pies': 1}}
def totalBrought(guests, item):
    numBrought = 0
    for k, v in guests.items():
        numBrought = numBrought + v.get(item, 0)
    return numBrought
print('Number of things being brought:')
print(' - Apples ' + str(totalBrought(allGuests, 'apples')))
print(' - Cups ' + str(totalBrought(allGuests, 'cups')))
print(' - Cakes ' + str(totalBrought(allGuests, 'cakes')))
print(' - Ham Sandwiches ' + str(totalBrought(allGuests, 'ham sandwiches')))
print(' - Apple Pies ' + str(totalBrought(allGuests, 'apple pies')))


第6章
6.1 处理字符串
6.1.2 双引号
>>> spam = "That is Alice's cat."
6.1.3 转义字符
>>> spam = 'Say hi to Bob\'s mother.'
6.1.4 原始字符串
可以在字符串开始的引号之前加上 r， 使它成为原始字符串。“ 原始字符串” 完全忽略所有的转义字符， 打印出字符串中所有的倒斜杠。
6.1.5 用三重引号的多行字符串
print('''Dear Alice,
Eve's cat has been arrested for catnapping, cat burglary, and extortion.
Sincerely,
Bob''')
6.1.6 多行注释
"""This is a test Python program.
Written by Al Sweigart al@inventwithpython.com
This program was designed for Python 3, not Python 2.
"""
def spam():
    """This is a multiline comment to help
    explain what the spam() function does."""
    print('Hello!')
spam()


6.1.7 字符串下标和切片
6.1.8 字符串的 in 和 not in 操作符

6.2.1 字符串方法 upper()、 lower()、 isupper()和 islower()
如果字符串至少有一个字母， 并且所有字母都是大写或小写， isupper()和islower()方法就会相应地返回布尔值 True。否则， 该方法返回 False。
>>> spam = 'Hello world!'
>>> spam.islower()
False
>>> spam.isupper()
False
>>> 'HELLO'.isupper()
True


6.2.2 isX 字符串方法
 isalpha()返回 True， 如果字符串只包含字母， 并且非空；
 isalnum()返回 True，如果字符串只包含字母和数字，并且非空；
 isdecimal()返回 True，如果字符串只包含数字字符，并且非空；
 isspace()返回 True，如果字符串只包含空格、制表符和换行，并且非空；
 istitle()返回 True，如果字符串仅包含以大写字母开头、后面都是小写字母的单词。

>>> 'This Is not Title Case'.istitle()
False


6.2.3 字符串方法 startswith()和 endswith()
startswith()和 endswith()方法返回 True， 如果它们所调用的字符串以该方法传入的字符串开始或结束。否则， 方法返回 False。

>>> 'Hello world!'.startswith('Hello')
True

6.2.4 字符串方法 join()和 split()
>>> ', '.join(['cats', 'rats', 'bats'])
'cats, rats, bats'
>>> ' '.join(['My', 'name', 'is', 'Simon'])
'My name is Simon'
>>> 'ABC'.join(['My', 'name', 'is', 'Simon'])
'MyABCnameABCisABCSimon'

>>> 'My name is Simon'.split()
['My', 'name', 'is', 'Simon']
默认情况下，字符串'My name is Simon'按照各种空白字符分割， 诸如空格、 制表符或换行符。这些空白字符不包含在返回列表的字符串中。
>>> 'MyABCnameABCisABCSimon'.split('ABC')
['My', 'name', 'is', 'Simon']

6.2.5 用 rjust()、 ljust()和 center()方法对齐文本
rjust()和 ljust()字符串方法返回调用它们的字符串的填充版本， 通过插入空格来对齐文本。 这两个方法的第一个参数是一个整数长度， 用于对齐字符串。  
>>> 'Hello World'.rjust(20)
'         Hello World'
>>> 'Hello'.ljust(10)
'Hello     '

>>> 'Hello'.rjust(20, '*')
'***************Hello'

>>> 'Hello'.center(20)
'       Hello        '
>>> 'Hello'.center(20, '=')
'=======Hello========'

def printPicnic(itemsDict, leftWidth, rightWidth):
    print('PICNIC ITEMS'.center(leftWidth + rightWidth, '-'))
    for k, v in itemsDict.items():
        print(k.ljust(leftWidth, '.') + str(v).rjust(rightWidth))
picnicItems = {'sandwiches': 4, 'apples': 12, 'cups': 4, 'cookies': 8000}
printPicnic(picnicItems, 12, 5)
printPicnic(picnicItems, 20, 6)


6.2.6 用 strip()、 rstrip()和 lstrip()删除空白字符
strip()字符串方法将返回一个新的字符串， 它的开头或末尾都没有空白字符。
lstrip()和 rstrip()方法将相应删除左边或右边的空白字符。

>>> spam = ' Hello World '
>>> spam.strip()
'Hello World'
>>> spam.lstrip()
'Hello World '
>>> spam.rstrip()
' Hello World'
>>> 

向 strip()方法传入参数'ampS'， 告诉它在变量中存储的字符串两端， 删除出现的
a、 m、 p 和大写的 S。传入 strip()方法的字符串中， 字符的顺序并不重要


6.2.7 用 pyperclip 模块拷贝粘贴字符串
>>> import pyperclip
>>> pyperclip.copy('Hello world!')
>>> pyperclip.paste()
'Hello world!


6.3 项目：口令保管箱
#! python3
# pw.py - An insecure password locker program.

PASSWORDS = {'email': 'F7minlBDDuvMJuxESSKHFhTxFtjVB6',
'blog': 'VmALvQyKAxiVH5G8v01if1MLZF3sdt',
'luggage': '12345'}

import sys
if len(sys.argv) < 2:
   print('Usage: python pw.py [account] - copy account password')
   sys.exit()
account = sys.argv[1] # first command line arg is the account name - sys.argv 列表中的第一项总是一个字符串，它包含程序的文件名（ 'pw.py'）。第二项应该是第一个命令行参数。

if account in PASSWORDS:
   pyperclip.copy(PASSWORDS[account])
   print('Password for ' + account + ' copied to clipboard.')
else:
   print('There is no account named ' + account)


6.4 项目： 在 Wiki 标记中添加无序列表
#! python3
# bulletPointAdder.py - Adds Wikipedia bullet points to the start
# of each line of text on the clipboard.
import pyperclip
text = pyperclip.paste()
# Separate lines and add stars.
lines = text.split('\n')
for i in range(len(lines)): # loop through all indexes for "lines" list
    lines[i] = '* ' + lines[i] # add star to each string in "lines" list
text = '\n'.join(lines)
pyperclip.copy(text)



























