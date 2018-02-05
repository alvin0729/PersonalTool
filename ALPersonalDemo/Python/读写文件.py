pip3 install pyperclip


8.1文件与文件路径
>>> import os
os.path.join('usr', 'bin', 'spam')
>>> 'usr/bin/spam'

>>> myFiles = ['accounts.txt', 'details.csv', 'invite.docx']
>>> for filename in myFiles:
...     print(os.path.join('/Users/alvin/asweigart', filename))
/Users/alvin/asweigart/accounts.txt
/Users/alvin/asweigart/details.csv
/Users/alvin/asweigart/invite.docx


8.1.2 当前工作目录
>>> import os
>>> os.getcwd()
'/Users/alvin/Desktop'


利用 os.getcwd()函数，可以取得当前工作路径的字符串， 并可以利用 os.chdir()改变它。
>>> os.chdir('/Users/alvin/Downloads')
>>> os.getcwd()
'/Users/alvin/Downloads'


8.1.3 绝对路径与相对路径
单个的句点（“点”）用作文件夹目名称时，是“ 这个目录”的缩
写。两个句点（“点点”）意思是父文件夹。

8.1.4 用os.makedirs()创建新文件夹
>>> import os
>>> os.makedirs('/Users/alvin/Desktop/helloKitty')
>>> os.makedirs('/Users/alvin/Desktop/helloKitty1/dir/5')

8.1.5 os.path模块
http://docs.python.org/3/library/os.path.html


8.1.6 处理绝对路径和相对路径
• 调用 os.path.abspath(path)将返回参数的绝对路径的字符串。这是将相对路径转为绝对路径的简便方法。
• 调用 os.path.isabs(path)，如果参数是一个绝对路径，就返回 True，如果参数是
一个相对路径，就返回 False。
• 调用 os.path.relpath(path, start)将返回从 start 路径到 path 的相对路径的字符串。
如果没有提供 start，就使用当前工作目录作为开始路径。

>>> os.path.abspath('.')
'/Users/alvin/Downloads'
>>> os.path.abspath('./Scripts')
'/Users/alvin/Downloads/Scripts'
>>> os.path.isabs('.')
False
>>> os.path.isabs(os.path.abspath('.'))
True

>>> os.path.relpath('/Users/alvin/Desktop','helloKitty')
'../../Desktop'
>>> os.path.relpath('/Users/alvin/Desktop')
'../Desktop'


>>> path = '/Users/alvin/Desktop/heep.txt'
>>> os.path.basename(path)
'heep.txt'
>>> os.path.dirname(path)
'/Users/alvin/Desktop'

如果同时需要一个路径的目录名称和基本名称， 就可以调用 os.path.split()，获
得这两个字符串的元组。
>>> os.path.split(path)
('/Users/alvin/Desktop', 'heep.txt')


>>> os.path.sep
'/'
>>> path.split(os.path.sep)
['', 'Users', 'alvin', 'Desktop', 'heep.txt']
>>> 

8.1.7 查看文件大小和文件夹内容
• 调用 os.path.getsize(path)将返回 path 参数中文件的字节数。
• 调用 os.listdir(path)将返回文件名字符串的列表，包含 path 参数中的每个文件
（请注意，这个函数在 os 模块中，而不是 os.path）。
>>> os.path.getsize('/Users/alvin/Desktop/test.mp3')
4427185

>>> os.listdir('/Users/alvin/Tool')
['.DS_Store', 'Downloads', 'OmniGraffle.dmg', 'PopClip154.dmg', 'Xcode.app']

import os
totalSize = 0
for filename in os.listdir('/Users/alvin/Tool'):
    totalSize = totalSize + os.path.getsize(os.path.join('/Users/alvin/Tool',filename))
print(totalSize)

8.1.8检查路径有效性
• 如果 path 参数所指的文件或文件夹存在， 调用 os.path.exists(path)将返回 True，否则返回 False。
• 如果 path 参数存在，并且是一个文件， 调用 os.path.isfile(path)将返回 True， 否则返回 False。
• 如果 path 参数存在， 并且是一个文件夹， 调用 os.path.isdir(path)将返回 True，否则返回 False。
>>> os.path.exists('C:\\Windows')
True
>>> os.path.exists('C:\\some_made_up_folder')
False
>>> os.path.isdir('C:\\Windows\\System32')
True
>>> os.path.isfile('C:\\Windows\\System32')
False
>>> os.path.isdir('C:\\Windows\\System32\\calc.exe')
False
>>> os.path.isfile('C:\\Windows\\System32\\calc.exe')
True

8.2文件读写过程
8.2.1用open()函数打开文件
>>> helloFile = open('/Users/alvin/Desktop/hellow.txt')
>>> helloContent = helloFile.read()
>>> helloContent
'hello world!'

>>> helloFile = open('/Users/alvin/Desktop/hellow.txt')
>>> helloFile.readlines()
["When, in disgrace with fortune and men's eyes,\r\n", 'I all alone beweep my outcast state,\n', 'And trouble deaf heaven with my bootless cries,\r\n', 'And look upon myself and curse my fate.']


8.2.3写入文件
>>> helloFile = open('/Users/alvin/Desktop/hellow.txt','w')
>>> helloFile.write('hello world!\n')
>>> helloFile.close()
>>> helloFile = open('/Users/alvin/Desktop/hellow.txt','a')
>>> helloFile.write('Bacon is not a vegetable.')
>>> helloFile.close()
>>> helloFile = open('/Users/alvin/Desktop/hellow.txt')
>>> helloContent = helloFile.read()
>>> helloFile.close()
>>> print(helloContent)
hello world!
Bacon is not a vegetable.


8.3用shelve模块保存变量
利用 shelve 模块， 你可以将 Python 程序中的变量保存到二进制的 shelf 文件中。
这样， 程序就可以从硬盘中恢复变量的数据。 shelve 模块让你在程序中添加“ 保存”
和“ 打开” 功能。例如， 如果运行一个程序，并输入了一些配置设置，就可以将这
些设置保存到一个 shelf 文件，然后让程序下一次运行时加载它们
>>> import shelve
>>> shelfFile = shelve.open('mydata')
>>> cats = ['Zophie', 'Pooka','Simon']
>>> shelfFile['cats'] = cats
>>> shelfFile.close()
 shelf 值不
必用读模式或写模式打开，因为它们在打开后，既能读又能写。
>>> shelfFile = shelve.open('mydata')
>>> type(shelfFile)
<type 'instance'>
>>> shelfFile['cats']
['Zophie', 'Pooka', 'Simon']
>>> shelfFile.close()
返回类似列表的值， 而不是真正的列表， 所以应该将它们传递给 list()函数， 取得列表的形式。
>>> shelfFile = shelve.open('mydata')
>>> list(shelfFile.keys())
['cats']
>>> list(shelfFile.values())
[['Zophie', 'Pooka', 'Simon']]
>>> shelfFile.close()


8.4用pprint.pformat()函数保存变量
pprint.pprint()函数将列表或字典中的内容“漂
亮打印” 到屏幕， 而 pprint.pformat()函数将返回同样的文本字符串，但不是打印它。

>>> import pprint
>>> cats = [{'name': 'Zophie', 'desc': 'chubby'}, {'name': 'Pooka', 'desc': 'fluffy'}]
>>> pprint.pformat(cats)
"[{'desc': 'chubby', 'name': 'Zophie'}, {'desc': 'fluffy', 'name': 'Pooka'}]"
>>> fileObj = open('myCats.py', 'w')
>>> fileObj.write('cats = ' + pprint.pformat(cats) + '\n')
>>> fileObj.close()

由于 Python 脚本本身也是带有.py 文件扩展名的文本文件， 所以你的 Python 程
序甚至可以生成其他 Python 程序。
>>> import myCats
>>> myCats.cats
[{'name': 'Zophie', 'desc': 'chubby'}, {'name': 'Pooka', 'desc': 'fluffy'}]
>>> myCats.cats[0]
{'name': 'Zophie', 'desc': 'chubby'}
>>> myCats.cats[0]['name']
'Zophie'


8.5项目：生成随机的测验试卷文件
#! python3
# randomQuizGenerator.py - Creates quizzes with questions and answers in
# random order, along with the answer key.
import random

# The quiz data. Keys are states and values are their capitals.

capitals = {'Alabama': 'Montgomery', 'Alaska': 'Juneau', 'Arizona': 'Phoenix',
'Arkansas': 'Little Rock', 'California': 'Sacramento', 'Colorado': 'Denver',
'Connecticut': 'Hartford', 'Delaware': 'Dover', 'Florida': 'Tallahassee',
'Georgia': 'Atlanta', 'Hawaii': 'Honolulu', 'Idaho': 'Boise', 'Illinois':
'Springfield', 'Indiana': 'Indianapolis', 'Iowa': 'Des Moines', 'Kansas':
'Topeka', 'Kentucky': 'Frankfort', 'Louisiana': 'Baton Rouge', 'Maine':
'Augusta', 'Maryland': 'Annapolis', 'Massachusetts': 'Boston', 'Michigan':
'Lansing', 'Minnesota': 'Saint Paul', 'Mississippi': 'Jackson', 'Missouri':
'Jefferson City', 'Montana': 'Helena', 'Nebraska': 'Lincoln', 'Nevada':
'Carson City', 'New Hampshire': 'Concord', 'New Jersey': 'Trenton', 'New Mexico': 
'Santa Fe', 'New York': 'Albany', 'North Carolina': 'Raleigh',
'North Dakota': 'Bismarck', 'Ohio': 'Columbus', 'Oklahoma': 'Oklahoma City',
'Oregon': 'Salem', 'Pennsylvania': 'Harrisburg', 'Rhode Island': 'Providence',
'South Carolina': 'Columbia', 'South Dakota': 'Pierre', 'Tennessee':
'Nashville', 'Texas': 'Austin', 'Utah': 'Salt Lake City', 'Vermont':
'Montpelier', 'Virginia': 'Richmond', 'Washington': 'Olympia', 'West Virginia': 
'Charleston', 'Wisconsin': 'Madison', 'Wyoming': 'Cheyenne'}

# Generate 35 quiz files.
for quizNum in range(2):
    # Create the quiz and answer key files.
    quizFile = open('capitalsquiz%s.txt' % (quizNum + 1), 'w')
    answerKeyFile = open('capitalsquiz_answers%s.txt' % (quizNum + 1), 'w')
    # Write out the header for the quiz.
    quizFile.write('Name:\n\nDate:\n\nPeriod:\n\n')
    quizFile.write((' ' * 20) + 'State Capitals Quiz (Form %s)' % (quizNum + 1))
    quizFile.write('\n\n')
    # Shuffle the order of the states.
    states = list(capitals.keys())
    random.shuffle(states)
    # Loop through all 50 states, making a question for each.
    for questionNum in range(50):
        # Get right and wrong answers.
        correctAnswer = capitals[states[questionNum]]
        wrongAnswers = list(capitals.values())
        del wrongAnswers[wrongAnswers.index(correctAnswer)]
        wrongAnswers = random.sample(wrongAnswers, 3)
        answerOptions = wrongAnswers + [correctAnswer]
        random.shuffle(answerOptions)
        # Write the question and the answer options to the quiz file.
        quizFile.write('%s. What is the capital of %s?\n' % (questionNum + 1,states[questionNum]))
        for i in range(4):
            quizFile.write(' %s. %s\n' % ('ABCD'[i], answerOptions[i]))
        quizFile.write('\n')
        # Write the answer key to a file.
        answerKeyFile.write('%s. %s\n' % (questionNum + 1, 'ABCD'[answerOptions.index(correctAnswer)]))
    quizFile.close()
    answerKeyFile.close()

8.6项目：多重剪贴板
.pyw 扩展名意味着 Python运行该程序时， 不会显示终端窗口
该程序将利用一个关键字保存每段剪贴板文本。例如， 当运行 py mcb.pyw save
spam， 剪贴板中当前的内容就用关键字 spam 保存。 通过运行 py mcb.pyw spam， 这段文本稍后将重新加载到
剪贴板中。如果用户忘记了都有哪些关键字， 他们可以运
行 py mcb.pyw list，将所有关键字的列表复制到剪贴板中。


#! python3
# mcb.pyw - Saves and loads pieces of text to the clipboard.
# Usage: py.exe mcb.pyw save <keyword> - Saves clipboard to keyword.
# py.exe mcb.pyw <keyword> - Loads keyword to clipboard.
# py.exe mcb.pyw list - Loads all keywords to clipboard.
import shelve, pyperclip, sys
mcbShelf = shelve.open('mcb')
# Save clipboard content.
if len(sys.argv) == 3 and sys.argv[1].lower() == 'save':
    mcbShelf[sys.argv[2]] = pyperclip.paste()
elif len(sys.argv) == 2:
    # List keywords and load content.
    if sys.argv[1].lower() == 'list':
        pyperclip.copy(str(list(mcbShelf.keys())))
    elif sys.argv[1] in mcbShelf:
        pyperclip.copy(mcbShelf[sys.argv[1]])
mcbShelf.close()










































