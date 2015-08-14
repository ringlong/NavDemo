//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var a = 10 % 2.5
a = 10 % 4
a %= 1
let name = "red"
var uName: String?
var b = uName ?? name

count(str)

var array = ["1", "2", "3", "4", "5"]
println("\(count(array))")
array.count
array.isEmpty

name.hasPrefix(str)

array[1..<3] = ["6", "7"]
array[1...3] = ["8", "9", "10"]
array

for (index, value) in enumerate(array) {
    println("array \(index) \(value)")
}

var list = Array(count: 6, repeatedValue: 4.0)

var lll: Dictionary<String, String> = ["T": "Tykyo"]

let anotherPoint = (6, 0)

switch anotherPoint {
    case (let x, 0): // 这里不需要修改x的值，所以声明为let，即常量
        println("on the x-axis with an x value of \(x)")
    case (0, let y):
        println("on the y-axis with a y value of \(y)")
    case let (x, y): // 对于这里，没有使用Default，其实这里这么写法就相当于default:
        println("somewhere else at (\(x), \(y))")
}

// 使用where语句来检测额外的条件
let yetAnotherPoint = (3, -1)
switch yetAnotherPoint {
    case let (x, y) where x == y: // 使用值绑定，要求x与y相等
        println("(\(x), \(y)) is on the line x == y")
    case let (x, y) where x == -y:// 使用值绑定，要求x与-y相等
        println("(\(x), \(y)) is on the line x == -y")
    case let (x, y):// 使用值绑定,相当于default
        println("(\(x), \(y)) is just some arbitrary point")
}





