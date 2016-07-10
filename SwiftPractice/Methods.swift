//
//  Methods.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/10/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Methods: NSObject {
    func start() {
        instanceMethods()
        externalParameters()
        modifyingValueTypesWithinInstanceMethods()
        assigningSelfToMutatingMethod()
        typeOrStaticMethods()
    }
    
    func instanceMethods() {
        print("----------------------- type property syntax ------------------------")
        class Counter {
            var count = 0
            func increment() {
                count += 1
            }
            func incrementBy(amount: Int) {
                count += amount
            }
            func reset() {
                count = 0
            }
        }
        
        let counter = Counter()
        print("count = \(counter.count)")
        // the initial counter value is 0
        counter.increment()
        print("count = \(counter.count)")
        // the counter's value is now 1
        counter.incrementBy(5)
        print("count = \(counter.count)")
        // the counter's value is now 6
        counter.reset()
        print("count = \(counter.count)")
        // the counter's value is now 0
    }
    
    func externalParameters() {
        print("----------------------- external parameters ------------------------")
        class Counter {
            var count: Int = 0
            //external name and internal name from the second argument is same.
            //same is not true for the first argument
            func incrementBy(amount: Int, numberOfTimes: Int) {
                count += amount * numberOfTimes
            }
            
            func incrementBy(amountExtName amount: Int, numberOfTimes: Int) {
                count += amount * numberOfTimes
            }
        }
        
        let counter = Counter()
        counter.incrementBy(5, numberOfTimes: 3) //first argument can not use external name as it doesn't get the name by default
        print(counter.count)
        // counter value is now 15
        counter.incrementBy(amountExtName: 5, numberOfTimes: 3) //now first argument can use external name
        print(counter.count)
        // counter value is now 30
    }
    
    func modifyingValueTypesWithinInstanceMethods() {
        print("----------------------- modify value types within instance methods ------------------------")
        struct Point {
            var x = 0.0, y = 0.0
            //using mutating value types like struct and enums can refer instance variables directly in function for modification. Otherwise they are not allowed to be modified
            mutating func moveByX(deltaX: Double, y deltaY: Double) {
                x += deltaX
                y += deltaY
            }
        }
        
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveByX(2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // Prints "The point is now at (3.0, 4.0)"
    }
    
    func assigningSelfToMutatingMethod() {
        print("----------------------- assigning self to mutating method ------------------------")
        
        struct Point {
            var x = 0.0, y = 0.0
            mutating func moveByX(deltaX: Double, y deltaY: Double) {
                self = Point(x: x + deltaX, y: y + deltaY)
            }
        }
        var somePoint = Point(x: 1.0, y: 1.0)
        somePoint.moveByX(2.0, y: 3.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // Prints "The point is now at (3.0, 4.0)"
        somePoint.moveByX(1.0, y: 1.0)
        print("The point is now at (\(somePoint.x), \(somePoint.y))")
        // Prints "The point is now at (4.0, 5.0)"
        
        
        //  Mutating methods for enumerations can set the implicit self parameter to be a different case from the same enumeration:
        enum TriStateSwitch {
            case Off, Low, High
            mutating func next() {
                switch self {
                case Off:
                    self = Low
                case Low:
                    self = High
                case High:
                    self = Off
                }
            }
            func state() -> TriStateSwitch{
                return self
            }
        }
        var ovenLight = TriStateSwitch.Low
        ovenLight.next()
        if ovenLight.state() == .High {
            print("Oven switch is in high")
        }
        //print Oven switch is in high

        ovenLight.next()
        if ovenLight.state() == .Off {
            print("Oven switch is in off")
        }
        //print "Oven switch is in off"
    }
    
    func typeOrStaticMethods() {
        print("----------------------- type or static methods ---------------------")
        class SomeClass {
            class func someTypeMethod() {
                print("this is type or static method")
            }
        }
        SomeClass.someTypeMethod()
        
        
        //static variables can only accessible in static methods.
        //player playing the game, level tracker keeps track of the information of how many levels unlocked and which is the current level
        struct LevelTracker {
            static var highestUnlockedLevel = 1
            static func unlockLevel(level: Int) {
                if level > highestUnlockedLevel { highestUnlockedLevel = level }
            }
            static func levelIsUnlocked(level: Int) -> Bool {
                return level <= highestUnlockedLevel
            }
            var currentLevel = 1
            mutating func advanceToLevel(level: Int) -> Bool {
                if LevelTracker.levelIsUnlocked(level) {
                    currentLevel = level
                    return true
                } else {
                    return false
                }
            }
        }
        
        class Player {
            var tracker = LevelTracker()
            let playerName: String
            func completedLevel(level: Int) {
                LevelTracker.unlockLevel(level + 1)
                tracker.advanceToLevel(level + 1)
            }
            init(name: String) {
                playerName = name
            }
        }
        
        var player = Player(name: "Argyrios")
        player.completedLevel(1)
        print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")
        // Prints "highest unlocked level is now 2"
        
        player = Player(name: "Beto")
        if player.tracker.advanceToLevel(6) {
            print("player is now on level 6")
        } else {
            print("level 6 has not yet been unlocked")
        }
        // Prints "level 6 has not yet been unlocked"

    }
}