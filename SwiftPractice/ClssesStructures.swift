//
//  ClssesStructures.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/10/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class ClassesStructures: NSObject {
    func start() {
        structuresAreValueTypes()
        classesAreReferenceTypes()
        identyOperator()
    }
    
    func structuresAreValueTypes() {
        print("----------------------- structures are value types ------------------------")
        struct Resolution {
            var width : Int
            var height : Int
        }
        
        let officeTv = Resolution(width: 1920, height: 1080)
        var myTv = officeTv
        myTv.width = 800
        myTv.height = 600
        
        print("office tv width = \(officeTv.width), height = \(officeTv.height)")
        print("my tv width = \(myTv.width), height = \(myTv.height)")
    }
    
    func classesAreReferenceTypes() {
        print("----------------------- classes are reference types ------------------------")
        class Resolution {
            var width : Int
            var height : Int
            init(width: Int = 0, height: Int = 0) {
                self.width = width
                self.height = height
            }
        }
        
        let officeTv = Resolution(width: 1920, height: 1080)
        let myTv = officeTv
        myTv.width = 800
        myTv.height = 600
        
        print("office tv width = \(officeTv.width), height = \(officeTv.height)")
        print("my tv width = \(myTv.width), height = \(myTv.height)")
    }
    
    //structures and enums cannot use === and !== as they are value types. 
    func identyOperator() {
        print("----------------------- identy operator ------------------------")
        class Resolution {
            var width : Int
            var height : Int
            init(width: Int = 0, height: Int = 0) {
                self.width = width
                self.height = height
            }
        }
        var tv1 = Resolution(width: 800, height: 600)
        var tv2 = tv1
        tv2.width = 810 // change this in both tv and anotherTv
        if tv1 === tv2 {
            print("both tvs are same")
        }else{
            print("both tvs are different")
        }
        //prints "both tvs are of same type"
        
        tv1 = Resolution(width: 800, height: 600)
        tv2 = Resolution(width: 800, height: 600)
        if tv1 !== tv2 {
            print("these two are diff tvs")
        }
        //prints "these two are diff tvs
    }
    
}