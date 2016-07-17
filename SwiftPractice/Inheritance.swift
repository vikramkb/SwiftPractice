//
//  Inheritance.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Inheritance {
    func start() {
        baseSubClass()
        override()
        preventingOverrides()
    }
    
    func baseSubClass() {
        print("----------------------- base class ------------------------")
        
        class Vehicle {
            var currentSpeed = 0.0
            var description: String {
                return "traveling at \(currentSpeed) miles per hour"
            }
            func makeNoise() {
                // do nothing - an arbitrary vehicle doesn't necessarily make a noise
            }
        }

        class Bicycle: Vehicle {
            var numOfpassengers = 2
        }
        let myCycle = Bicycle()
        print("currentSpeed = \(myCycle.currentSpeed), num of passengers = \(myCycle.numOfpassengers)")
    }
    
    //A subclass can provide its own custom implementation of an instance method, type method, instance property, type property, or subscript that it would otherwise inherit from a superclass. This is known as overriding.
    func override() {
        print("----------------------- override ------------------------")
        class Vehicle {
            func start() {
               print("Vehicle:start")
            }
        }
        
        class Car : Vehicle {
            override func start() {
                print("Car:start")
            }
        }
        
        func start(vehicle: Vehicle) {
            vehicle.start()
        }
        
        start(Car())
    }
    
    func preventingOverrides() {
        print("----------------------- preventing overrides ------------------------")
        class Vehicle {
            final func start() {
                print("Vehicle:start")
            }
        }
        class Car : Vehicle {
//            override func start() {
//                print("Car:start")
//            }
        }
        print("cannot override final methods or properties")
    }
}