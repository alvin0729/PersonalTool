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







































