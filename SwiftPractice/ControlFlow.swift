//
//  ControlFlow.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/9/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class ControlFlow: NSObject {
    func start() -> Void {
        forInLoops()
        whileInLoops()
        conditionalStatment()
        switchStatement()
        tuplesInSwitch()
        whereInBindingsInSwitch()
        earlyExitUsingGuardClause()
    }
    
    func forInLoops() -> Void {
        print("----------------------- for in loops ------------------------")
        for index in 1...5 {
            print("\(index) times 5 is \(index * 5)")
        }
        
        let base = 3
        let power = 10
        var answer = 1
        // _ to ignore. Not used each value
        for _ in 1...power {
            answer *= base
        }
        print("\(base) to the power of \(power) is \(answer)")
        // Prints "3 to the power of 10 is 59049"
        
        let names = ["Anna", "Alex", "Brian", "Jack"]
        for name in names {
            print("Hello, \(name)!")
        }
        
        let numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
        for (animalName, legCount) in numberOfLegs {
            print("\(animalName)s have \(legCount) legs")
        }
    }
    
    func whileInLoops() -> Void {
        print("----------------------- while loop ------------------------")
        var num = 1
        print("multiples of 50 are")
        while num <= 50 {
            if 50 % num == 0 {
                print(num)
            }
            num = num + 1
        }
    }
    
    func repeatWhileLoop() -> Void {
        print("----------------------- repeat while loop ------------------------")
        var num = 1
        print("multiples of 50 are")
        repeat {
            if 50 % num == 0 {
                print(num)
            }
            num = num + 1
        }while num <= 50
    }
    
    func conditionalStatment() -> Void {
        print("----------------------- conditional statements ------------------------")
        var temperatureInFahrenheit = 30
        if temperatureInFahrenheit <= 32 {
            print("It's very cold. Consider wearing a scarf.")
        }
        // Prints "It's very cold. Consider wearing a scarf."

        temperatureInFahrenheit = 40
        if temperatureInFahrenheit <= 32 {
//            print("It's very cold. Consider wearing a scarf.")
        } else {
            print("It's not that cold. Wear a t-shirt.")
        }
        // Prints "It's not that cold. Wear a t-shirt."
    }
    
    //no follow through concept in switch like in c and c++
    func switchStatement() -> Void {
        print("----------------------- switch statement ------------------------")
        
        let someCharacter: Character = "e"
        switch someCharacter {
            case "a", "e", "i", "o", "u":
                print("\(someCharacter) is a vowel")
            case "b", "c", "d", "f", "g", "h", "j", "k", "l", "m",
                 "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
                print("\(someCharacter) is a consonant")
            default:
                print("\(someCharacter) is not a vowel or a consonant")
        }
        // Prints "e is a vowel"
        
        
        let approximateCount = 62
        let countedThings = "moons orbiting Saturn"
        var naturalCount: String
        switch approximateCount {
            case 0:
                naturalCount = "no"
            case 1..<5:
                naturalCount = "a few"
            case 5..<12:
                naturalCount = "several"
            case 12..<100:
                naturalCount = "dozens of"
            case 100..<1000:
                naturalCount = "hundreds of"
            default:
                naturalCount = "many"
        }
        print("There are \(naturalCount) \(countedThings).")
    }
    
    func tuplesInSwitch() -> Void {
        print("----------------------- tuples in switch ------------------------")
        //tuples can be used to test multiple values in the same switch statement
        let somePoint = (1, 1)
        switch somePoint {
        case (0, 0):
            print("(0, 0) is at the origin")
        case (_, 0):
            print("(\(somePoint.0), 0) is on the x-axis")
        case (0, _):
            print("(0, \(somePoint.1)) is on the y-axis")
        case (-2...2, -2...2):
            print("(\(somePoint.0), \(somePoint.1)) is inside the box")
        default:
            print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
        }
        // Prints "(1, 1) is inside the box"
    }
    
    func valueBindingsInSwitch() -> Void {
        print("----------------------- value bindings in switch ------------------------")
        let anotherPoint = (2, 0)
        switch anotherPoint {
            case (let x, 0): //x in print is binded temporarily
                print("on the x-axis with an x value of \(x)")
            case (0, let y): //y in print is binded temporarily
                print("on the y-axis with a y value of \(y)")
            case let (x, y):
                print("somewhere else at (\(x), \(y))")
        }
        // Prints "on the x-axis with an x value of 2"
    }
    
    func whereInBindingsInSwitch() -> Void {
        print("----------------------- where in value bindings in switch ------------------------")
        let yetAnotherPoint = (1, -1)
        switch yetAnotherPoint {
            case let (x, y) where x == y:
                print("(\(x), \(y)) is on the line x == y")
            case let (x, y) where x == -y:
                print("(\(x), \(y)) is on the line x == -y")
            case let (x, y):
                print("(\(x), \(y)) is just some arbitrary point")
        }
        // Prints "(1, -1) is on the line x == -y"
    }
    
    func controlTransfer() -> Void {
        print("----------------------- control transfer ------------------------")
        let puzzleInput = "great minds think alike"
        var puzzleOutput = ""
        for character in puzzleInput.characters {
            switch character {
            case "a", "e", "i", "o", "u", " ":
                continue
            default:
                puzzleOutput.append(character)
            }
        }
        print(puzzleOutput)
        // Prints "grtmndsthnklk"
        

        //
        let numberSymbol: Character = "三"  // Simplified Chinese for the number 3
        var possibleIntegerValue: Int?
        switch numberSymbol {
            case "1", "١", "一", "๑":
                possibleIntegerValue = 1
            case "2", "٢", "二", "๒":
                possibleIntegerValue = 2
            case "3", "٣", "三", "๓":
                possibleIntegerValue = 3
            case "4", "٤", "四", "๔":
                possibleIntegerValue = 4
            default:
                break //break in switch casues break the switch. default break is generally added to avoid the error.
        }
        if let integerValue = possibleIntegerValue {
            print("The integer value of \(numberSymbol) is \(integerValue).")
        } else {
            print("An integer value could not be found for \(numberSymbol).")
        }
        // Prints "The integer value of 三 is 3."
        
        let integerToDescribe = 5
        var description = "The number \(integerToDescribe) is"
        switch integerToDescribe {
            case 2, 3, 5, 7, 11, 13, 17, 19:
                description += " a prime number, and also"
                fallthrough // jumps to next case in this case default case
            default:
                description += " an integer."
        }
        print(description)
        // Prints "The number 5 is a prime number, and also an integer."
    }
    
    func earlyExitUsingGuardClause() -> Void {
        print("----------------------- early exit using guards ------------------------")
        greet(["name": "John"])
        // Prints "Hello John!"
        // Prints "I hope the weather is nice near you."
        greet(["name": "Jane", "location": "Cupertino"])
        // Prints "Hello Jane!"
        // Prints "I hope the weather is nice in Cupertino."
    }
    
    private func greet(person: [String: String]) {
        guard let name = person["name"] else {
            return
        }
        
        print("Hello \(name)!")
        
        guard let location = person["location"] else {
            print("I hope the weather is nice near you.")
            return
        }
        
        print("I hope the weather is nice in \(location).")
    }
    
}