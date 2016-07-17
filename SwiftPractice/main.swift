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
        
        sectionBreak("Collection Types")
        let collectionTypes = CollectionType()
        collectionTypes.start()

        sectionBreak("Control Flow")
        let controlFlow = ControlFlow()
        controlFlow.start()

        sectionBreak("Functions")
        let fun = Function()
        fun.start()
        
        sectionBreak("Closures")
        let closuer = Closuer()
        closuer.start()

        sectionBreak("Enumerations")
        let enumuration = Enumerations()
        enumuration.start()

        sectionBreak("classes and structures")
        let classesStructures = ClassesStructures()
        classesStructures.start()
        
        sectionBreak("properties")
        let properties = Properties()
        properties.start()

        sectionBreak("methods")
        let methods = Methods()
        methods.start()
        
        sectionBreak("initialization")
        let initialization = Initialization()
        initialization.start()

        sectionBreak("de-initialization")
        let deInitialization = DeInitialization()
        deInitialization.start()

        sectionBreak("automatic reference counting")
        let automaticRefCounting = AutomaticReferenceCounting()
        automaticRefCounting.start()

        sectionBreak("optional chaining")
        let optionalChaining = OptionalChaining()
        optionalChaining.start()
        
        sectionBreak("error handling")
        let errorHandling = ErrorHandling()
        errorHandling.start()

        sectionBreak("type casting")
        let typeCasting = TypeCasting()
        typeCasting.start()

        sectionBreak("inheritance")
        let inheritance = Inheritance()
        inheritance.start()

        sectionBreak("subscript")
        let subScript = Subscript()
        subScript.start()

        sectionBreak("extension")
        let extensionExample = Extension()
        extensionExample.start()

        sectionBreak("protocols")
        let protocols = Protocols()
        protocols.start()

        sectionBreak("generics")
        let generics = Generics()
        generics.start()
        
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