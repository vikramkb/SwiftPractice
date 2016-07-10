//
//  Clouser.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/10/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Closuer: NSObject {
    func start() {
        globalFunctionAsClosuer()
        inlineClosure()
        inferTypeFromContextInClosure()
        implicitReturnInClosure()
        shorthandArgumentClosure()
        operatorFunctionInClosure()
        trailingClosure()
        captureValuesInNestedFunctionClosure()
        nonEscapingClosure()
        escapingClosure()
    }
    
    func globalFunctionAsClosuer() {
        print("----------------------- global function as clouser ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort(reverseOrder) // sort takes (String, String)->Bool function as parameter. reverseOrder has same signature
        for name in sortedNames {
            print(name)
        }
        //prints in descending order
    }

    func inlineClosure() {
        print("----------------------- inline closure ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort({
            (first : String, second : String) -> Bool in
            return first < second
        }) // sort takes (String, String)->Bool function as parameter. The unnamed function passed as argument which has same signature.
        for name in sortedNames {
            print(name)
        }
        //prints in ascending order
    }

    func inferTypeFromContextInClosure() {
        print("----------------------- infer type in closure ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort({ first, second in return first < second})
        // sort takes (String, String)->Bool function as parameter. 
        // type of arguments and return type is inferred automatically based on the context
        for name in sortedNames {
            print(name)
        }
        //prints in ascending order
    }

    func implicitReturnInClosure() {
        print("----------------------- implicit return in closure ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort({ first, second in first < second})
        // sort takes (String, String)->Bool function as parameter.
        // single expression closures can ommit return keyword.
        for name in sortedNames {
            print(name)
        }
        //prints in ascending order
    }
    
    func shorthandArgumentClosure() {
        print("----------------------- shorthand argument closure ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort({$0 < $1})
        // sort takes (String, String)->Bool function as parameter.
        // $0 refers to first argument and $1 refers to second argument
        for name in sortedNames {
            print(name)
        }
        //prints in ascending order
    }

    func operatorFunctionInClosure() {
        print("----------------------- shorthand argument closure ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort(<)
        // sort takes (String, String)->Bool function as parameter.
        // string-specific implementation of < as a function which has same signature can be used directly
        for name in sortedNames {
            print(name)
        }
        //prints in ascending order
    }
    
    func trailingClosure() {
        print("----------------------- trailing closure ------------------------")
        let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
        let sortedNames = names.sort {
            $0 < $1
        }
        // sort takes (String, String)->Bool function as parameter.
        // if the closure is last argument, the closure can be written outside the parameters paranthesis
        for name in sortedNames {
            print(name)
        }
        //prints in ascending order
        
    }
    
    func captureValuesInNestedFunctionClosure() {
        print("----------------------- capture values in closure (nested function) ------------------------")
        let incrementByTen = incrementBy(10)
        //incrementBy returns function which is a closure in incrementBy function. incrementBy function has two variables total and number. Which were captured in closure(incrementer).
        //incrementByTen is constant not the contents of the closure. Hence it will be able to update the total and captured values. Closures and Functions are references
        print(incrementByTen()) // though total and count is out of scope in incrementBy. It's still can be used in incrementer.
        //prints 10
        print(incrementByTen())
        //prints 20
        print(incrementByTen())
        //prints 30
        
        let incrementByFifty = incrementBy(50)
        print(incrementByFifty()) // prints 50
        print(incrementByFifty()) // prints 100
        print(incrementByFifty()) // prints 150
    }
    
    func incrementBy(number : Int) -> () -> Int {
        var total = 0
        func incrementer() -> Int {
            total += number
            return total
        }
        return incrementer
    }
    
    var count : Int = 0
    func nonEscapingClosure() {
        print("----------------------- non escaping closure ------------------------")
        //compiler can do greater optimizations as it does know the closure can not be used outside the function.
        //cannot be executed the closure later point of time by saving the closure in outside scope variables.
        print(count)        
        incrementCountNoEscape({count += 10})
        print(count)
        incrementCountNoEscape({count += 20})
        print(count)
    }
    
    func escapingClosure() {
        print("----------------------- escaping closure ------------------------")
        count = 0
        print(count)
        //escaping closure are used to refer the closures for later point of time.
        //usually used in asynchronous functions. The closure is called once the task is completed later point of time. Lazily executing the closure.
        incrementCountEscape({self.count += 10})
        incrementCountEscape({self.count += 10})
        
        print(count)
        for closure in incrementCountClosures {
            closure()
            print(count)
        }
    }
    
    func autoClosure() {
        print("----------------------- auto closure ------------------------")
        count = 0
        print(count)
        incrementCountAutoClosure(count += 10) // no need of brace wrapping as @autoclosure is used in function declaration
        incrementCountAutoClosure(count += 10)
        print(count)
    }

    func incrementCountAutoClosure(@autoclosure closure: () -> Void) {
        closure()
    }
    
    
    func incrementCountNoEscape(@noescape closure: () -> Void) {
        //incrementCountClosures.append(closure)
        //compilation error. Cannot be referred outside of this function
        closure()
    }
    
    var incrementCountClosures : [()->Void] = []
    func incrementCountEscape(closure: () -> Void) {
        incrementCountClosures.append(closure)
    }
    
    private func reverseOrder(first:String, second:String) -> Bool {
        return first > second
    }
}