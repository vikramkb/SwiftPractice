//
//  Generics.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Ball {
    var size = 0
    init(_ size : Int) {
        self.size = size
    }
}
func ==(lhs: Ball, rhs: Ball) -> Bool {
    return lhs.size == rhs.size
}

extension Ball : Equatable {
    
}

protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}


class Generics {
    func start() {
        theProblemThatGenericsSolve()
        genericFunctions()
        namingTypeParameters()
        typeConstraintsInAction()
        associatedTypes()
        whereClause()
    }
    
    func theProblemThatGenericsSolve() {
        print("----------------------- the problem that generics solve ------------------------")
        
        func swapTwoInts(inout a: Int, inout _ b: Int) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        
        var someInt = 3
        var anotherInt = 107
        print("before swap a = \(someInt), and b = \(anotherInt)")
        swapTwoInts(&someInt, &anotherInt)
        print("after swap a = \(someInt), and b = \(anotherInt)")
        print("same function of swap for Double cannot be used")
    }
    
    func genericFunctions() {
        print("----------------------- generic functions ------------------------")
        
        func swapTwoValues<T>(inout a: T, inout _ b: T) {
            let temporaryA = a
            a = b
            b = temporaryA
        }
        var aInt = 3, bInt = 5
        print("before swap (\(aInt), \(bInt))")
        swapTwoValues(&aInt, &bInt)
        print("after swap (\(aInt), \(bInt))")
        var aStr = "first", bStr = "second"
        print("before swap (\(aStr), \(bStr))")
        swapTwoValues(&aStr, &bStr)
        print("after swap (\(aStr), \(bStr))")
    }
    
    func namingTypeParameters() {
        print("----------------------- naming type parameters ------------------------")
        
        //        In addition to generic functions, Swift enables you to define your own generic types. These are custom classes, structures, and enumerations that can work with any type, in a similar way to Array and Dictionary.
        struct Stack<Element> {
            var items = [Element]()
            mutating func push(item: Element) {
                items.append(item)
            }
            mutating func pop() -> Element {
                return items.removeLast()
            }
        }
        
        var stackOfStrings = Stack<String>()
        stackOfStrings.push("uno")
        stackOfStrings.push("dos")
        stackOfStrings.push("tres")
        stackOfStrings.push("cuatro")
        print("last element = \(stackOfStrings.pop())")
        print("next last element = \(stackOfStrings.pop())")
        print("next last element = \(stackOfStrings.pop())")

    }
    
    func typeConstraintsInAction() {
        print("----------------------- type constraints in action ------------------------")
    
        //generic type should be a type of Equtable
        func findIndex<T: Equatable>(array: [T], _ valueToFind: T) -> Int? {
            for (index, value) in array.enumerate() {
                if value == valueToFind {
                    return index
                }
            }
            return nil
        }
        
        print("1 found in [10, 20, 1, 30, 50] at \(findIndex([10, 20, 1, 30, 50], 1)!) index")
        let balls = [Ball(2), Ball(5), Ball(3), Ball(1)]
        
        print("Ball(5) found in [Ball(2), Ball(5), Ball(3), Ball(1)] at \(findIndex(balls, Ball(5))!)")
    }
    
    func associatedTypes() {
        print("----------------------- associated types ------------------------")
        print("you are lazy. don't leave me. you should do....")
        
//        struct IntStack : Container{
//            // original IntStack implementation
//            var items = [Int]()
//            mutating func push(item: Int) {
//                items.append(item)
//            }
//            mutating func pop() -> Int {
//                return items.removeLast()
//            }
//            // conformance to the Container protocol
//            typealias ItemType = Int
//            mutating func append(item: Int) {
//                self.push(item)
//            }
//            var count: Int {
//                return items.count
//            }
//            subscript(i: Int) -> Int {
//                return items[i]
//            }
//        }
        
    }
    
    func whereClause() {
        print("----------------------- where clause ------------------------")
        print("you are lazy. don't leave me. you should do....")
    }
}