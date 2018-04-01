

14.1.1 Reader对象

>>> import csv
>>> exampleFile = open('example.csv')
>>> exampleReader = csv.reader(exampleFile)
>>> exampleData = list(exampleReader)
>>> exampleData
[['4/5/2014 13:34', 'Apples', '73'], ['4/5/2014 3:41', 'Cherries', '85'], ['4/6/2014 12:46', 'Pears', '14'], ['4/8/2014 8:59', 'Oranges', '52'], ['4/10/2014 2:07', 'Apples', '152'], ['4/10/2014 18:10', 'Bananas', '23'], ['4/10/2014 2:40', 'Strawberries', '98']]


>>> exampleData[0][0]
'4/5/2014 13:34'
>>> exampleData[0][1]
'Apples'
>>> exampleData[0][2]
'73'
>>> exampleData[1][1]
'Cherries'
>>> exampleData[6][1]
'Strawberries'


14.1.2 在for循环中，从Reader对象读取数据
对于大型的 CSV 文件，你需要在一个 for 循环中使用 Reader 对象。这样避免将整个文件一次性装入内存。
>>> import csv
>>> exampleFile = open('example.csv')
>>> exampleReader = csv.reader(exampleFile)
>>> for row in exampleReader:
...     print('Row #' + str(exampleReader.line_num) + ' ' + str(row))
... 
Row #1 ['4/5/2014 13:34', 'Apples', '73']
Row #2 ['4/5/2014 3:41', 'Cherries', '85']
Row #3 ['4/6/2014 12:46', 'Pears', '14']
Row #4 ['4/8/2014 8:59', 'Oranges', '52']
Row #5 ['4/10/2014 2:07', 'Apples', '152']
Row #6 ['4/10/2014 18:10', 'Bananas', '23']
Row #7 ['4/10/2014 2:40', 'Strawberries', '98']


14.1.3 Writer对象

如果忘记设置 newline 关键字参数， output.csv中的行距将有两倍

>>> import csv
>>> outputFile = open('output.csv', 'w', newline='')
>>> outputWriter = csv.writer(outputFile)
>>> outputWriter.writerow(['spam', 'eggs', 'bacon', 'ham'])
21
>>> outputWriter.writerow(['Hello, world!', 'eggs', 'bacon', 'ham'])
32
>>> outputWriter.writerow([1, 2, 3.141592, 4])
16
>>> outputFile.close()


14.1.4 delimiter和lineterminator关键字参数
>>> import csv
>>> csvFile = open('example.tsv', 'w', newline='')
>>> csvWriter = csv.writer(csvFile, delimiter='\t', lineterminator='\n\n')
>>> csvWriter.writerow(['apples', 'oranges', 'grapes'])
23
>>> csvWriter.writerow(['eggs', 'bacon', 'ham'])
16
>>> csvWriter.writerow(['spam', 'spam', 'spam', 'spam', 'spam', 'spam'])
31
>>> csvFile.close()
这改变了文件中的分隔符和行终止字符。


14.2 项目：从CSV文件中删除表头

#! python3
# removeCsvHeader.py - Removes the header from all CSV files in the current
# working directory.

import csv, os

os.makedirs('headerRemoved', exist_ok=True)

# Loop through every file in the current working directory.
for csvFilename in os.listdir('.'):
    if not csvFilename.endswith('.csv'):
        continue # skip non-csv files

    print('Removing header from ' + csvFilename + '...')

    # Read the CSV file in (skipping first row).
    csvRows = []
    csvFileObj = open(csvFilename)
    readerObj = csv.reader(csvFileObj)
    for row in readerObj:
        if readerObj.line_num == 1:
            continue # skip first row
        csvRows.append(row)
    csvFileObj.close()

    # Write out the CSV file.
    csvFileObj = open(os.path.join('headerRemoved', csvFilename), 'w', newline='')
    csvWriter = csv.writer(csvFileObj)
    for row in csvRows:
        csvWriter.writerow(row)
    csvFileObj.close()


14.3 JSON和API

14.4 json模块
Python 的 json 模块处理了 JSON 数据字符串和 Python 值之间转换的所有细节，得到了 json.loads()和 json.dumps()函数。

14.4.1 用loads() 函数读取JSON
>>> stringOfJsonData = '{"name": "Zophie", "isCat": true, "miceCaught": 0,"felineIQ": null}'
>>> import json
>>> jsonDataAsPythonValue = json.loads(stringOfJsonData)
>>> jsonDataAsPythonValue
{'isCat': True, 'miceCaught': 0, 'name': 'Zophie', 'felineIQ': None}

14.4.2 用dumps函数写出JSON
>>> pythonValue = {'isCat': True, 'miceCaught': 0, 'name': 'Zophie','felineIQ': None}
>>> import json
>>> stringOfJsonData = json.dumps(pythonValue)
>>> stringOfJsonData
'{"isCat": true, "miceCaught": 0, "name": "Zophie", "felineIQ": null}'


14.5 项目：取得当前的天气数据
#! python3
# quickWeather.py - Prints the current weather for a location from the command line.

import json, requests, sys

# Compute location from command line arguments.
if len(sys.argv) < 2:
    print('Usage: quickWeather.py location')
    sys.exit()
location = ' '.join(sys.argv[1:])

# Download the JSON data from OpenWeatherMap.org's API
url ='http://api.openweathermap.org/data/2.5/forecast/daily?q=%s&cnt=3' % (location)
response = requests.get(url)
response.raise_for_status()

# Load JSON data into a Python variable.
weatherData = json.loads(response.text)

# Print weather descriptions.
w = weatherData['list']
print('Current weather in %s:' % (location))
print(w[0]['weather'][0]['main'], '-', w[0]['weather'][0]['description'])
print()
print('Tomorrow:')
print(w[1]['weather'][0]['main'], '-', w[1]['weather'][0]['description'])
print()
print('Day after tomorrow:')
print(w[2]['weather'][0]['main'], '-', w[2]['weather'][0]['description'])


第15章  保持时间、计划任务和启动程序

利用 subprocess 和 threading 模块，你也可以编程按时启动其他程序。
15.1 time 模块

15.1.1 time.time()函数
>>> import time
>>> time.time()
1518150519.637092

经过的时间
import time
def calcProd():
    # Calculate the product of the first 100,000 numbers.
    product = 1
    for i in range(1, 100000):
        product = product * i
    return product
startTime = time.time()
prod = calcProd()
endTime = time.time()
print('The result is %s digits long.' % (len(str(prod))))
print('Took %s seconds to calculate.' % (endTime - startTime))


15.1.2 time.sleep()函数
import time
for i in range(3):
    print('Tick')
    time.sleep(1)
    print('Tock')
    time.sleep(1)

15.2 数字四舍五入
>>> import time
>>> now = time.time()
>>> now
1518152627.9395351
>>> round(now, 2)
1518152627.94
>>> round(now, 4)
1518152627.9395
>>> round(now)
1518152628

15.3 项目：超级秒数
#! python3
# stopwatch.py - A simple stopwatch program.

import time

# Display the program's instructions.
print('Press enter to begin. Afterwards, press ENTER to "click" the stopwatch. Press Ctrl-C to quit.')
input() # press Enter to begin
print('Started.')
startTime = time.time() # get the first lap's start time
lastTime = startTime
lapNum = 1

# Start tracking the lap times.
try:
    while True:
        input()
        lapTime = round(time.time() - lastTime, 2)
        totalTime = round(time.time() - startTime, 2)
        print('Lap #%s: %s (%s)' % (lapNum, totalTime, lapTime), end='')
        lapNum += 1
        lastTime = time.time() # reset the last lap time
except KeyboardInterrupt:
    # Handle the Ctrl-C exception to keep its error message from displaying.
    print('\nDone.')


15.4 datetime模块
>>> import datetime
>>> datetime.datetime.now()
datetime.datetime(2018, 2, 9, 13, 16, 1, 936037)
>>> dt = datetime.datetime(2015, 10, 21, 16, 29, 0)
>>> dt.year, dt.month, dt.day
(2015, 10, 21)
>>> dt.hour, dt.minute, dt.second
(16, 29, 0)

#Unix 纪元时间戳可以通过 datetime.datetime.fromtimestamp()，转换为 datetime对象。 
>>> datetime.datetime.fromtimestamp(1000000)
datetime.datetime(1970, 1, 12, 21, 46, 40)
>>> datetime.datetime.fromtimestamp(time.time())
datetime.datetime(2018, 2, 9, 13, 16, 59, 942511)

>>> halloween2015 = datetime.datetime(2015, 10, 31, 0, 0, 0)
>>> newyears2016 = datetime.datetime(2016, 1, 1, 0, 0, 0)
>>> oct31_2015 = datetime.datetime(2015, 10, 31, 0, 0, 0)
>>> halloween2015 == oct31_2015
True
>>> halloween2015 > newyears2016
False
>>> newyears2016 != oct31_2015
True

15.4.1 timedelta数据类型
>>> delta = datetime.timedelta(days=11, hours=10, minutes=9, seconds=8)
>>> delta.days, delta.seconds, delta.microseconds
(11, 36548, 0)
>>> delta.total_seconds()
986948.0
>>> str(delta)
'11 days, 10:09:08'

要计算今天之后 1000天的日期
>>> dt = datetime.datetime.now()
>>> dt
datetime.datetime(2018, 2, 9, 13, 26, 52, 206721)
>>> thousandDays = datetime.timedelta(days=1000)
>>> dt + thousandDays
datetime.datetime(2020, 11, 5, 13, 26, 52, 206721)

>>> oct21st = datetime.datetime(2015, 10, 21, 16, 29, 0)
>>> aboutThirtyYears = datetime.timedelta(days=365 * 30)
>>> oct21st
datetime.datetime(2015, 10, 21, 16, 29)
>>> oct21st - aboutThirtyYears
datetime.datetime(1985, 10, 28, 16, 29)
>>> oct21st - (2 * aboutThirtyYears)
datetime.datetime(1955, 11, 5, 16, 29)


15.4.2 暂停直至特定日期
import datetime
import time
halloween2016 = datetime.datetime(2016, 10, 31, 0, 0, 0)
while datetime.datetime.now() < halloween2016:
time.sleep(1)


15.4.3 将datetime对象转换为字符串

strftime()方法，可以将 datetime 对象显示为字符串。（ strftime()函数名中的 f 表示格式， format）。
%Y 带世纪的年份，例如'2014'
%y 不带世纪的年份， '00'至'99'（ 1970 至 2069）
%m 数字表示的月份, '01'至'12'
%B 完整的月份，例如'November'
%b 简写的月份，例如'Nov'
%d 一月中的第几天， '01'至'31'
%j 一年中的第几天， '001'至'366'
%w 一周中的第几天， '0'（周日）至'6'（周六）
%A 完整的周几，例如'Monday'
%a 简写的周几，例如'Mon'
%H 小时（ 24 小时时钟）， '00'至'23'
%I 小时（ 12 小时时钟）， '01'至'12'
%M 分， '00'至'59'
%S 秒， '00'至'59'
%p 'AM'或'PM'
%% 就是'%'字符

>>> oct21st = datetime.datetime(2015, 10, 21, 16, 29, 0)
>>> oct21st.strftime('%Y/%m/%d %H:%M:%S')
'2015/10/21 16:29:00'
>>> oct21st.strftime('%I:%M %p')
'04:29 PM'
>>> oct21st.strftime("%B of '%y")
"October of '15"


15.4.4 将字符串转换成datetime对象
>>> datetime.datetime.strptime('October 21, 2015', '%B %d, %Y')
datetime.datetime(2015, 10, 21, 0, 0)
>>> datetime.datetime.strptime('2015/10/21 16:29:00', '%Y/%m/%d %H:%M:%S')
datetime.datetime(2015, 10, 21, 16, 29)
>>> datetime.datetime.strptime("October of '15", "%B of '%y")
datetime.datetime(2015, 10, 1, 0, 0)
>>> datetime.datetime.strptime("November of '63", "%B of '%y")
datetime.datetime(2063, 11, 1, 0, 0)


15.5 回顾 Python 的时间函数


15.6多线程
import threading, time

print('Start of program.')

def takeANap():
    time.sleep(5)
    print('Wake up!')

threadObj = threading.Thread(target=takeANap)
threadObj.start()
print('End of program.')

15.6.1 向线程的目标函数传递参数
>>> import threading
>>> threadObj = threading.Thread(target=print, args=['Cats', 'Dogs', 'Frogs'],kwargs={'sep': ' & '})
>>> threadObj.start()
Cats & Dogs & Frogs

>>> print('Cats', 'Dogs', 'Frogs', sep=' & ')
Cats & Dogs & Frogs

15.6.2 并发问题

15.7 项目：多线程 XKCD 下载程序
调用 Thread 对象 join()方法将阻塞，直到该线程完成。
#! python3
# multidownloadXkcd.py - Downloads XKCD comics using multiple threads.

import requests, os, bs4, threading
os.makedirs('xkcd', exist_ok=True) # store comics in ./xkcd

def downloadXkcd(startComic, endComic):
    for urlNumber in range(startComic, endComic):
        # Download the page.
        print('Downloading page http://xkcd.com/%s...' % (urlNumber))
        res = requests.get('http://xkcd.com/%s' % (urlNumber))
        res.raise_for_status()

        soup = bs4.BeautifulSoup(res.text)

        # Find the URL of the comic image.
        comicElem = soup.select('#comic img')
        if comicElem == []:
            print('Could not find comic image.')
        else:
            comicUrl = comicElem[0].get('src')
            # Download the image.
            print('Downloading image %s...' % (comicUrl))
            res = requests.get(comicUrl)
            res.raise_for_status()

            # Save the image to ./xkcd
            imageFile = open(os.path.join('xkcd', os.path.basename(comicUrl)), 'wb')
            for chunk in res.iter_content(100000):
                imageFile.write(chunk)
            imageFile.close()

# Create and start the Thread objects.
downloadThreads = [] # a list of all the Thread objects
for i in range(0, 1400, 100): # loops 14 times, creates 14 threads
    downloadThread = threading.Thread(target=downloadXkcd, args=(i, i + 99))
    downloadThreads.append(downloadThread)
    downloadThread.start()

# Wait for all threads to end.
for downloadThread in downloadThreads:
    downloadThread.join()
print('Done.')


15.8 从 Python 启动其他程序
>>> import subprocess
在 Ubuntu Linux 上，可以输入以下代码：
>>> subprocess.Popen('/usr/bin/gnome-calculator')

打开了计算器程序。在它仍在运行时，我们检查 poll()是否返回None。它应该返回 None，因为该进程仍在运行。然后，我们关闭计算器程序，并对
已终止的进程调用 wait()。 wait()和 poll()现在返回 0，说明该进程终止且无错。

15.8.1 向 Popen()传递命令行参数
用 Popen()创建进程时，可以向进程传递命令行参数。

15.8.2 Task Scheduler、 launchd 和 cron

15.8.3 用 Python 打开网站
webbrowser.open()函数可以从程序启动 Web 浏览器，打开指定的网站，而不是
用 subprocess.Popen()打开浏览器应用程序。

15.8.4 运行其他 Python 脚本

15.8.5 用默认的应用程序打开文件
>>> import subprocess
>>> subprocess.Popen(['open', '/Applications/Calculator.app/'])
<subprocess.Popen object at 0x1018914e0>


15.9 项目：简单的倒计时程序













