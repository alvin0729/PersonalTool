import UIKit
//: ## 位运算符
//: ### 按位取反运算符
let initialBits : UInt8 = 0b00001111
let invertedBits = ~initialBits
//: ### 按位与运算符
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFourBits = firstSixBits & lastSixBits
//: ### 按位或运算符
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
let combinedbits = someBits | moreBits
//: ### 按位异或运算符
let firstBits:UInt8 = 0b00010100
let otherBits:UInt8 = 0b00000101
let outputBits = firstBits ^ otherBits
//: ### 按位左移、右移运算符
//: ### 无符号整数的移位运算符
let shiftBits:UInt8 = 4
shiftBits << 1
shiftBits << 2
shiftBits << 5
shiftBits << 6
shiftBits >> 2
let pink:UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16
let greenComponent = (pink & 0x00FF00) >> 8
let blueComponent = (pink & 0x0000FF)
//: ### 有符号整数的移位运算符
//: 负数的存储方式略有不同。它存储的值的绝对值等于 2 的 n 次方减去它的实际值（也就是数值位表示的值），这里的 n 为数值位的比特位数。一个 8 比特位的数有 7 个比特位是数值位，所以是 2 的 7 次方，即 128。\
//: - 当对整数进行按位右移运算时，遵循与无符号整数相同的规则，但是对于移位产生的空白位使用符号位进行填充，而不是用 0。
//: ## 溢出运算符
var potentialOverflow0 = Int16.max
// potentialOverflow equals 32767, which is the maximum value an Int16 can hold
//potentialOverflow += 1
// this causes an error

//Overflow addition (&+)
//Overflow subtraction (&-)
//Overflow multiplication (&*)

//: ### Value Overflow
var unsignedOverflow1 = UInt8.max
// unsignedOverflow equals 255, which is the maximum value a UInt8 can hold
unsignedOverflow1 = unsignedOverflow1 &+ 1
// unsignedOverflow is now equal to 0


var unsignedOverflow2 = UInt8.min
// unsignedOverflow equals 0, which is the minimum value a UInt8 can hold
unsignedOverflow2 = unsignedOverflow2 &- 1
// unsignedOverflow is now equal to 255


var signedOverflow = Int8.min
// signedOverflow equals -128, which is the minimum value an Int8 can hold
signedOverflow = signedOverflow &- 1
// signedOverflow is now equal to 127

//: ### Precedence and Associativity
2 + 3 % 4 * 5
// this equals 17

//: ### Operator Methods
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector
// combinedVector is a Vector2D instance with values of (5.0, 5.0)

//: #### Prefix and Postfix Operators
extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}
let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
// negative is a Vector2D instance with values of (-3.0, -4.0)
let alsoPositive = -negative
// alsoPositive is a Vector2D instance with values of (3.0, 4.0)

//: ####  Compound Assignment Operators
extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}
var original = Vector2D(x: 1.0, y: 2.0)
let vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
// original now has values of (4.0, 6.0)

//: #### Equivalence Operators
extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}
let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("These two vectors are equivalent.")
}
// Prints "These two vectors are equivalent."


//: ### Custom Operators
prefix operator +++
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}
var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled now has values of (2.0, 8.0)
// afterDoubling also has values of (2.0, 8.0)

//: ### Precedence for Custom Infix Operators
infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}
let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
// plusMinusVector is a Vector2D instance with values of (4.0, -2.0)





