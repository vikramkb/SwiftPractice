//
//  Enumerations.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/10/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}

enum Planet {
    case Mercury, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
}


class Enumerations: NSObject {
    func start() {
        basicEnumerations()
        associatedValuesInEnum()
        rawEnumValues()
        recursiveArithematicExpression()
    }
    
    func basicEnumerations() {
        print("----------------------- basic enumerations ------------------------")
        enum CompassPoint {
            case North
            case South
            case East
            case West
        }
        
        var direction = CompassPoint.East
        if direction == CompassPoint.East {
            print("I am travelling east")
        }
        
        direction = .North //shorthand as direction does already know what enum type
        
        switch direction {
            case .North:
                print("Lots of planets have a north")
            case .South:
                print("Watch out for penguins")
            case .East:
                print("Where the sun rises")
            case .West:
                print("Where the skies are blue")
        }
        // Prints "Lots of planets have a north"
        
    }
    
    func associatedValuesInEnum() {
        print("----------------------- associated values in enum ------------------------")
        var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
        printCode(productBarcode)
        productBarcode = .QRCode("ABCDEFGHIJKLMNOP")
        printCode(productBarcode)
    }
    
    private func printCode(code : Barcode) {
        switch code {
        case .UPCA(let numberSystem, let manufacturer, let product, let check):
            print("UPC-A: \(numberSystem), \(manufacturer), \(product), \(check).")
        case .QRCode(let productCode):
            print("QR code: \(productCode).")
        }
    }
    
    func rawEnumValues() {
        print("----------------------- raw enum values ------------------------")
        enum ASCIIControlCharacter: Character {
            case Tab = "\t"
            case LineFeed = "\n"
            case CarriageReturn = "\r"
        }
        
        let tab = ASCIIControlCharacter.Tab
        if tab == ASCIIControlCharacter.Tab {
            print("Yes it's tab")
        }
        
        enum Planet: Int {
            case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Neptune
        }
        print("\(Planet.Mercury) - \(Planet.Earth)")
        if 1 == Planet.Mercury.rawValue {
            print("It's first planet in solar system")
        }
        
        let plutoPlanet = Planet(rawValue: 9)
        let positionToFind = 11
        if let somePlanet = Planet(rawValue: positionToFind) {
            print("this planet position in solar system is \(somePlanet.rawValue)")
        }else{
            print("not a planet in solar system")
        }
        //prints "not a planet in solar system"
    }
    
    //    A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases.
    func recursiveArithematicExpression() {
        print("----------------------- recursive arithematic expressions ------------------------")
        enum ArithmeticExpression {
            case Number(Int)
            indirect case Addition(ArithmeticExpression, ArithmeticExpression)
            indirect case Multiplication(ArithmeticExpression, ArithmeticExpression)
        }//indirect is used to refer the usage of enum within same enum
        
        
        //applying indirect to all cases
        indirect enum ArithmeticExpression1 {
            case Number(Int)
            case Addition(ArithmeticExpression1, ArithmeticExpression1)
            case Multiplication(ArithmeticExpression1, ArithmeticExpression1)
        }
        
        func evaluate(expression: ArithmeticExpression) -> Int {
            switch expression {
            case let .Number(value):
                return value
            case let .Addition(left, right):
                return evaluate(left) + evaluate(right)
            case let .Multiplication(left, right):
                return evaluate(left) * evaluate(right)
            }
        }
        
        
        let five = ArithmeticExpression.Number(5)
        let four = ArithmeticExpression.Number(4)
        let sum = ArithmeticExpression.Addition(five, four)
        let product = ArithmeticExpression.Multiplication(sum, ArithmeticExpression.Number(2))

        print(evaluate(product)) //recursively calculate the expression
        //prints ((4+5) * 2) = 18
    }
    
}