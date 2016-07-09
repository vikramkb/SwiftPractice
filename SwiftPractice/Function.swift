//
//  Function.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/9/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Function: NSObject {
    func start() {
        callingFunctions()
        defaultArguments()
        externalParameterNames()
        variadicParameters()
        inOutParameters()
        functionTypes()
        functionTypesAsParameters()
        functionTypesAsReturnType()
        nestedFunctions()
    }
    
    func callingFunctions() {
        print("----------------------- functions ------------------------")
        //takes name and return greet message. personName is the external name.
        print(sayHello(personName: "vikram"))
        print(sayHelloAgain("vikram"))
        //takes two parameters and return greet message. alreadyGreeted is the external name
        print(sayHello("vikram", alreadyGreeted: true))
        let minMaxTuple = minMax([10, 2, 1, 20, 30, 5])
        if minMaxTuple != nil {
            print("min = \(minMaxTuple!.min), max = \(minMaxTuple!.max)")
        }
    }
    
    func defaultArguments() {
        print("----------------------- default args ------------------------")
        work() //default parameter will be taken
        
    }

    func externalParameterNames() {
        print("----------------------- external param names ------------------------")
        externalParameters(firstParameter: 1, secondParameter: 2)
        ommitExternalParameters(1, 2)
    }
    
    func variadicParameters() {
        print("----------------------- variadic parameters ------------------------")
        print(arithmeticMean(1, 2, 3, 4, 5))
        // returns 3.0, which is the arithmetic mean of these five numbers
        print(arithmeticMean(3, 8.25, 18.75))
        // returns 10.0, which is the arithmetic mean of these three numbers
        
    }

    func inOutParameters() {
        print("----------------------- in out parameters ------------------------")
        var someInt = 3
        var anotherInt = 107
        print("before swapping : someInt = \(someInt), and anotherInt = \(anotherInt)")
        swapTwoInts(&someInt, &anotherInt)
        print("after swapping : someInt = \(someInt), and anotherInt = \(anotherInt)")
    }
    
    func functionTypes() {
        print("----------------------- function types ------------------------")
        var mathFunction: (Int, Int) -> Int = addTwoInts
        print(mathFunction(20, 3))
        mathFunction = multiplyTwoInts
        print(mathFunction(20, 3))
    }
    
    func functionTypesAsParameters() {
        print("----------------------- function types as parameters ------------------------")
        print(mathTwoNumbers(addTwoInts, 20, 3))
    }
    
    func functionTypesAsReturnType() {
        print("----------------------- function types as return type ------------------------")
        print(getMathFunction("*")(10, 20))
    }
    
    //function inside the function
    func nestedFunctions() {
        print("----------------------- nested functions ------------------------")
        func firstName() -> String {
            return "Vikram"
        }
        func lastName() -> String {
            return "K"
        }
        print("My name is \(firstName()) \(lastName())")
    }
 
    func getMathFunction(symbol : String) -> (Int, Int) -> Int {
        switch symbol {
        case "+":
            return addTwoInts
        case "*":
            return multiplyTwoInts
        default:
            return addTwoInts
        }
    }
    
    func mathTwoNumbers(mathFunction: (Int, Int) -> Int, _ first: Int, _ second: Int) -> Int{
        return mathFunction(first, second)
    }
    
    func addTwoInts(first: Int, second: Int) -> Int {
        return first + second
    }

    func multiplyTwoInts(first: Int, second: Int) -> Int {
        return first * second
    }
    
    func work(companyName: String = "ThoughtWorks") {
        print("I am working in \(companyName)")
    }
    
    func ommitExternalParameters(param1: Int, _ param2 : Int) {
        print("parameters = \(param1), \(param2)")
    }

    //external name for the first argument is firstParameter. 
    //from second parameter, name of the variable is external parameter by default
    func externalParameters(firstParameter param1: Int, secondParameter : Int) {
        print("parameters = \(param1), \(secondParameter)")
    }
    
    func minMax(array : [Int]) -> (min: Int, max : Int)? {
        guard !array.isEmpty else {
            return nil
        }
        var min, max : Int
        min = array[0]
        max = array[0]
        for val in array {
            if(min > val) {
                min = val
            }
            if(max < val) {
                max = val
            }
        }
        return (min, max)
    }
    
    //by default external name is same as variable name from 2nd argument. The same rule is not applied for the first parameter
    private func sayHello(personName: String, alreadyGreeted: Bool) -> String {
        if alreadyGreeted {
            return sayHelloAgain(personName)
        } else {
            return sayHello(personName: personName)
        }
    }
    
    //personName external name must be used while calling this method
    private func sayHello(personName name: String) -> String {
        let greeting = "Hello, " + name + "!"
        return greeting
    }
    
    private func sayHelloAgain(personName: String) -> String {
        return "Hello again, " + personName + "!"
    }
    
    private func arithmeticMean(numbers: Double...) -> Double {
        var total: Double = 0
        for number in numbers {
            total += number
        }
        return total / Double(numbers.count)
    }
    
    private func swapTwoInts(inout a: Int, inout _ b: Int) {
        let temporaryA = a
        a = b
        b = temporaryA
    }

}