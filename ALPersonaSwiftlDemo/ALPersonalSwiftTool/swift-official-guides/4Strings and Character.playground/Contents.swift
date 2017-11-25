import UIKit
/*:>每一个字符串都是由编码无关的Unicode字符串组成*/
//:### 字符串字面量String Literals
//可以用于为常量和变量提供初始值
let someString = "Some string literal value"
//:### 初始化空字符串(Initializing an Empty String)
var emptyString = ""                 //空字符串字面量
var anotherEmptyString = String()     //初始化方法
//两个字符串均为空并等价
if emptyString.isEmpty{
    print("Nothing to see here")
}
//:### 字符串可变性(string mutability)
var variableString = "Horse"
variableString += " and carriage"
let constantString = "Highlander"
//constantString += " and another Highlander"

//:### 字符串是值类型(strings are value types)
//使用字符(working with characters)
for character in "Dog!?".characters{
    print(character)
}
let exclamationMark:Character = "!"
//: - callout(Note):字符串可以通过传递一个值类型的Character的数组作为自变量来初始化
let catCharacters:[Character] = ["C","a","t","!","?"]
let catString = String(catCharacters)
print(catString)
//:### 连接字符串和字符（Concatenating Strings and Characters)
let string1 = "hello"
let string2 = " there"
var welcome = string1 + string2
var instuction = "look over"
instuction += string2

let exclamationMark1: Character = "!"
welcome.append(exclamationMark1)

//:### 字符串插值(string interpolation)
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
//:### Unicode
/*:>Unicode标量(Unicode Scalars):是对应字符或者修饰符的唯一的21位数字\
>字符串字面量的特殊字符（Special Characters in String Literals)
 */
let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHeart = "\u{1F496}"

//可扩展的字形群集（Extended Grapheme Clusters)
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}"
let precomposed: Character = "\u{D55C}"
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"
//可扩展的字符群集可以使包围记号的标量包围其他Unicode标量，作为一个单一的character值
let encloseEAcute: Character = "\u{E9}\u{20DD}"
//地域性指示符号的Unicode标量可以组合成一个单一character值
let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
//:### 计算字符数量（counting characters)
let unusualMenagerie = "Koala ?, Snail ?, Penguin ?, Dromedary ?"
print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")

var word = "cafe"
print("the number of characters in\(word) is \(word.characters.count)")
word += "\u{301}"
print("the number of characters in\(word) is \(word.characters.count)")
/*:
>NSString的length属性是利用UTF-16表示的16位代码单元数字，而不是Unicode可扩展的字符群集\
>当一个NSString的length属性被一个String值访问时，实际上是调用了utf16Count*/
//:### 访问和修改字符串(Accessing and Modifying a String)
/*:
 >Swift的字符串不能用整数（integer）做索引\
>endIndex属性不能作为一个字符串的有效下标，如果String是空串，startIndex/endIndex是相等的*/
let greeting = "Guten Tag!"
greeting[greeting.startIndex]
greeting[greeting.index(before: greeting.endIndex)]
greeting[greeting.index(after: greeting.startIndex)]
let index = greeting.index(greeting.startIndex, offsetBy: 7)
greeting[index]
//greeting[greeting.endIndex]
//greeting.index(after: endIndex)
/*:
 >试图获取越界索引对应的 Character，将引发一个运行时错误\
>使用characters属性的indices属性会创建一个包含全部索引的范围Range*/
for index in greeting.characters.indices{
    print("\(greeting[index])", terminator: " ")
}
//: - callout(注意):可以使用startIndex和endIndex属性或者index(before:),index(after),index(_:offsetBy:)方法在任意一个确认的并遵循Collection协议的类型里面，如上文所示使用在String中，您可以使用在Array、Dictionary和Set中
/*:[插入和删除(Inserting and Removing)](license)*/
//调用insert(_:atIndex:)
var welcome1 = "hello"
welcome1.insert("!", at: welcome1.endIndex)
welcome1.insert(contentsOf: " there".characters, at: welcome1.index(before: welcome1.endIndex))

welcome1.remove(at: welcome1.index(before: welcome1.endIndex))
print(welcome1)
let range = welcome1.index(welcome1.endIndex, offsetBy: -6)..<welcome1.endIndex
welcome1.removeSubrange(range)
print(welcome1)
//上述方法遵循RangeReplaceableCollection协议，同样的有Array、Dictionary和Set
//:### 比较字符串Comparing Strings
//String and Character Equality
let quotation = "We're a lot alike, you and I."
let sameQuotation = "We're a lot alike, you and I."
if quotation == sameQuotation{
    print("These two strings are considered equal")
}
//:- callout(注意): 如可扩展字符群集是由不同的Unicode标量构成的，只要它们有同样的语言意义和外观，就认为它们标准相等
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}

let latinCapitalLetterA: Character = "\u{41}"
let cyrillicCapitalLetterA: Character = "\u{0410}"
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent")
}
//:- callout(注意):在Swift中，字符串和字符并不区分地域
//前缀和后缀相等Prefix and Suffix Equality
let remeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]
var act1SceneCount = 0
for scene in remeoAndJuliet {
    if scene.hasPrefix("Act 1 "){
        act1SceneCount += 1
    }
}
print("There are \(act1SceneCount) scenes in Act 1")

var mansionCount = 0
var cellCount = 0
for scene in remeoAndJuliet {
    if scene.hasSuffix("Capulet's mansion") {
        mansionCount += 1
    }else if scene.hasSuffix("Friar Lawrence's cell"){
        cellCount += 1
    }
}
print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")

//:### 字符串的Unicode表示形式(Unicode Representations of Strings)
//代码单元：UTF-8、UTF-16、UTF-32
let dogString = "Dog??"
for codeUnit in dogString.utf8 {
    print("\(codeUnit) ",terminator: "")
}
print("")
