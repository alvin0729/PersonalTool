
7.1 不用正则表达式来查找文本模式

7.2 用正则表达式查找文本模式
7.2.1 创建正则表达式对象
#如果字符串中没有找到该正则表达式模式， search()方法将返回 None。
#如果找到了该模式，search()方法将返回一个 Match 对象。 Match 对象有一个 group()方法，它返回被查找字符串中实际匹配的文本。
import re
phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d')
mo = phoneNumRegex.search('My number is 415-555-4242.') 
print('Phone number found: ' + mo.group())


---向 re.compile()传递原始字符串
因为正则表达式常常使用倒斜杠，向 re.compile()函数传入原始字符串就很方
便 ， 而 不 是 输 入 额 外 得 到 斜 杠 。 输 入 r'\d\d\d-\d\d\d-\d\d\d\d' ， 比 输 入
'\\d\\d\\d-\\d\\d\\d-\\d\\d\\d\\d'要容易得多。

添加括号将在正则表达式中创建“ 分组”：
(\d\d\d)-(\d\d\d-\d\d\d\d)
正则表达式字符串中的第一对括号是第 1 组。第二对括号是第 2 组。向 group()
匹配对象方法传入整数 1 或 2， 就可以取得匹配文本的不同部分。 向 group()方法传
入 0 或不传入参数， 将返回整个匹配的文本。
import re
phoneNumRegex = re.compile(r'(\d\d\d)-(\d\d\d-\d\d\d\d)')
mo = phoneNumRegex.search('My number is 415-555-4242.')
print(mo.group(1))
print(mo.group(2))
print(mo.group(0))
print(mo.group())


如果想要一次就获取所有的分组， 请使用 groups()方法， 注意函数名的复数形式
areaCode, mainNumber = mo.groups()
print(areaCode)
print(mainNumber)


括号在正则表达式中有特殊的含义， 但是如果你需要在文本中匹配括号， 怎么
办？例如， 你要匹配的电话号码， 可能将区号放在一对括号中。在这种情况下， 就
需要用倒斜杠对(和)进行字符转义。
phoneNumRegex = re.compile(r'(\(\d\d\d\)) (\d\d\d-\d\d\d\d)')
mo = phoneNumRegex.search('My phone number is (415) 555-4242.')
print(mo.group(1))
print(mo.group(2))


7.3.2 用管道匹配多个分组
字符|称为“管道”。希望匹配许多表达式中的一个时， 就可以使用它。例如，
正则表达式 r'Batman|Tina Fey'将匹配'Batman'或'Tina Fey'。

如果 Batman 和 Tina Fey 都出现在被查找的字符串中， 第一次出现的匹配文本，
将作为 Match 对象返回。

>>> heroRegex = re.compile (r'Batman|Tina Fey')
>>> mo1 = heroRegex.search('Batman and Tina Fey.')
>>> mo1.group()
'Batman'
>>> mo2 = heroRegex.search('Tina Fey and Batman.').group()
>>> mo2
'Tina Fey'

利用 findall()方法，可以找到“所有”匹配的地方。

使用管道来匹配多个模式中的一个， 作为正则表达式的一部分。
>>> batRegex = re.compile(r'Bat(man|mobile|copter|bat)')
>>> mo = batRegex.search('Batmobile lost a wheel')
>>> mo.group()
'Batmobile'
>>> mo.group(1)
'mobile'


7.3.3 用问号实现可选匹配
>>> batRegex = re.compile(r'Bat(wo)?man')
>>> mo1 = batRegex.search('The Adventures of Batman')
>>> mo1.group()
'Batman'
>>> mo2 = batRegex.search('The Adventures of Batwoman')
>>> mo2.group()
'Batwoman'

>>> phoneRegex = re.compile(r'(\d\d\d-)?\d\d\d-\d\d\d\d')
>>> mo1 = phoneRegex.search('My number is 415-555-4242')
>>> mo1.group()
'415-555-4242'
>>> mo2 = phoneRegex.search('My number is 555-4242')
>>> mo2.group()
'555-4242'
>>> 


7.3.4 用星号匹配零次或多次
>>> batRegex = re.compile(r'Bat(wo)*man')
>>> mo3 = batRegex.search('The Adventures of Batwowowowoman')
>>> mo3.group()
'Batwowowowoman'


7.3.5 用加号匹配一次或多次
>>> batRegex = re.compile(r'Bat(wo)+man')
>>> mo1 = batRegex.search('The Adventures of Batwoman')
>>> mo3 = batRegex.search('The Adventures of Batman')
>>> mo1.group()
'Batwoman'
>>> mo3 == None
True


7.3.6 用花括号匹配特定次数
(Ha){3,5}将匹配'HaHaHa'、 'HaHaHaHa'和'HaHaHaHaHa'
(Ha){3}将匹配字符串'HaHaHa'，
(Ha){3,}将匹配 3 次或更多次实例， (Ha){,5}将匹配 0 到 5 次实例。


7.4 贪心和非贪心匹配
花括号的“ 非贪心” 版本匹配尽可能最短的字符串，即在
结束的花括号后跟着一个问号。
>>> greedyHaRegex = re.compile(r'(Ha){3,5}')
>>> mo1 = greedyHaRegex.search('HaHaHaHaHa')
>>> mo1.group()
'HaHaHaHaHa'
>>> nongreedyHaRegex = re.compile(r'(Ha){3,5}?')
>>> mo2 = nongreedyHaRegex.search('HaHaHaHaHa')
>>> mo2.group()
'HaHaHa'


7.5 findall()方法
findall()方法将返回一组字符串， 包含被查找字符串中的所有匹配。如果在正则表达式中有分组， 那么 findall 将返回元组的列表。
每个元组表示一个找到的匹配，其中的项就是正则表达式中每个分组的匹配字符串。
search()返回的 Match 对象只包含第一次出现的匹配文本
>>> phoneNumRegex = re.compile(r'\d\d\d-\d\d\d-\d\d\d\d')                 # has no groups     
>>> mo = phoneNumRegex.search('Cell: 415-555-9999 Work: 212-555-0000')
>>> mo.group()
'415-555-9999'
>>> phoneNumRegex.findall('Cell: 415-555-9999 Work: 212-555-0000')       
['415-555-9999', '212-555-0000']

>>> phoneNumRegex = re.compile(r'(\d\d\d)-(\d\d\d)-(\d\d\d\d)')           # has groups
>>> phoneNumRegex.findall('Cell: 415-555-9999 Work: 212-555-0000')
[('415', '555', '9999'), ('212', '555', '0000')]

作为 findall()方法的返回结果的总结，请记住下面两点：
1． 如果调用在一个没有分组的正则表达式上， 例如\d\d\d-\d\d\d-\d\d\d\d， 方法
findall()将返回一个匹配字符串的列表， 例如['415-555-9999', '212-555-0000']。
2． 如果调用在一个有分组的正则表达式上， 例如(\d\d\d)-(\d\d\d)-(\d\d\d\d)， 方
法 findall()将返回一个字符串的元组的列表 （ 每个分组对应一个字符串），例如[('415',
'555', '1122'), ('212', '555', '0000')]。


7.6 字符分类

缩写字符分类      表示
\d              0 到 9 的任何数字
\D              除 0 到 9 的数字以外的任何字符
\w              任何字母、数字或下划线字符（可以认为是匹配“单词”字符）
\W              除字母、数字和下划线以外的任何字符
\s              空格、制表符或换行符（可以认为是匹配“空白”字符）
\S              除空格、制表符和换行符以外的任何字符


字符分类[0-5]只匹配数字 0 到 5
>>> xmasRegex = re.compile(r'\d+\s\w+')
>>> xmasRegex.findall('12 drummers, 11 pipers, 10 lords, 9 ladies, 8 maids, 7 swans, 6 geese, 5 rings, 4 birds, 3 hens, 2 doves, 1 partridge')
['12 drummers', '11 pipers', '10 lords', '9 ladies', '8 maids', '7 swans', '6 geese', '5 rings', '4 birds', '3 hens', '2 doves', '1 partridge']



7.7 建立自己的字符分类
>>> vowelRegex = re.compile(r'[aeiouAEIOU]')
>>> vowelRegex.findall('RoboCop eats baby food. BABY FOOD.')
['o', 'o', 'o', 'e', 'a', 'a', 'o', 'o', 'A', 'O', 'O']

也可以使用短横表示字母或数字的范围。例如， 字符分类[a-zA-Z0-9]将匹配所
有小写字母、 大写字母和数字。

请注意，在方括号内，普通的正则表达式符号不会被解释。这意味着，你不需
要前面加上倒斜杠转义.、 *、 ?或()字符。例如，字符分类将匹配数字 0 到 5 和一个
句点。你不需要将它写成[0-5\.]。

通过在字符分类的左方括号后加上一个插入字符（ ^）， 就可以得到“ 非字符类”。
非字符类将匹配不在这个字符类中的所有字符。
>>> consonantRegex = re.compile(r'[^aeiouAEIOU]')
>>> consonantRegex.findall('RoboCop eats baby food. BABY FOOD.')
['R', 'b', 'C', 'p', ' ', 't', 's', ' ', 'b', 'b', 'y', ' ', 'f', 'd', '.', ' ', 'B', 'B', 'Y', ' ', 'F', 'D', '.']


7.8 插入字符和美元字符
可以在正则表达式的开始处使用插入符号（ ^），表明匹配必须发生在被查找文
本开始处。类似地，可以再正则表达式的末尾加上美元符号（ $），表示该字符串必
须以这个正则表达式的模式结束。可以同时使用^和$，表明整个字符串必须匹配该
模式。

例如， 正则表达式 r'^Hello'匹配以'Hello'开始的字符串。
>>> beginsWithHello = re.compile(r'^Hello')
>>> beginsWithHello.search('Hello world!')
<_sre.SRE_Match object at 0x102833bf8>
>>> beginsWithHello.search('He said hello.') == None
True

正则表达式 r'\d$'匹配以数字 0 到 9 结束的字符串。
>>> endsWithNumber = re.compile(r'\d$')
>>> endsWithNumber.search('Your number is 42')
<_sre.SRE_Match object at 0x102735850>
>>> endsWithNumber.search('Your number is forty two.') == None
True

正则表达式 r'^\d+$'匹配从开始到结束都是数字的字符串。
>>> wholeStringIsNum = re.compile(r'^\d+$')
>>> wholeStringIsNum.search('1234567890')
<_sre.SRE_Match object at 0x102735850>
>>> wholeStringIsNum.search('12345xyz67890') == None
True
>>> wholeStringIsNum.search('12 34567890') == None
True


7.9 通配字符
在正则表达式中， .（句点）字符称为“通配符”。它匹配除了换行之外的所有
字符。
>>> atRegex = re.compile(r'.at')
>>> atRegex.findall('The cat in the hat sat on the flat mat.')
['cat', 'hat', 'sat', 'lat', 'mat']
要匹配真正的句点， 就是用倒斜杠转义： \.。


7.9.1 用点-星匹配所有字符
句点字符表示“除换行外所有单个字符”，星号字符表示“前
面字符出现零次或多次”。
>>> nameRegex = re.compile(r'First Name: (.*) Last Name: (.*)')
>>> mo = nameRegex.search('First Name: Al Last Name: Sweigart')
>>> mo.group(1)
'Al'
>>> mo.group(2)
'Sweigart'

点-星使用“贪心” 模式：它总是匹配尽可能多的文本。要用“非贪心” 模式匹配
所有文本， 就使用点-星和问号。
>>> nongreedyRegex = re.compile(r'<.*?>')
>>> mo = nongreedyRegex.search('<To serve man> for dinner.>')
>>> mo.group()
'<To serve man>'
>>> greedyRegex = re.compile(r'<.*>')
>>> mo = greedyRegex.search('<To serve man> for dinner.>')
>>> mo.group()
'<To serve man> for dinner.>'


7.9.2 用句点字符匹配换行
点-星将匹配除换行外的所有字符。通过传入 re.DOTALL 作为 re.compile()的第
二个参数， 可以让句点字符匹配所有字符， 包括换行字符。
>>> noNewlineRegex = re.compile('.*')
>>> noNewlineRegex.search('Serve the public trust.\nProtect the innocent.\nUphold the law.').group()
'Serve the public trust.'
>>> newlineRegex = re.compile('.*', re.DOTALL)
>>> newlineRegex.search('Serve the public trust.\nProtect the innocent.\nUphold the law.').group()
'Serve the public trust.\nProtect the innocent.\nUphold the law.'


7.10 正则表达式符号复习
x ?匹配零次或一次前面的分组。
x *匹配零次或多次前面的分组。
x +匹配一次或多次前面的分组。
x {n}匹配 n 次前面的分组。
x {n,}匹配 n 次或更多前面的分组。
x {,m}匹配零次到 m 次前面的分组。
x {n,m}匹配至少 n 次、至多 m 次前面的分组。
x {n,m}?或*?或+?对前面的分组进行非贪心匹配。
x ^spam 意味着字符串必须以 spam 开始。
x spam$意味着字符串必须以 spam 结束。
x .匹配所有字符，换行符除外。
x \d、 \w 和\s 分别匹配数字、单词和空格。
x \D、 \W 和\S 分别匹配出数字、单词和空格外的所有字符。
x [abc]匹配方括号内的任意字符（诸如 a、 b 或 c）。
x [^abc]匹配不在方括号内的任意字符。


7.11 不区分大小写的匹配
可以向 re.compile()传入 re.IGNORECASE 或 re.I，作为第二个参数。
>>> robocop.search('RoboCop is part man, part machine, all cop.').group()
'RoboCop'
>>> robocop.search('ROBOCOP protects the innocent.').group()
'ROBOCOP'
>>> robocop.search('Al, why does your programming book talk about robocop so much?').group()
'robocop'


7.12 用 sub()方法替换字符串
Regex
对象的 sub()方法需要传入两个参数。第一个参数是一个字符串， 用于取代发现的匹
配。第二个参数是一个字符串，即正则表达式。 sub()方法返回替换完成后的字符串。
>>> namesRegex = re.compile(r'Agent \w+')
>>> namesRegex.sub('CENSORED', 'Agent Alice gave the secret documents to Agent Bob.')
'CENSORED gave the secret documents to CENSORED.'

在 sub()的第一个参数中，可以输入\1、 \2、 \3……。表示“在替换中输入分组 1、 2、 3……的文本”。
>>> agentNamesRegex = re.compile(r'Agent (\w)\w*')
>>> agentNamesRegex.sub(r'\1****', 'Agent Alice told Agent Carol that Agent Eve knew Agent Bob was a double agent.')
'A**** told C**** that E**** knew B**** was a double agent.'
字符串中的\1 将由分组 1 匹配的文本所替代，也就是正则表达式的(\w)分组。


7.13 管理复杂的正则表达式
告诉 re.compile()， 忽略正则表达式字符
串中的空白符和注释， 从而缓解这一点。 要实现这种详细模式， 可以向 re.compile()
传入变量 re.VERBOSE， 作为第二个参数。
phoneRegex = re.compile(r'''(
    (\d{3}|\(\d{3}\))?                 # area code
    (\s|-|\.)?                         # separator
    \d{3}                              # first 3 digits
    (\s|-|\.)                          # separator
    \d{4}                              # last 4 digits
    (\s*(ext|x|ext.)\s*\d{2,5})?       # extension
    )''', re.VERBOSE)


7.14 组合使用 re.IGNOREC ASE、 re.DOTALL 和 re.VERBOSE
re.compile()函数只接受一
个值作为它的第二参数。可以使用管道字符（ |）将变量组合起来，从而绕过这个限
制。管道字符在这里称为“按位或”操作符。
>>> someRegexValue = re.compile('foo', re.IGNORECASE | re.DOTALL)
>>> someRegexValue = re.compile('foo', re.IGNORECASE | re.DOTALL | re.VERBOSE)


7.15 项目： 电话号码和 E-mail 地址提取程序
import re,pyperclip
phoneRegex = re.compile(r'''(
    (\d{3}|\(\d{3}\))?                 # area code
    (\s|-|\.)?                         # separator
    \d{3}                              # first 3 digits
    (\s|-|\.)                          # separator
    \d{4}                              # last 4 digits
    (\s*(ext|x|ext.)\s*\d{2,5})?       # extension
    )''', re.VERBOSE)


# Create email regex.
emailRegex = re.compile(r'''(
    [a-zA-Z0-9._%+-]+ # username
    @ # @ symbol
    [a-zA-Z0-9.-]+ # domain name
    (\.[a-zA-Z]{2,4}) # dot-something
    )''', re.VERBOSE)


# Find matches in clipboard text.
text = str(pyperclip.paste())
matches = []
for groups in phoneRegex.findall(text):
    phoneNum = '-'.join([groups[1], groups[3], groups[5]])  
    #phoneNum 变量包含一个字符串，它由匹配文本的分组 1、 3、 5 和 8 构成o。（ 这些分组是区号、 前 3 个数字、 后 4 个数字和分机号。）
    if groups[8] != '':
        phoneNum += ' x' + groups[8]
    matches.append(phoneNum)
for groups in emailRegex.findall(text):
    matches.append(groups[0])

# Copy results to the clipboard.
if len(matches) > 0:
    pyperclip.copy('\n'.join(matches))
    print('Copied to clipboard:')
    print('\n'.join(matches))
else:
    print('No phone numbers or email addresses found.')



















