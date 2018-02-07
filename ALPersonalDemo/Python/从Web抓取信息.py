
webbrowser：是 Python 自带的，打开浏览器获取指定页面。
requests：从因特网上下载文件和网页。
Beautiful Soup：解析HTML，即网页编写的格式。
selenium：启动并控制一个 Web浏览器。 selenium 能够填写表单，并模拟鼠标
在这个浏览器中点击。

11.1项目：利用webbrowser模块的mapIt.py
• 从命令行参数或剪贴板中取得街道地址。
• 打开 Web 浏览器，指向该地址的 Google 地图页面。

#! python3
# mapIt.py - Launches a map in the browser using an address from the
# command line or clipboard.
import webbrowser, sys, pyperclip
if len(sys.argv) > 1:
    # Get address from command line.
    address = ' '.join(sys.argv[1:])
else:
    # Get address from clipboard.
    address = pyperclip.paste()
webbrowser.open('https://www.google.com/maps/place/' + address)


11.2用requests模块从Web下载文件
pip install requests
import requests

11.2.1用requests.get()函数下载一个网页
通过在 requests.get()的返回
值上调用 type()，你可以看到它返回一个 Response 对象，其中包含了 Web 服务器对
你的请求做出的响应。

>>> import requests
>>> res = requests.get('http://www.gutenberg.org/cache/epub/1112/pg1112.txt')
>>> type(res)
<class 'requests.models.Response'>
>>> res.status_code == requests.codes.ok
True
>>> len(res.text)
178981
>>> print(res.text[:250])
﻿The Project Gutenberg EBook of Romeo and Juliet, by William Shakespeare

This eBook is for the use of anyone anywhere at no cost and with
almost no restrictions whatsoever.  You may copy it, give it away or
re-use it under the terms of the Proje


11.2.2 检查错误
>>> res = requests.get('http://inventwithpython.com/page_that_does_not_exist')
>>> res.raise_for_status()


import requests
res = requests.get('http://inventwithpython.com/page_that_does_not_exist')
try:
   res.raise_for_status()
except Exception as exc:
   print('There was a problem: %s' % (exc))


11.3将下载的文件保存到硬盘

wb用“写二进”模式打开该文件，为了保存该文本中的“ Unicode 编码”。

>>> import requests
>>> res = requests.get('http://www.gutenberg.org/cache/epub/1112/pg1112.txt')
>>> res.raise_for_status()
>>> playFile = open('RomeoAndJuliet.txt', 'wb')
>>> for chunk in res.iter_content(100000):
...     playFile.write(chunk)
... 
>>> playFile.close()














