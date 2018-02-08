
webbrowser：是 Python 自带的，打开浏览器获取指定页面。
requests：从因特网上下载文件和网页。
Beautiful Soup：解析HTML，即网页编写的格式。
selenium：启动并控制一个 Web浏览器。 selenium 能够填写表单，并模拟鼠标
在这个浏览器中点击。

res.encoding='utf-8'

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

iter_content()方法在循环的每次迭代中，返回一段内容。你需要指定一段包含多少字节。


11.4 HTML

不要用正则表达式来解析HTML


11.5用BeautifulSoup模块解析HTML

命令行中运行 pip install beautifulsoup4
导入它，使用 import bs4

11.5.1从HTML创建一个BeautifulSoup对象
>>> import requests, bs4
>>> res = requests.get('http://nostarch.com')
>>> res.raise_for_status()
>>> noStarchSoup = bs4.BeautifulSoup(res.text)
>>> type(noStarchSoup)
<class 'bs4.BeautifulSoup'>

从硬盘加载一个 HTML 文件
>>> exampleFile = open('example.html')
>>> exampleSoup = bs4.BeautifulSoup(exampleFile)
>>> type(exampleSoup)
<class 'bs4.BeautifulSoup'>


11.5.2用select()方法寻找元素
针对你要寻找的元素，调用 method()方法，传入一个字符串作为 CSS “选择器”，
这样就可以取得 Web 页面元素。

CSS选择器的例子
soup.select('div')                    所有名为<div>的元素
soup.select('#author')                带有 id 属性为 author 的元素
soup.select('.notice')                所有使用 CSS class 属性名为 notice 的元素
soup.select('div span')               所有在<div>元素之内的<span>元素
soup.select('div > span')             所有直接在<div>元素之内的<span>元素， 中间没有其他元素
soup.select('input[name]')            所有名为<input>，并有一个 name 属性，其值无所谓的元素
soup.select('input[type="button"]')   所有名为<input>，并有一个 type 属性，其值为 button 的元素


>>> import bs4
>>> exampleFile = open('example.html')
>>> exampleSoup = bs4.BeautifulSoup(exampleFile.read())
>>> elems = exampleSoup.select('#author')
>>> type(elems)
<type 'list'>
>>> len(elems)
1
>>> type(elems[0])
<class 'bs4.element.Tag'>
>>> elems[0].getText()
u'Al Sweigart'
>>> str(elems[0])
'<span id="author">Al Sweigart</span>'
>>> elems[0].attrs
{u'id': u'author'}

从 BeautifulSoup 对象中᢮出<p>元素
>>> pElems = exampleSoup.select('p')
>>> str(pElems[0])
'<p>Download my <strong>Python</strong> book from <a href="http://\ninventwithpython.com">my website</a>.</p>'
>>> pElems[0].getText()
u'Download my Python book from my website.'
>>> str(pElems[1])
'<p class="slogan">Learn Python the easy way!</p>'
>>> pElems[1].getText()
u'Learn Python the easy way!'

11.5.3通过元素的属性获取数据
>>> import bs4
>>> soup = bs4.BeautifulSoup(open('example.html'))
>>> spanElem = soup.select('span')[0]
>>> str(spanElem)
'<span id="author">Al Sweigart</span>'
>>> spanElem.get('id')
u'author'
>>> spanElem.get('some_nonexistent_addr') == None
True
>>> spanElem.attrs
{u'id': u'author'}


11.6 项目：”I‘m Feeling Lucky” Google 查找
只要在命令行中输入查找主题，就能让计算机自动打开浏览器，并在新的选项卡中显示前面几项查询结果

sudo pip install certifi
sudo pip install -U requests[socks]

#! python3
# lucky.py - Opens several Google search results.
#https://github.com/qiyeboy/IPProxyPool
#http://httpbin.org/headers - visit header
#http://webpy.org/install_macosx
'''
#sudo pip install web.py
'''

import requests, sys, webbrowser, bs4

print('Googling...') # display text while downloading the Google page

#res = requests.get('https://google.com/search?q=' + ' '.join(sys.argv[1:]),verify=False)
#res = requests.get(url, headers=headers, proxies=proxies)

res = requests.get('https://google.com/search?q=' + ' '.join(sys.argv[1:]),proxies={'https': 'https://127.0.0.1:1080'})

res.raise_for_status()

# Retrieve top search result links.
soup = bs4.BeautifulSoup(res.text)
# Open a browser tab for each result.
linkElems = soup.select('.r a')

numOpen = min(5, len(linkElems))
for i in range(numOpen):
    webbrowser.open('http://google.com' + linkElems[i].get('href'))



11.7 项目： 下载所有XKCD漫画
#! python3
# downloadXkcd.py - Downloads every single XKCD comic.
import requests, os, bs4

# make dirs with mode
def mkdir_with_mode(directory,mode):
  if not os.path.isdir(directory):
    oldmask = os.umask(000)
    os.makedirs(directory,0o777)
    os.umask(oldmask)

url = 'http://xkcd.com' # starting url
mkdir_with_mode('xkcd',0o777) # store comics in ./xkcd
while not url.endswith('#'):
    # Download the page.
    print('Downloading page %s...' % url)
    res = requests.get(url)
    res.raise_for_status()
    soup = bs4.BeautifulSoup(res.text)
    # Find the URL of the comic image.
    comicElem=soup.select('#comic img')
    if comicElem == []:
        print('Could not find comic image.')
    else:
        comicUrl = 'http:'+comicElem[0].get('src')
        # Download the image.
        print('Downloading image %s...' % (comicUrl))
        res = requests.get(comicUrl)
        res.raise_for_status()
        # Save the image to ./xkcd.
        imageFile = open(os.path.join('xkcd', os.path.basename(comicUrl)), 'wb')
        for chunk in res.iter_content(100000):
            imageFile.write(chunk)
        imageFile.close()
    # Get the Prev button's url.
    prevLink = soup.select('a[rel="prev"]')[0]
    url = 'http://xkcd.com' + prevLink.get('href')
print('Done.')


11.8 用selenium模块控制浏览器
selenium 模块让 Python 直接控制浏览器
#http://chromedriver.storage.googleapis.com/index.html
>>> from selenium import webdriver
>>> chromedriver = '/Users/dongdongkeji/Downloads/chromedriver'
>>> driver = webdriver.Chrome(chromedriver)
>>> driver.get("http://tw.yahoo.com/")

>>> type(driver)
<class 'selenium.webdriver.chrome.webdriver.WebDriver'>


11.8.2在页面中寻找元素

selenium 的 WebDriver 方法
方法名                                                          返回的WebElement对象/列表
browser.find_element_by_class_name(name)                       使用 CSS 类 name 的元素
browser.find_elements_by_class_name(name)
browser.find_element_by_css_selector(selector)                 匹配CSS selector 的元素
browser.find_elements_by_css_selector(selector)
browser.find_element_by_id(id)                                 匹配id属性值的元素
browser.find_elements_by_id(id)
browser.find_element_by_link_text(text)                        完全匹配提供的text的<a>元素
browser.find_elements_by_link_text(text)
browser.find_element_by_partial_link_text(text)                包含提供的text的<a>元素
browser.find_elements_by_partial_link_text(text)
browser.find_element_by_name(name)                             匹配name属性值的元素
browser.find_elements_by_name(name)
browser.find_element_by_tag_name(name)                         匹配标签name的元素
browser.find_elements_by_tag_name(name)                        (大小写无关， <a>元素匹配'a'和'A')

除了*_by_tag_name()方法，所有方法的参数都是区分大小写的。


试图找到带有类名'bookcover'的元素
from selenium import webdriver
chromedriver = '/Users/dongdongkeji/Downloads/chromedriver'
browser = webdriver.Chrome(chromedriver)
browser.get('http://inventwithpython.com')
try:
    elem = browser.find_element_by_class_name('bookcover')
    print('Found <%s> element with that class name!' % (elem.tag_name))
except:
    print('Was not able to find an element with that name.')


11.8.3点击页面

from selenium import webdriver
chromedriver = '/Users/dongdongkeji/Downloads/chromedriver'
browser = webdriver.Chrome(chromedriver)
browser.get('http://inventwithpython.com')
linkElem = browser.find_element_by_link_text('Talk Python to Me pocast (Apr 2017)')
type(linkElem)
linkElem.click() # follows the "Read It Online" link


11.8.4填写并提交表单
向 Web 页面的文本字段发送击键，只要找到那个文本字段的<input>或<textarea>元素，然后调用 send_keys()方法。

from selenium import webdriver
chromedriver = '/Users/dongdongkeji/Downloads/chromedriver'
browser = webdriver.Chrome(chromedriver)
browser.get('http://gmail.com')
emailElem = browser.find_element_by_id('Email')
emailElem.send_keys('not_my_real_email@gmail.com')
passwordElem = browser.find_element_by_id('Passwd')
passwordElem.send_keys('12345')
passwordElem.submit()


11.8.5发送特殊键
selenium.webdriver.common.keys 模块中常用的变量

属性                                                含义
Keys.DOWN, Keys.UP, Keys.LEFT,Keys.RIGHT           键盘方向键
Keys.ENTER, Keys.RETURN                            回车和换行键
Keys.HOME, Keys.END,Keys.PAGE_DOWN,Keys.PAGE_UP    Home 键、 End 键、 PageUp 键和 Page Down 键
Keys.ESCAPE, Keys.BACK_SPACE,Keys.DELETE           Esc、 Backspace 和字母键
Keys.F1, Keys.F2, . . . , Keys.F12                 键盘顶部的 F1到 F12键
Keys.TAB                                           Tab 键


>>> from selenium import webdriver
>>> from selenium.webdriver.common.keys import Keys
>>> chromedriver = '/Users/dongdongkeji/Downloads/chromedriver'
>>> browser = webdriver.Chrome(chromedriver)
>>> browser.get('http://www.sina.com.cn/')
>>> htmlElem = browser.find_element_by_tag_name('html')
>>> htmlElem.send_keys(Keys.END) # scrolls to bottom
>>> htmlElem.send_keys(Keys.HOME) # scrolls to top


11.8.6 点击浏览器按钮

browser.back()     点击“返回”按钮。
browser.forward()  点击“前进”按钮。
browser.refresh()  点击“刷新”按钮。
browser.quit()     点击“关闭窗口”按钮。









