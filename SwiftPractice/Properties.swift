//
//  Properties.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/10/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation
class Properties: NSObject {
    func start() {
        storedProperties()
        lazyStoredProperties()
        compoundProperties()
        readOnlyCompoundProperties()
        propertyObservers()
        typePropertySyntax()
    }

    //let on structures applies to the properties inside the structure. The same is not true with classes as they are references.
    func storedProperties() {
        print("----------------------- stored properties ------------------------")
        struct FixedLengthRange {
            var firstValue: Int
            let length: Int
        }
        
        var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
        // the range represents integer values 0, 1, and 2
        rangeOfThreeItems.firstValue = 6
        // the range now represents integer values 6, 7, and 8
        print("first value = \(rangeOfThreeItems.firstValue) and the length is \(rangeOfThreeItems.length)")
        
        let rangeOfFourItems = FixedLengthRange(firstValue: 0, length: 4)
        // this range represents integer values 0, 1, 2, and 3
//        rangeOfFourItems.firstValue = 6
        // this will report an error, even though firstValue is a variable property
        print("first value = \(rangeOfFourItems.firstValue) and the length is \(rangeOfFourItems.length)")
        
        class FixedRangeClass {
            var firstValue: Int
            let length: Int
            init(firstValue : Int, length : Int) {
                self.firstValue = firstValue
                self.length = length
            }
        }
        
        let rangeOfFive = FixedRangeClass(firstValue: 0, length: 5)
        rangeOfFive.firstValue = 5 //changes firstValue though rangeOfFive is let
        print("first value = \(rangeOfFive.firstValue) and the length is \(rangeOfFive.length)")
    }
    
    //when the initialization takes time or costlier, lazy initialization is preferred. it may or may not be called sometimes
    func lazyStoredProperties() {
        print("----------------------- lazy stored properties ------------------------")
        class DataImporter{
            init() {
                print("data importer initialized lazily when it is accessed")
            }
            func startImport() {
            
            }
        }
        class DataManager {
            lazy var importer = DataImporter()
            var data = [String]()
            init() {
                print("data manager initialize")
            }
            func startImport() {
                importer.startImport()
            }
        }
        
        let dataManager = DataManager()
        print("before accessing lazy property")
        dataManager.startImport()
    }
    
    func compoundProperties() {
        print("----------------------- compound properties ------------------------")
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            var center: Point {
                get {
                    let centerX = origin.x + (size.width / 2)
                    let centerY = origin.y + (size.height / 2)
                    return Point(x: centerX, y: centerY)
                }
                set(newCenter) {
                    origin.x = newCenter.x - (size.width / 2)
                    origin.y = newCenter.y - (size.height / 2)
                }
            }
        }
        var square = Rect(origin: Point(x: 0.0, y: 0.0),
                          size: Size(width: 10.0, height: 10.0))
        let initialSquareCenter = square.center
        print("initial center : square.origin is now at (\(initialSquareCenter.x), \(initialSquareCenter.y))")
        
        square.center = Point(x: 15.0, y: 15.0)
        print("updated center : square.origin is now at (\(square.origin.x), \(square.origin.y))")
        // Prints "square.origin is now at (10.0, 10.0)"
    }
    
    func readOnlyCompoundProperties()  {
        print("----------------------- read only compound properties ------------------------")
        struct Cuboid {
            var width = 0.0, height = 0.0, depth = 0.0
            var volume: Double { //readonly compound properties
                return width * height * depth
            }
        }
        let fourByFiveByTwo = Cuboid(width: 4.0, height: 5.0, depth: 2.0)
        print("the volume of fourByFiveByTwo is \(fourByFiveByTwo.volume)")
        // Prints "the volume of fourByFiveByTwo is 40.0"

    }
    
    // oldValue and newValue are the default names to refer in willSet and didSet
    func propertyObservers() {
        print("----------------------- property observers ------------------------")
        class StepCounter {
            var totalSteps: Int = 0 {
                willSet(newTotalSteps) { // this is called before updating the property
                    print("About to set totalSteps to \(newTotalSteps)")
                }
                didSet { // called after setting the property
                    if totalSteps > oldValue  {
                        print("Added \(totalSteps - oldValue) steps")
                    }
                }
            }
        }
        let stepCounter = StepCounter()
        stepCounter.totalSteps = 200
        // About to set totalSteps to 200
        // Added 200 steps
        stepCounter.totalSteps = 360
        // About to set totalSteps to 360
        // Added 160 steps
        stepCounter.totalSteps = 896
        // About to set totalSteps to 896
        // Added 536 steps
        
    }
    
    //class scope like static in c++ or java
    func typePropertySyntax() {
        print("----------------------- type property syntax ------------------------")
        struct SomeStructure {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 1
            }
        }
        enum SomeEnumeration {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 6
            }
        }
        class SomeClass {
            static var storedTypeProperty = "Some value."
            static var computedTypeProperty: Int {
                return 27
            }
            class var overrideableComputedTypeProperty: Int {
                return 107
            }
        }
        
        print(SomeStructure.storedTypeProperty)
        // Prints "Some value."
        SomeStructure.storedTypeProperty = "Another value."
        print(SomeStructure.storedTypeProperty)
        // Prints "Another value."
        print(SomeEnumeration.computedTypeProperty)
        // Prints "6"
        print(SomeClass.computedTypeProperty)
        // Prints "27"
    }
}