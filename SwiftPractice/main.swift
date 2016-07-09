//
//  main.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/7/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation


class Main: NSObject {
    func start() -> Void {
        sectionBreak("Basics")
        let basics : Basics = Basics()
        basics.start()
        
        sectionBreak("Strings")
        let stringRef = StringRef()
        stringRef.start()
    }
    
    func sectionBreak(sectionName : String ) -> Void {
        print("_______________________________________________________________________")
        print("")
        print("$$$$$$$$$$$$$$$$$$$$$       \(sectionName)         $$$$$$$$$$$$$$$$$$$$$$$$$$$")
        print("")
        print("_______________________________________________________________________")
    }
    
    class func avoidUnusedWarning(args:AnyObject?...) -> Void {
        
    }

}

var main = Main()
main.start()


1