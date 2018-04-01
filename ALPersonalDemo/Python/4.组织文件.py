

9.1 shutil模块
shutil（或称为 shell 工具）模块中包含一些函数，让你在 Python 程序中复制、
移动、改名和删除文件。

9.1.1复制文件和文件夹
调用 shutil.copy(source, destination)，将路径source 处的文件复制到路径destination
处的文件夹（ source 和 destination 都是字符串）。如果 destination 是一个文件名，它将
作为被复制文件的新名字。该函数返回一个字符串，表示被复制文件的路径。

>>> import shutil,os
>>> os.chdir('/Users/dongdongkeji/Desktop')
>>> shutil.copy('/Users/dongdongkeji/Desktop/1024x1024.png','/Users/dongdongkeji/Desktop/123')
>>> shutil.copy('6666.txt','/Users/dongdongkeji/Desktop/123/hello.txt')

调用 shutil.copytree(source, destination)，将路径 source 处的文件夹，包括它的所有文件和子文件夹，复制到路径 destination 处的文件夹。 source 和
destination 参数都是字符串。该函数返回一个字符串，是新复制的文件夹的路径。

shutil.copytree()调用创建了一个新文件夹
shutil.copytree('/Users/dongdongkeji/Desktop/judge','/Users/dongdongkeji/Desktop/1234')


9.1.2文件与文件夹的移动与改名
调用 shutil.move(source, destination)， 将路径 source 处的文件夹移动到路径
destination，并返回新位置的绝对路径的字符串。
如果 destination 指向一个文件夹， source 文件将移动到 destination 中， 并保持
原来的文件名。

>>> shutil.move('/Users/dongdongkeji/Desktop/u100.png','/Users/dongdongkeji/Desktop/1234')
>>> shutil.move('/Users/dongdongkeji/Desktop/u100.png','/Users/dongdongkeji/Desktop/U1000.png')

9.1.3永久删除文件和文件夹
• 用 os.unlink(path)将删除 path 处的文件。
• 调用 os.rmdir(path)将删除 path 处的文件夹。该文件夹必需为空，其中没有任
何文件和文件夹。
• 调用 shutil.rmtree(path)将删除 path 处的文件夹，它包含的所有文件和文件夹都
会被删除。

import os
for filename in os.listdir():
if filename.endswith('.rxt'):
#os.unlink(filename)
print(filename)

9.1.4用send2trash模块安全地删除(第三方)
pip3 install send2trash
sudo pip install send2trash

>>> import send2trash
>>> baconFile = open('bacon.txt', 'a') # creates the file
>>> baconFile.write('Bacon is not a vegetable.')
>>> baconFile.close()
>>> send2trash.send2trash('bacon.txt')


9.2遍历目录树
import os
for folderName, subfolders, filenames in os.walk('Users/dongdongkeji/Downloads'):
    print('The current folder is ' + folderName)
    for subfolder in subfolders:
        print('SUBFOLDER OF ' + folderName + ': ' + subfolder)
    for filename in filenames:
        print('FILE INSIDE ' + folderName + ': '+ filename)
    print('')
os.walk()在循环的每次迭代中，返回 3 个值：
1．当前文件夹名称的字符串。
2．当前文件夹中子文件夹的字符串的列表。
3．当前文件夹中文件的字符串的列表。


9.用zipfile模块压缩文件

9.3.1读取ZIP文件
>>> import zipfile,os
>>> os.chdir('Users/dongdongkeji/Desktop')
>>> exampleZip = zipfile.ZipFile('example.zip')
>>> exampleZip.namelist()
['123/', '123/1024x1024.png', '123/hello.txt', '__MACOSX/', '__MACOSX/123/', '__MACOSX/123/._hello.txt']
>>> spamInfo = exampleZip.getinfo('123/hello.txt')
>>> spamInfo.file_size
723
>>> spamInfo.compress_size
380
>>> 'Compressed file is %sx smaller!' % (round(spamInfo.file_size / spamInfo
.compress_size, 2))
... 'Compressed file is 1.0x smaller!'
>>> exampleZip.close()

ZipFile 对象有一个 namelist()方法，返回 ZIP 文件中包含的所有文件和文件夹
的字符串的列表。


9.3.2从ZIP文件中解压缩
>>> os.chdir('..')
>>> os.getcwd()
'/Users/dongdongkeji'
>>> import zipfile,os
>>> os.chdir('Desktop')
>>> exampleZip = zipfile.ZipFile('example.zip')
>>> exampleZip.extractall()
>>> exampleZip.namelist()
['123/', '123/1024x1024.png', '123/hello.txt', '__MACOSX/', '__MACOSX/123/', '__MACOSX/123/._hello.txt']
>>> exampleZip.extract('123/1024x1024.png')
'/Users/dongdongkeji/Desktop/123/1024x1024.png'
>>> exampleZip.extract('123/1024x1024.png','Users/dongdongkeji/Desktop/1234')
'Users/dongdongkeji/Desktop/1234/123/1024x1024.png'
>>> exampleZip.close()
可以向 extract()传递第二个参数， 将文件解压到指定的文件夹， 而不是当
前工作目录。如果第二个参数指定的文件夹不存在， Python 就会创建它。 extract()
的返回值是被压缩后文件的绝对路径。

9.3.3创建和添加到ZIP文件
>>> import zipfile
>>> newZip = zipfile.ZipFile('new.zip','w')
>>> newZip.write('bacon.txt',compress_type=zipfile.ZIP_DEFLATED)
>>> newZip.close()
第二个参数是“压缩类型”参数。

9.4项目：将带有美国风格日期的文件改名为欧洲风格日期
（ MM-DD-YYYY）<----> DD-MM-YYYY

datePattern = re.compile(r"""^(1) # all text before the date
(2 (3) )- # one or two digits for the month
(4 (5) )- # one or two digits for the day
(6 (7) ) # four digits for the year
(8)$ # all text after the date
""", re.VERBOSE)

#! python3
# renameDates.py - Renames filenames with American MM-DD-YYYY date format
# to European DD-MM-YYYY.

import shutil, os, re
# Create a regex that matches files with the American date format.

datePattern = re.compile(r"""^(.*?)    # all text before the date
    ((0|1)?\d)-                        # one or two digits for the month
    ((0|1|2|3)?\d)-                    # one or two digits for the day
    ((19|20)\d\d)                      # four digits for the year
    (.*?)$                             # all text after the date
    """, re.VERBOSE)
# Loop over the files in the working directory.
for amerFilename in os.listdir('Users/dongdongkeji/Desktop'):
    mo = datePattern.search(amerFilename)
    # Skip files without a date.
    if mo == None:
        continue
    # Get the different parts of the filename.
    beforePart = mo.group(1)
    monthPart = mo.group(2)
    dayPart = mo.group(4)
    yearPart = mo.group(6)
    afterPart = mo.group(8)
    # Form the European-style filename.
    euroFilename = beforePart + dayPart + '-' + monthPart + '-' + yearPart + afterPart
    # Get the full, absolute file paths.
    absWorkingDir = os.path.abspath('.')
    amerFilename = os.path.join(absWorkingDir, amerFilename)
    euroFilename = os.path.join(absWorkingDir, euroFilename)
    # Rename the files.
    print('Renaming "%s" to "%s"...' % (amerFilename, euroFilename))
    #shutil.move(amerFilename, euroFilename) # uncomment after testing


9.5项目：将一个文件夹备份到一个ZIP文件
#! python3
# backupToZip.py - Copies an entire folder and its contents into
# a ZIP file whose filename increments.

import zipfile, os

def backupToZip(folder):
    # Backup the entire contents of "folder" into a ZIP file.
    folder = os.path.abspath(folder) # make sure folder is absolute
    # Figure out the filename this code should use based on
    # what files already exist.
    number = 1
    while True:
        zipFilename = os.path.basename(folder) + '_' + str(number) + '.zip'
        if not os.path.exists(zipFilename):
            break
        number = number + 1
        # Create the ZIP file.
        print('Creating %s...' % (zipFilename))
        backupZip = zipfile.ZipFile(zipFilename, 'w')
        # Walk the entire folder tree and compress the files in each folder.
        for foldername, subfolders, filenames in os.walk(folder):
            print('Adding files in %s...' % (foldername))
            # Add the current folder to the ZIP file.
            backupZip.write(foldername)
            # Add all the files in this folder to the ZIP file.
            for filename in filenames:
                newBase / os.path.basename(folder) + '_'
                #newBase = os.path.basename(folder) + '_' + str(number)
                if filename.startswith(newBase) and filename.endswith('.zip')
                    continue # don't backup the backup ZIP files
                backupZip.write(os.path.join(foldername, filename))
                backupZip.close()
        print('Done.') 
backupToZip('/Users/dongdongkeji/Desktop/1234')










