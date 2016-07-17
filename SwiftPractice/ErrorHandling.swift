//
//  ErrorHandling.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class ErrorHandling {
    func start() {
    
        throwCatchingError()
        convertingErrorsToOptionalValues()
        disableErrorPropagation()
    }
    
    enum VendingMachineError: ErrorType {
        case InvalidSelection
        case InsufficientFunds(coinsNeeded: Int)
        case OutOfStock
    }
    
    func throwCatchingError() {
        print("----------------------- throw and catching error ------------------------")
        
        func throwInsufficientFunds() throws {
            throw VendingMachineError.InsufficientFunds(coinsNeeded: 5)
        }
        
        do {
            try throwInsufficientFunds()
        } catch VendingMachineError.InvalidSelection {
            print("Invalid Selection.")
        } catch VendingMachineError.OutOfStock {
            print("Out of Stock.")
        } catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
            print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
        } catch {
            print("random error") //catch anyother error
        }
    }
    
    func convertingErrorsToOptionalValues() {
        print("----------------------- converting errors to optional values ------------------------")
        
        
        func someThrowingFunction() throws -> Int {
            throw VendingMachineError.OutOfStock
        }
        
        let x = try? someThrowingFunction()
        print("try? sets nil to x due to error. x =\(x)")
        
        let y: Int?
        do {
            y = try someThrowingFunction()
        } catch {
            y = nil
            print("try throws error and caught here. y =\(y)")
        }
        

        
    }
    
    // Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime. On those occasions, you can write try! before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error. 
    func disableErrorPropagation() {
        print("----------------------- disable error propagation ------------------------")
        enum MathErrors : ErrorType {
            case DivisionByZero
        }
        func division(x:Double, y:Double) throws-> Double {
            if y == 0.0 {
                throw MathErrors.DivisionByZero
            }
            return x/y
        }
        
        print("2/3 = \(try! division(2.0, y: 3.0))")
        //print("2/0 = \(try! division(2.0, y: 0.0))") throws runtime exception due try!
    }
    
}