
10.1抛出异常
抛出异常使用 raise 语句。在代码中， raise 语句包含以下部分：
• raise 关键字˗
• 对 Exception 函数的调用˗
• 传递给 Exception 函数的字符串，包含有用的出错信息。
>>> raise Exception('This is the error message.')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
Exception: This is the error message.

def boxPrint(symbol, width, height):
    if len(symbol) != 1:
        raise Exception('Symbol must be a single character string.')
    if width <= 2:
        raise Exception('Width must be greater than 2.')
    if height <= 2:
        raise Exception('Height must be greater than 2.')
    print(symbol * width)
    for i in range(height - 2):
        print(symbol + (' ' * (width - 2)) + symbol)
    print(symbol * width)
for sym, w, h in (('*', 4, 4), ('O', 20, 5), ('x', 1, 3), ('ZZ', 3, 3)):
    try:
        boxPrint(sym, w, h)
    except Exception as err:
        print('An exception happened: ' + str(err))


10.2取得反向跟踪的字符串
反向跟踪
包含了出错消息、导致该错误的代码行号，以及导致该错误的函数调用的序列。这
个序列称为“调用栈”。


只要抛出的异常没有被处理， Python 就会显示反向跟踪。但你也可以调用
traceback.format_exc()，得到它的字符串形式。
import traceback
try:
    raise Exception('This is the error message.')
except:
    errorFile = open('errorInfo.txt', 'w')
    errorFile.write(traceback.format_exc())
    errorFile.close()
    print('The traceback info was written to errorInfo.txt.')


10.3断言
• assert 关键字˗
• 条件（即求值为 True 或 False 的表达式）˗
• 逗号：
• 当条件为 False 时显示的字符串。

>>> podBayDoorStatus = 'open'
>>> assert podBayDoorStatus == 'open', 'The pod bay doors need to be "open".'
>>> podBayDoorStatus = "I\'m sorry, Dave. I\'m afraid I can't do that."
>>> assert podBayDoorStatus == 'open', 'The pod bay doors need to be "open".'
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
AssertionError: The pod bay doors need to be "open".


10.3.1 在交通灯模拟中使用断言

10.3.2警用断言
在运行 Python 时传入-O 选项，可以警用断言。


10.4 日志
10.4.1使用日志模块

import logging
logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
logging.debug('Start of program')

def factorial(n):
    logging.debug('Start of factorial(%s%%)' % (n))
    total = 1
    for i in range(n + 1):
        total *= i
        logging.debug('i is ' + str(i) + ', total is ' + str(total))
    logging.debug('End of factorial(%s%%)' % (n))
    return total
    
print(factorial(5))
logging.debug('End of program')

10.4.2不要调用print()调试
只要加入一次 logging.disable（ logging.CRITICAL）调用，就可以禁止日志。

10.4.3日志级别
级别         日志函数             描述  
DEBUG    logging.debug()        最低级别。用于小细节。通常只有在诊断问题时，你才会关心这些消息
INFO     logging.info()         用于记录程序中一般事件的信息，或确认一切工作正常
WARNING  logging.warning()      用于表示可能的问题，它不会阻止程序的工作，但将来可能会
ERROR    logging.error()        用于记录错误，它导致程序做某事失败
CRITICAL logging.critical()     最高级别。用于表示致命的错误，它导致或将要导致程序完全停止工作

>>> import logging
>>> logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
>>> logging.debug('Some debugging details.')
 2018-02-06 13:07:41,230 - DEBUG - Some debugging details.
>>> logging.info('The logging module is working.')
 2018-02-06 13:07:48,576 - INFO - The logging module is working.
>>> logging.warning('An error message is about to be logged.')
 2018-02-06 13:08:02,594 - WARNING - An error message is about to be logged.
>>> logging.error('An error has occurred.')
 2018-02-06 13:08:11,707 - ERROR - An error has occurred.
>>> logging.critical('The program is unable to recover!')
 2018-02-06 13:08:22,259 - CRITICAL - The program is unable to recover!


10.4.4禁用日志
>>> import logging
>>> logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
>>> logging.critical('Critical error! Critical error!')
 2018-02-06 13:10:42,865 - CRITICAL - Critical error! Critical error!
>>> logging.disable(logging.CRITICAL)
>>> logging.critical('Critical error! Critical error!')
>>> logging.error('Error! Error!')


10.4.5将日志记录到文件
>>> import logging
>>> logging.basicConfig(filename='myProgramLog.txt', level=logging.DEBUG, format='%(asctime)s - %(levelname)s - %(message)s')
>>> logging.debug('Some debugging details.')


10.5 IDLE的调试器






