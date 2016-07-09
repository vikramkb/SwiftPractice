//
//  test.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/7/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Basics: NSObject {
    override init() {
        super.init()
        
    }
    
    func start() -> Void {
        variableAndConstanants()
        typeAnnotations()
        namingConstantsAndVariables()
        typeSafetyAndInference()
        typeAliases()
        booleans()
        tuples()
        optionals()
        optionalBinding()
        implicityUnwrapped()
        errorHandling()
    }
    
    func variableAndConstanants() -> Void {
        print("--------------------- variables and constants --------------------------")
        let maximumNumberOfLoginAttempts = 10 //constant
        var currentLoginAttempt = 0 //variable
        currentLoginAttempt = 1
        print("variable = ", currentLoginAttempt, ", constant = ", maximumNumberOfLoginAttempts)
        var x = 0.0, y = 0.0, z = 0.0
        x = 1.0
        y = 1.0
        z = 1.0
        print("Same line variable declaration = \(x), \(y), \(z)")
    }
    
    func typeAnnotations() -> Void {
        print("--------------------- type annotations --------------------------")
        //Type Annotations
        var welcomeMessage: String //“Declare a variable called welcomeMessage that is of type String.”
        welcomeMessage = "Welcome to Hello World Program"
        print(welcomeMessage)
        
        var red, green, blue: Double
        red = 1.0
        green = 2.0
        blue = 3.0
        print("colors : red = \(red), green = \(green), blue = \(blue)")
    }
    
    func namingConstantsAndVariables() -> Void {
        print("--------------------- naming constannt and variables --------------------------")
        //Constant and variable names can contain almost any character, including Unicode characters
        let $ = "Dollars"
        print($)
    }
    
    func typeSafetyAndInference() -> Void {
        print("--------------------- type saftety and inference --------------------------")
        
        //Swift is a type-safe language. 
        
        let meaningOfLife = 42 // meaningOfLife is inferred to be of type Int
        let pi = 3.14159 // pi is inferred to be of type Double
        let anotherPi = 3 + 0.14159 // anotherPi is also inferred to be of type Double
        let decimalInteger = 17
        let binaryInteger = 0b10001       // 17 in binary notation
        let octalInteger = 0o21           // 17 in octal notation
        let hexadecimalInteger = 0x11     // 17 in hexadecimal notation
        print("\(meaningOfLife) \(pi) \(anotherPi) \(decimalInteger) \(binaryInteger) \(octalInteger) \(hexadecimalInteger)")
    }
    
    func typeAliases() -> Void {
        print("--------------------- type aliases --------------------------")

        typealias Money = Int
        var money : Money
        money = 40000
        print("typeAlias money = \(money)")
    }
    
    func booleans() -> Void {
        print("--------------------- booleans --------------------------")
        let turnipsAreDelicious = false
        if turnipsAreDelicious {
            print("Mmm, tasty turnips!")
        } else {
            print("Eww, turnips are horrible.")
        }
        
//        let i = 1
//        if i {
            // this example will not compile, and will report an error
//        }
        
        let i = 1
        if i == 1 {
            // this example will compile successfully
        }
    }
    
    func tuples() -> Void {
        print("--------------------- tuples --------------------------")
        let http404Error = (404, "Not Found")
        // http404Error is of type (Int, String), and equals (404, "Not Found")
        
        let (statusCode, statusMessage) = http404Error
        print("The status code is \(statusCode)")
        // Prints "The status code is 404"
        print("The status message is \(statusMessage)")
        // Prints "The status message is Not Found"
        
        let (justTheStatusCode, _) = http404Error
        print("The status code is \(justTheStatusCode)")
        // Prints "The status code is 404"
        
        print("The status code is \(http404Error.0)")
        // Prints "The status code is 404"
        print("The status message is \(http404Error.1)")
        // Prints "The status message is Not Found"
        
        
        let http200Status = (statusCode: 200, description: "OK")
        print("The status code is \(http200Status.statusCode)")
        // Prints "The status code is 200"
        print("The status message is \(http200Status.description)")
        // Prints "The status message is OK"
    }
    
    func optionals() -> Void {
        print("--------------------- optionals --------------------------")
        let possibleNumber = "123"
        let convertedNumber = Int(possibleNumber)
        // convertedNumber is inferred to be of type "Int?", or "optional Int"
        // Because the initializer might fail, it returns an optional Int, rather than an Int
        
        var serverResponseCode: Int? = 404
        // serverResponseCode contains an actual Int value of 404
        serverResponseCode = nil
        // serverResponseCode now contains no value
        
        var surveyAnswer: String?
        // surveyAnswer is automatically set to nil
        surveyAnswer = "1234"
        print(surveyAnswer!)
        Main.avoidUnusedWarning(serverResponseCode)

        
        if convertedNumber != nil {
            print("convertedNumber contains some integer value.")
        }
        // Prints "convertedNumber contains some integer value."
        
        if convertedNumber != nil {
            print("convertedNumber has an integer value of \(convertedNumber!).")
        }
        // Prints "convertedNumber has an integer value of 123."
    }
    
    func optionalBinding() -> Void {
        print("--------------------- optional binding --------------------------")
        let possibleNumber = "20"
        /* If the optional Int returned by Int(possibleNumber) contains a value, set a new constant called actualNumber to the value contained in the optional. */
        if let actualNumber = Int(possibleNumber) {
            print("\"\(possibleNumber)\" has an integer value of \(actualNumber)")
        } else {
            print("\"\(possibleNumber)\" could not be converted to an integer")
        }
        // Prints ""123" has an integer value of 123"
        
        
        //  You can include multiple optional bindings in a single if statement and use a where clause to check for a Boolean condition. If any of the values in the optional bindings are nil or the where clause evaluates to false, the whole optional binding is considered unsuccessful.
        
        if let firstNumber = Int("4"), secondNumber = Int("42") where firstNumber < secondNumber {
            print("\(firstNumber) < \(secondNumber)")
        }
        // Prints "4 < 42"
    }
    
    func implicityUnwrapped() -> Void {
        print("--------------------- implicit unwrapping --------------------------")
        //explicit unwrapping
        let possibleString: String? = "An optional string."
        let forcedString: String = possibleString! // requires an exclamation mark
        
        //implicitly unwrapped optionals
        let assumedString: String! = "An implicitly unwrapped optional string."
        let implicitString: String = assumedString // no need for an exclamation mark
        print(forcedString + " " + implicitString)
    }

    
    func errorHandling() -> Void {
//        func makeASandwich() throws {
//        }

//        makeASandwich may or may not throw an Error
//        Catching multiple errors in below code

//        do {
//            try makeASandwich()
//                        eatASandwich()
//        } catch Error.OutOfCleanDishes {
//                        washDishes()
//        } catch Error.MissingIngredients(let ingredients) {
//                        buyGroceries(ingredients)
//        }
    }
    
    
    
}