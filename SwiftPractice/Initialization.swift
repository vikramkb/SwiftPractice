//
//  Initialization.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/11/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Initialization: NSObject {
    func start() {
        simpleInit()
        initializationParameters()
        localAndExternalParameternames()
        optionalParameterNames()
        assigningConstantProperties()
        initializerDelegationForValueTypes() //structs and enums
        designatedConvienienceInitializers()
        requiredInitializers()
        initializerRules()
        failableInitializers()
        failableInitializersForEnums()
        propagationOfInitializationFailures()
        requiredInitializers()
        defaultPropertyValueWithAClosureFunction()
    }
    
    func simpleInit() {
        print("--------------------- simple init --------------------------")
        struct Fahrenheit {
            var temperature: Double
            init() {
                temperature = 32.0
            }
        }
        let f = Fahrenheit()
        print("The default temperature is \(f.temperature)° Fahrenheit")
        // Prints "The default temperature is 32.0° Fahrenheit"
        
        struct Fahrenheit1 {
            var temperature = 32.0 //default initialization
        }
        let f1 = Fahrenheit()
        print("The default temperature is \(f1.temperature)° Fahrenheit")
        // Prints "The default temperature is 32.0° Fahrenheit"

    }
    
    // two types of initializers which takes one Double parameter. They can be used seperately by using external name of the parameter
    func initializationParameters() {
        print("--------------------- initialization parameters --------------------------")
        struct Celsius1 {
            var celsius: Double
            init(celsius : Double) {
                self.celsius = celsius
            }
        }
        
        //var twentyCelsius = Celsius(20)
        //this is compilation error. initializers must specify the external parameter name
        let twentyCelsius = Celsius1(celsius: 20)
        print("celsius = \(twentyCelsius)")
        
        
        struct Celsius {
            var temperatureInCelsius: Double
            
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(fromKelvin kelvin: Double) {
                temperatureInCelsius = kelvin - 273.15
            }
        }
        let boilingPointOfWater = Celsius(fromFahrenheit: 212.0)
        print("degrees \(212.0) = \(boilingPointOfWater.temperatureInCelsius) celsius")
        // boilingPointOfWater.temperatureInCelsius is 100.0
        let freezingPointOfWater = Celsius(fromKelvin: 273.15)
        print("kelvin \(273.15) = \(freezingPointOfWater.temperatureInCelsius) celsius")
        // freezingPointOfWater.temperatureInCelsius is 0.0
    }
    
    //must use the external parameter name while passing the arguments to init by default. External name is same as internal name for the init parameters including first argument. It's not same case with other methods. Leaving external name while creating object leads to compilation error by default.
    func localAndExternalParameternames() {
        print("--------------------- local and external parameter names --------------------------")
        struct Color {
            let red, green, blue: Double
            init(red: Double, green: Double, blue: Double) {
                self.red   = red
                self.green = green
                self.blue  = blue
            }
            init(white: Double) {
                red   = white
                green = white
                blue  = white
            }
        }
        let magenta = Color(red: 1.0, green: 0.0, blue: 1.0)
        print("magenta color = (\(magenta.red),\(magenta.green),\(magenta.blue))")
        let halfGray = Color(white: 0.5)
        print("halfGray color = (\(halfGray.red),\(halfGray.green),\(halfGray.blue))")
    }
    
    func initializerParametersWithoutExternalNames() {
        print("--------------------- initializer parameters without external names --------------------------")

        struct Celsius {
            var temperatureInCelsius: Double
            init(fromFahrenheit fahrenheit: Double) {
                temperatureInCelsius = (fahrenheit - 32.0) / 1.8
            }
            init(_ celsius: Double) {
                temperatureInCelsius = celsius
            }
        }
        let bodyTemperature = Celsius(37.0)
        print("celsius temparatue = \(bodyTemperature.temperatureInCelsius)")
    }
    
    func optionalParameterNames() {
        print("--------------------- optional parameter names --------------------------")
        class SurveyQuestion {
            var text: String
            var response: String? //optional property. need not be initialized in init
            init(text: String) {
                self.text = text
            }
            func ask() {
                print("text = \(text), response = \(response)")
            }
        }
        let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
        cheeseQuestion.ask()
        // Prints text = Do you like cheese?, response = nil
        cheeseQuestion.response = "Yes, I do like cheese."
        // prints text = Do you like cheese?, response = Optional("Yes, I do like cheese.")
        cheeseQuestion.ask()
    }
    
    //constant properties can be initialized in init
    func assigningConstantProperties() {
        print("--------------------- assigning constant properties --------------------------")
        class SurveyQuestion {
            let text: String
            init(text: String) {
                self.text = text
            }
            func ask() {
                print(text)
            }
        }
        let beetsQuestion = SurveyQuestion(text: "How about beets?")
        beetsQuestion.ask()
        // Prints "How about beets?"
    }
    
    //Structure types automatically receive a memberwise initializer if they do not define any of their own custom initializers.
    func memberWiseInitializationForStructures() {
        print("--------------------- memberwise initialization for structures --------------------------")
        struct Size {
            var width = 0.0, height = 0.0
        }
        let twoByTwo = Size(width: 2.0, height: 2.0)
        print("width = \(twoByTwo.width), height = \(twoByTwo.height)")
    }
 
    /*Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers. */
    func initializerDelegationForValueTypes() {
        print("--------------------- initializer delegation for value types --------------------------")
        struct Size {
            var width = 0.0, height = 0.0
        }
        struct Point {
            var x = 0.0, y = 0.0
        }
        struct Rect {
            var origin = Point()
            var size = Size()
            init() {}
            init(origin: Point, size: Size) {
                self.origin = origin
                self.size = size
            }
            init(center: Point, size: Size) {
                let originX = center.x - (size.width / 2)
                let originY = center.y - (size.height / 2)
                self.init(origin: Point(x: originX, y: originY), size: size)
                //uses other initializer to avoid duplicate code in initializers
            }
        }
        
        let basicRect = Rect()
        print("origin = (\(basicRect.origin.x), \(basicRect.origin.y)), width = \(basicRect.size.width), height = \(basicRect.size.height)")
        // basicRect's origin is (0.0, 0.0) and its size is (0.0, 0.0)
        
        let originRect = Rect(origin: Point(x: 2.0, y: 2.0),
                              size: Size(width: 5.0, height: 5.0))
        print("origin = (\(originRect.origin.x), \(originRect.origin.y)), width = \(originRect.size.width), height = \(originRect.size.height)")
        // originRect's origin is (2.0, 2.0) and its size is (5.0, 5.0)
        
        let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                              size: Size(width: 3.0, height: 3.0))
        print("origin = (\(centerRect.origin.x), \(centerRect.origin.y)), width = \(centerRect.size.width), height = \(centerRect.size.height)")
        // centerRect's origin is (2.5, 2.5) and its size is (3.0, 3.0)
    }
    
    /*Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.*/
    
    /*Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values. You can also define a convenience initializer to create an instance of that class for a specific use case or input value type.
     */
    
    func designatedConvienienceInitializers() {
        print("--------------------- designated and convienience initializers --------------------------")
        
        class Rectangle {
            var width = Int()
            var height = Int()
            init(width : Int, height : Int) {
                self.width = width
                self.height = height
            }
            convenience init(side : Int) {
                self.init(width: side, height: side)
            }
        }
        
        let rect = Rectangle(width: 10, height: 15)
        let square = Rectangle(side: 10)
        print("rectangle - width = \(rect.width), height = \(rect.height)")
        print("square - width = \(square.width), height = \(square.height)")
        
    }
    
    /*
     Rule 1 : A designated initializer must call a designated initializer from its immediate superclass.
     Rule 2 : A convenience initializer must call another initializer from the same class.
     Rule 3 : A convenience initializer must ultimately call a designated initializer.
     
     --------------
     Phase 1
     
     A designated or convenience initializer is called on a class.
     
     Memory for a new instance of that class is allocated. The memory is not yet initialized.
     
     A designated initializer for that class confirms that all stored properties introduced by that class have a value. The memory for these stored properties is now initialized.
     
     The designated initializer hands off to a superclass initializer to perform the same task for its own stored properties.
     
     This continues up the class inheritance chain until the top of the chain is reached.
     
     Once the top of the chain is reached, and the final class in the chain has ensured that all of its stored properties have a value, the instance’s memory is considered to be fully initialized, and phase 1 is complete.
     
     Phase 2
     
     Working back down from the top of the chain, each designated initializer in the chain has the option to customize the instance further. Initializers are now able to access self and can modify its properties, call its instance methods, and so on.
     
     Finally, any convenience initializers in the chain have the option to customize the instance and to work with self.
     
    */
    
    func
        initializerRules() {
        print("--------------------- initializer phases --------------------------")
        class Bird {
            var canFly = Bool()
            var canSing = Bool()
            init(canFly : Bool) {
                self.canFly = canFly
            }
            convenience init(canFly: Bool, canSing: Bool) { //rule 2
                self.init(canFly: canFly) //Rule 3
                self.canSing = canSing
            }
        }
        
        class Peafowl : Bird {
            var tailFeathers = Bool()
            init(tailFeathers : Bool) {
                super.init(canFly: true) //rule 1
                self.tailFeathers = tailFeathers
            }
            
            convenience init(peaHen : Bool) { //rule 2
                if peaHen {
                    self.init(tailFeathers: true) //Rule 3
                }else{
                    self.init(tailFeathers: false) //Rule 3
                }
            }
        }
        
        let peaHen = Peafowl(peaHen : true)
        print("pea hen : tailFeathers = \(peaHen.tailFeathers), canFly = \(peaHen.canFly), canSing = \(peaHen.canSing)")

        let peaCock = Peafowl(peaHen : false)
        print("pea cock : tailFeathers = \(peaCock.tailFeathers), canFly = \(peaCock.canFly), canSing = \(peaCock.canSing)")
        
    }
    
    /*
     A failable initializer creates an optional value of the type it initializes. You write return nil within a failable initializer to indicate a point at which initialization failure can be triggered.
    */
    func failableInitializers() {
        print("--------------------- failable initializer for class --------------------------")
        class Animal {
            let species: String
            init?(species: String) {
                if species.isEmpty { return nil }
                self.species = String()
            }
        }
        
        
        let someCreature = Animal(species: "Giraffe")
        // someCreature is of type Animal?, not Animal
        
        if let giraffe = someCreature {
            print("An animal was initialized with a species of \(giraffe.species)")
        }
        // Prints "An animal was initialized with a species of Giraffe"
        

        let anonymousCreature = Animal(species: "")
        // anonymousCreature is of type Animal?, not Animal
        
        if anonymousCreature == nil {
            print("The anonymous creature could not be initialized")
        }
        // Prints "The anonymous creature could not be initialized"

    }
    
    func failableInitializersForEnums() {
        print("--------------------- failable initializer for enums --------------------------")
        
        
        enum TemperatureUnit {
            case Kelvin, Celsius, Fahrenheit
            init?(symbol: Character) {
                switch symbol {
                case "K":
                    self = .Kelvin
                case "C":
                    self = .Celsius
                case "F":
                    self = .Fahrenheit
                default:
                    return nil
                }
            }
        }
        
        
        
        let fahrenheitUnit = TemperatureUnit(symbol: "F")
        if fahrenheitUnit != nil {
            print("This is a defined temperature unit, so initialization succeeded.")
        }
        // Prints "This is a defined temperature unit, so initialization succeeded."
        
        let unknownUnit = TemperatureUnit(symbol: "X")
        if unknownUnit == nil {
            print("This is not a defined temperature unit, so initialization failed.")
        }
        // Prints "This is not a defined temperature unit, so initialization failed."
        
    }
    
    //fails immediately as soon as there is failure
    func propagationOfInitializationFailures() {
        print("--------------------- propagation of initialization failures --------------------------")
        
        class Product {
            let name: String
            init?(name: String) {
                if name.isEmpty { return nil }
                self.name = name
            }
        }
        
        class CartItem: Product {
            let quantity: Int
            init?(name: String, quantity: Int) {
                if quantity < 1 { return nil }
                self.quantity = quantity
                super.init(name: name)
            }
        }
        
        
        
        if let twoSocks = CartItem(name: "sock", quantity: 2) {
            print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
        }
        // Prints "Item: sock, quantity: 2"
        

        
        
        if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
            print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
        } else {
            print("Unable to initialize zero shirts")
        }
        // Prints "Unable to initialize zero shirts"
        

        
        
        if let oneUnnamed = CartItem(name: "", quantity: 1) {
            print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
        } else {
            print("Unable to initialize one unnamed product")
        }
        // Prints "Unable to initialize one unnamed product"
    }
    
    /*
     Write the required modifier before the definition of a class initializer to indicate that every subclass of the class must implement that initializer:
     
     You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.
    */
    func requiredInitializers() {
        print("--------------------- required initializers --------------------------")
        class A {
            required init() {
                print("in A:init")
            }
        }
        class B : A {
            required init() {
                print("in B:init")
            }
        }
        
        var _ = B()
        //prints in A:init followed by B:init
    }
    
    func defaultPropertyValueWithAClosureFunction() {
        print("--------------------- defaultProperty value with a closure function --------------------------")
        
        
        class Chessboard {
            let boardColors: [Bool] = { //executing closure while initializing the chess board
                var temporaryBoard = [Bool]()
                var isBlack = false
                for i in 1...8 {
                    for j in 1...8 {
                        temporaryBoard.append(isBlack)
                        isBlack = !isBlack
                    }
                    isBlack = !isBlack
                }
                return temporaryBoard
            }()
            
            func printBoard() {
                for i in 0...7 {
                    for j in 0...7 {
                        print((boardColors[(i * 8) + j]), terminator: " ")
                    }
                    print("")
                }
            }
            
            func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
                return boardColors[(row * 8) + column]
            }
        }
        
        
        
        let board = Chessboard()
        func color(black: Bool) -> String {
            return black ? "Black" : "White"
        }
        
        board.printBoard()
        print("(0, 0) cells in chess board is \(color(board.squareIsBlackAtRow(0, column: 0)))")
        //prints white
        print("(0, 7) cells in chess board is \(color(board.squareIsBlackAtRow(0, column: 7)))")
        //prints black
    }
}