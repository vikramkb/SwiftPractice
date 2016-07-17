//
//  Extensions.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

/*
 Extensions add new functionality to an existing class, structure, enumeration, or protocol type. 
 
 Add computed instance properties and computed type properties
 
 Define instance methods and type methods
 
 Provide new initializers
 
 Define subscripts
 
 Define and use new nested types
 
 Make an existing type conform to a protocol
 
 */
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

class Distance {
    var distance = Double(0.0)
    init(km : Double) {
        self.distance = km
    }
}

extension Distance {
    convenience init(miles : Double) {
        self.init(km: miles / 0.62137)
    }
    
    func getInMeters() -> Double{
        return distance * 1000
    }
    
    subscript(index : Double) -> Double{
        return index / 0.62137
    }
    
}

extension Int {
    mutating func square() {
        self = self * self
    }
}


class Extension {
    func start() {
        computedProperties()
        extendingInitializers()
        addInstanceMethods()
        mutatingInstanceMethods()
        extedingSubScript()
    }
    func computedProperties() {
        print("----------------------- computed properties ------------------------")
        
        let oneInch = 25.4.mm
        print("One inch is \(oneInch) meters")
        // Prints "One inch is 0.0254 meters"
        let threeFeet = 3.ft
        print("Three feet is \(threeFeet) meters")
        // Prints "Three feet is 0.914399970739201 meters"
    }
    
    func extendingInitializers() {
        print("----------------------- extending initializers ------------------------")
        let km = Distance(km: 100)
        print("kilo meters = \(km.distance)")
        print("100 miles = \(Distance(miles: 100).distance) kms")
    }
    
    func addInstanceMethods() {
        print("----------------------- adding instance methods ------------------------")
        let km = Distance(km: 1)
        print("1 km = \(km.getInMeters()) meters")
    }
    
    func mutatingInstanceMethods() {
        print("----------------------- mutating instance methods ------------------------")
        var someInt = 3
        someInt.square()
        print("mutated square distance = \(someInt)")
    }
    
    func extedingSubScript() {
        print("----------------------- extended sub script ------------------------")
        let km = Distance(km: 1)
        print("10 miles = \(km[10]) kms")
        
    }
    
}