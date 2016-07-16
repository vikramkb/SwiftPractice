//
//  Deinitialization.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/16/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

//Swift automatically deallocates your instances when they are no longer needed, to free up resources.
//Swift handles the memory management of instances through automatic reference counting (ARC)
//Typically you don’t need to perform manual cleanup when your instances are deallocated. However, when you are working with your own resources, you might need to perform some additional cleanup yourself.
class DeInitialization: NSObject {
    func start() {
        deInitialization()
    }
    
    func deInitialization() {
        print("----------------------- de initialization ------------------------")
        class A {
            var file = String("file1.txt")
            init() {
                print("init - open file")
            }
            deinit {
                print("deinit - closing file")
            }
        }
        
        var _ = A()
    }
}
