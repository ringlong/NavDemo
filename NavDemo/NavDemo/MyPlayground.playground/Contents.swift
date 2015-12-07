//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

func count(string: String) ->(vowels: Int, consonants: Int, others: Int) {
    var vowels = 0
    var consonants = 0
    var others = 0
    for c in string {
        switch String(c).lowercaseString {
        case "a", "o", "e", "i", "u":
            ++vowels
        case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n",
        "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
            ++consonants
        default:
            ++others
        }
    }
    return (vowels, consonants, others)
}

count("hello world")

func join(#lhsString: String, #rhsString: String, #joiner:String) -> String {
    return lhsString + joiner + rhsString
}

join(lhsString: "a", rhsString: "b", joiner: "c")

func join1(#originalString: String,
    #destinationString: String, withJoiner: String = " ") -> String {
    return originalString + withJoiner + destinationString
}

join1(originalString: "a", destinationString: "b", withJoiner: "")

func arithmeticMean(numbers: Double...) -> Double {
    var total = 0.0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithmeticMean(1, 2,4,4, 3,5)

func alignRight(var str: String, sum: Int, pad: Character) -> String {
    let amountToPad = sum - count(str)
    
    // 使用_表示忽略，因为这里没有使用到
    for _ in 1...amountToPad {
        str = String(pad) + str
    }
    
    return str
}

alignRight("abc", 10, "d")

func swap(inout lhs: Int, inout rhs: Int) {
    let tmp = lhs
    lhs = rhs
    rhs = tmp
}

var first = 3
var second = 4
// 这种方式会修改实参的值
swap(&first, &second)
println(first)

func addTwoInts(first: Int, second: Int) -> Int {
    return first + second
}
var change: (Int, Int)->Int = addTwoInts

change(2, 3)

func printMathResult(mathFunction: (Int, Int) -> Int, first: Int, second: Int) {
    println("Result: \(mathFunction(first, second))")
}

printMathResult(change, 3, 5)
printMathResult(change, 6, 7)

// 参数可以嵌套定义，在C、OC中是不可以嵌套的哦
func chooseStepFunction(backwards: Bool) -> ((Int) -> Int) {
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input + 1
    }
    
    return backwards ? stepBackward : stepForward
}

var names = ["Swift", "Arial", "Soga", "Donary"]

func backwards(firstString: String, secondString: String) -> Bool {
    return firstString > secondString // 升序排序
}
//var reversed = sort(names, backwards)

//var reversed = sort(&names)

//sort(&names, <)
//sort(&names) { (a, b) -> Bool in
//    return false
//}
//sort(&names, {a, b -> Bool in a > b})
//var reversed = sort(&names, { $0 > $1 })

var numbers = [10, 11, 13, 14, 15]
let strings = numbers.map {
    (var number) -> String in
    var output = ""
    while number > 0 {
        output = String(number % 10) + output
        number /= 10
    }
    return output;
}

println(strings)

enum CompassPoint {
    case North
    case South
    case East
    case West
}

var direction = CompassPoint.West
direction = .South

switch direction {
    case .North:
        println("Lots of planets have a north")
    case .South:
        println("Watch out for penguins")
    case .East:
        println("Where the sun rises")
    case .West:
        println("Where the skies are blue")
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}

enum Barcode {
    case UPCA(Int, Int, Int)
    case QRCode(String)
}

var nn = Barcode.UPCA(0, 11234_55678, 8)

let earthOrder = Planet.Earth
println(earthOrder)
