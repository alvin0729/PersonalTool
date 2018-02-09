
18.1 安装 pyautogui 模块
在 OS X 上，运行 sudo pip3 install pyobjc-framework-Quartz， sudo pip3 install
pyobjc-core，然后 sudo pip3 install pyobjc。
pip3 install pyautogui

18.2 走对路
18.2.1 通过注销关闭所有程序
在 OS X，热键是 command-Shift-Option-Q。

18.2.2 暂停和自动防故障装置
将 pyautogui.PAUSE 变量设置为要暂停的秒数
pyautogui 也有自动防故障功能。将鼠标移到屏幕的左上角，这将导致 pyautogui产生 pyautogui .FailSafeException 异常。
可以设置 pyautogui. FAILSAFE = False，禁止这项功能。

>>> import pyautogui
>>> pyautogui.PAUSE = 1
>>> pyautogui.FAILSAFE = True
这里我们导入 pyautogui，并将 pyautogui.PAUSE 设置为 1，即每次函数调用后暂停一秒。将 pyautogui.FAILSAFE 设置为 True，启动自动防故障功能。


18.3 控制鼠标移动
>>> import pyautogui
>>> pyautogui.size()
(1920, 1080)
>>> width, height = pyautogui.size()


18.3.1 移动鼠标
import pyautogui
for i in range(10):
    pyautogui.moveTo(100, 100, duration=0.25)
    pyautogui.moveTo(200, 100, duration=0.25)
    pyautogui.moveTo(200, 200, duration=0.25)
    pyautogui.moveTo(100, 200, duration=0.25)

import pyautogui
for i in range(10):
    pyautogui.moveRel(100, 0, duration=0.25)
    pyautogui.moveRel(0, 100, duration=0.25)
    pyautogui.moveRel(-100, 0, duration=0.25)
    pyautogui.moveRel(0, -100, duration=0.25)

18.3.2 获取鼠标位置
>>> import pyautogui
>>> pyautogui.position()
(589, 374)
>>> pyautogui.position()
(1497, 573)

18.4 项目：“现在鼠标在哪里？”
#! python3
# mouseNow.py - Displays the mouse cursor's current position.
import pyautogui
print('Press Ctrl-C to quit.')
try:
    while True:
        # Get and print the mouse coordinates.
        x, y = pyautogui.position()
        positionStr = 'X: ' + str(x).rjust(4) + ' Y: ' + str(y).rjust(4)
        print(positionStr, end='')
        print('\b' * len(positionStr), end='', flush=True)

except KeyboardInterrupt:
    print('\nDone.')

print() 函数的关键字参数 end='' 阻止了在打印行末添加默认的换行字符。
print() 调用打印\b 退格键字符时，总是传入 flush=True


18.5 控制鼠标交互

18.5.1 点击鼠标
>>> import pyautogui
>>> pyautogui.click(10, 5)


 18.5.2 拖动鼠标
import pyautogui, time
time.sleep(5)
pyautogui.click() # click to put drawing program in focus
distance = 200
while distance > 0:
    pyautogui.dragRel(distance, 0, duration=0.2) # move right
    distance = distance - 5
    pyautogui.dragRel(0, distance, duration=0.2) # move down
    pyautogui.dragRel(-distance, 0, duration=0.2) # move left
    distance = distance - 5
    pyautogui.dragRel(0, -distance, duration=0.2) # move up


18.5.3 滚动鼠标
>>> pyautogui.scroll(200)


18.6 处理屏幕

18.6.1 获取屏幕快照
>>> import pyautogui
>>> im = pyautogui.screenshot()

>>> im.getpixel((0, 0))
(244, 224, 224, 255)
>>> im.getpixel((50, 200))
(214, 214, 214, 255)

getpixel() 函数的返回值是一个 RGB 元组，包含 3 个整数，表
示像素的红绿蓝值


18.6.2 分析屏幕快照
>>> import pyautogui
>>> im = pyautogui.screenshot()
>>> im.getpixel((50, 200))
(130, 135, 144)
>>> pyautogui.pixelMatchesColor(50, 200, (130, 135, 144))
True
>>> pyautogui.pixelMatchesColor(50, 200, (255, 135, 144))
False
如果屏幕上指定的 x、 y 坐标处的像素与指定的颜色匹配， PyAutoGUI 的 pixelMatchesColor() 函数将返回 True。


18.7 项目：扩展 mouseNow 程序
#! python3
# mouseNow.py - Displays the mouse cursor's current position.
import pyautogui,time
print('Press Ctrl-C to quit.')
try:
    while True:
        # Get and print the mouse coordinates.
        time.sleep(1)
        x, y = pyautogui.position()
        positionStr = 'X: ' + str(x).rjust(4) + ' Y: ' + str(y).rjust(4)
        pixelColor = pyautogui.screenshot().getpixel((x, y))
        positionStr += ' RGB: (' + str(pixelColor[0]).rjust(3)
        positionStr += ', ' + str(pixelColor[1]).rjust(3)
        positionStr += ', ' + str(pixelColor[2]).rjust(3) + ')'
        print(positionStr, end='')
        print('\b' * len(positionStr), end='', flush=True)

except KeyboardInterrupt:
    print('\nDone.')

18.8 图像识别
>>> import pyautogui
>>> pyautogui.locateOnScreen('submit.png')
(643, 745, 70, 29)

>>> import pyautogui
>>> pyautogui.locateOnScreen('submit.png')
(643, 745, 70, 29)


>>> pyautogui.locateOnScreen('submit.png')
(643, 745, 70, 29)
>>> pyautogui.center((643, 745, 70, 29))
(678, 759)
>>> pyautogui.click((678, 759))


18.9 控制键盘

18.9.1 通过键盘发送一个字符串
>>> pyautogui.click(100, 100); pyautogui.typewrite('Hello world!')
对于 A 或!这样的字符， pyautogui 将自动模拟按住 Shift 键。

18.9.2 键名
>>> pyautogui.typewrite(['a', 'b', 'left', 'left', 'X', 'Y'])
>>> XYab

在 PyAutoGUI 中，这些键表示为短的字符串值： 'esc' 表示 Esc 键，'enter' 表示 Enter。
a', 'b', 'c', 'A', 'B', 'C', '1', '2', '3','!', '@', '#'，等等 单个字符的键
'enter'（ or 'return' or '\n'） 回车键
'esc' Esc 键
'shiftleft', 'shiftright' 左右 Shift 键
'altleft', 'altright' 左右 Alt 键
'ctrlleft', 'ctrlright' 左右 Ctrl 键
'tab'（ or '\t'） Tab 键
'backspace', 'delete' Backspace 和 Delete 键
'pageup', 'pagedown' Page Up 和 Page Down 键
'home', 'end' Home 和 End 键
'up', 'down', 'left', 'right' 上下左右箭头键
'f1', 'f2', 'f3'，等等 F1 至 F12 键
'volumemute', 'volumedown', 'volumeup' 静音、减小音量、放大音量键（有些键盘没有这些键，但你的操作系统仍能理解这些模拟的按键）
'pause' Pause 键
'capslock', 'numlock', 'scrolllock' Caps Lock， Num Lock 和 Scroll Lock 键
'insert' Ins 或 Insert 键
'printscreen' Prtsc 或 Print Screen 键
'winleft', 'winright' 左右 Win 键（在 Windows 上）
'command' Command 键（在 OS X 上）
'option' Option 键（在 OS X 上）


18.9.3 按下和释放键盘
>>> pyautogui.keyDown('shift')
>>> pyautogui.press('4')
>>> pyautogui.keyUp('shift')

18.9.4 热键组合
pyautogui.keyDown('ctrl')
pyautogui.keyDown('c')
pyautogui.keyUp('c')
pyautogui.keyUp('ctrl')

import pyautogui, time
def commentAfterDelay():
    pyautogui.click(100, 100)
    pyautogui.typewrite('In IDLE, Alt-3 comments out a line.')
    time.sleep(2)
    pyautogui.hotkey('alt', '3')
commentAfterDelay()3


18.10 复习 PyAutoGUI 的函数

本章介绍了许多不同函数，下面是快速的汇总参考：
moveTo（ x， y）将鼠标移动到指定的 x、 y 坐标。
moveRel（ xOffset， yOffset）相对于当前位置移动鼠标。
dragTo（ x， y）按下左键移动鼠标。
dragRel（ xOffset， yOffset）按下左键，相对于当前位置移动鼠标。
click（ x， y， button）模拟点击（默认是左键）。
rightClick() 模拟右键点击。
middleClick() 模拟中键点击。
doubleClick() 模拟左键双击。
mouseDown（ x， y， button）模拟在 x、 y 处按下指定鼠标按键。
mouseUp（ x， y， button）模拟在 x、 y 处释放指定键。
scroll（ units）模拟滚动滚轮。正参数表示向上滚动，负参数表示向下滚动。
typewrite（ message）键入给定消息字符串中的字符。
typewrite（ [key1， key2， key3]）键入给定键字符串。
press（ key）按下并释放给定键。
keyDown（ key）模拟按下给定键。
keyUp（ key）模拟释放给定键。
hotkey（ [key1， key2， key3]）模拟按顺序按下给定键字符串，然后以相反的顺序释放。
screenshot() 返回屏幕快照的 Image 对象（参见第 17 章关于 Image 对象的信息）。


18.11 项目：自动填表程序
#! python3
# formFiller.py - Automatically fills in the form.

import pyautogui, time

# Set these to the correct coordinates for your particular computer.
nameField = (648, 319)
submitButton = (651, 817)
submitButtonColor = (75, 141, 249)
submitAnotherLink = (760, 224)

formData = [{'name': 'Alice', 'fear': 'eavesdroppers', 'source': 'wand', 'robocop': 4, 'comments': 'Tell Bob I said hi.'},
            {'name': 'Bob', 'fear': 'bees', 'source': 'amulet', 'robocop': 4, 'comments': 'n/a'},
            {'name': 'Carol', 'fear': 'puppets', 'source': 'crystal ball', 'robocop': 1, 'comments': 'Please take the puppets out of the break room.'},
            {'name': 'Alex Murphy', 'fear': 'ED-209', 'source': 'money', 'robocop': 5, 'comments': 'Protect the innocent. Serve the public trust. Uphold the law.'},
            ]

pyautogui.PAUSE = 0.5

for person in formData:
    # Give the user a chance to kill the script.
    print('>>> 5 SECOND PAUSE TO LET USER PRESS CTRL-C <<<')
    time.sleep(5)

    # Wait until the form page has loaded.
    while not pyautogui.pixelMatchesColor(submitButton[0], submitButton[1], submitButtonColor):
        time.sleep(0.5)

    print('Entering %s info...' % (person['name']))
    pyautogui.click(nameField[0], nameField[1])

    # Fill out the Name field.
    pyautogui.typewrite(person['name'] + '\t')

    # Fill out the Greatest Fear(s) field.
    pyautogui.typewrite(person['fear'] + '\t')

    # Fill out the Source of Wizard Powers field.
    if person['source'] == 'wand':
        pyautogui.typewrite(['down', '\t'])
    elif person['source'] == 'amulet':
        pyautogui.typewrite(['down', 'down', '\t'])
    elif person['source'] == 'crystal ball':
        pyautogui.typewrite(['down', 'down', 'down', '\t'])
    elif person['source'] == 'money':
        pyautogui.typewrite(['down', 'down', 'down', 'down', '\t'])

    # Fill out the Robocop field.
    if person['robocop'] == 1:
        pyautogui.typewrite([' ', '\t'])
    elif person['robocop'] == 2:
        pyautogui.typewrite(['right', '\t'])
    elif person['robocop'] == 3:
        pyautogui.typewrite(['right', 'right', '\t'])
    elif person['robocop'] == 4:
        pyautogui.typewrite(['right', 'right', 'right', '\t'])
    elif person['robocop'] == 5:
        pyautogui.typewrite(['right', 'right', 'right', 'right', '\t'])

    # Fill out the Additional comments field.
    pyautogui.typewrite(person['comments'] + '\t')

    # Click Submit.
    pyautogui.press('enter')

    # Wait until form page has loaded.
    print('Clicked Submit.')
    time.sleep(5)

    # Click the Submit another response link.
    pyautogui.click(submitAnotherLink[0], submitAnotherLink[1])





