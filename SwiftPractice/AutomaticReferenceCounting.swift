//
//  AutomaticReferenceCounting.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/16/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class AutomaticReferenceCounting {
    func start() {
        automaticReferenceCounting()
        strongReferenceCycle()
        weakReferences()
        unOwnedReference()
        unOwnedReferenceImplicitlyUnwrappedOptinalProperties()
        strongReferenceCycleForClosures()
    }
    
    func automaticReferenceCounting() {
        print("----------------------- automatic reference counting ------------------------")
        
        class Person {
            let name: String
            init(name: String) {
                self.name = name
                print("\(name) is being initialized")
            }
            deinit {
                print("\(name) is being deinitialized")
            }
        }
        
        var reference1: Person?
        var reference2: Person?
        var reference3: Person?
        
        reference1 = Person(name: "Vishnu") //strong ref count : 1
        // Prints "John Appleseed is being initialized"
        
        reference2 = reference1 //strong ref count : 2
        reference3 = reference1 //strong ref count : 3
        
        reference1 = nil  //strong ref count : 2
        reference2 = nil //strong ref count : 1
        reference3 = nil //strong ref count : 0
        // Prints "John Appleseed is being deinitialized"
        
    }
    
    func strongReferenceCycle() {
        print("----------------------- strong reference cycle ------------------------")
        class Person {
            let name: String
            init(name: String) {
                self.name = name
                print("Person initialized... will not be destroyed due to cyclic reference")
            }
            var apartment: Apartment?
            deinit { print("\(name) is being deinitialized") }
        }
        
        class Apartment {
            let unit: String
            init(unit: String) {
                self.unit = unit
                print("Apartment initialized... will not be destroyed due to cyclic reference")
            }
            var tenant: Person?
            deinit { print("Apartment \(unit) is being deinitialized") }
        }
        
        var john: Person? //strong ref count to Person - 0
        var unit4A: Apartment? //strong ref count to Apartment - 0
        
        john = Person(name: "John Appleseed") //strong ref count to Person - 1
        unit4A = Apartment(unit: "4A") //strong ref count to Apartment - 1
        
        john!.apartment = unit4A //strong ref count to Apartment - 2
        unit4A!.tenant = john //strong ref count to Person - 2
        
        john = nil //strong ref count to Apartment - 1
        unit4A = nil//strong ref count to Person - 1
        //apartment holds person reference and person holds apartment reference
    }
    
    /*
     A weak reference is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. This behavior prevents the reference from becoming part of a strong reference cycle. You indicate a weak reference by placing the weak keyword before a property or variable declaration.
     Use a weak reference to avoid reference cycles whenever it is possible for that reference to have a missing value(nil) at some point in its life. If the reference always has a value, use an unowned reference instead
    */
    func weakReferences() {
        print("----------------------- weak references ------------------------")
        class Person {
            let name: String
            init(name: String) {
                self.name = name
                print("Person initialized")
            }
            var apartment: Apartment?
            deinit { print("\(name) is being deinitialized") }
        }
        
        class Apartment {
            let unit: String
            init(unit: String) {
                self.unit = unit
                print("Apartment initialized")
            }
            weak var tenant: Person?
            deinit { print("Apartment \(unit) is being deinitialized") }
        }
        
        var john: Person? //strong ref count to Person - 0
        var unit4A: Apartment? //strong ref count to Apartment - 0
        
        john = Person(name: "John Appleseed") //strong ref count to Person - 1
        unit4A = Apartment(unit: "4A") //strong ref count to Apartment - 1
        
        john!.apartment = unit4A //strong ref count to Apartment - 2
        unit4A!.tenant = john //strong ref count to Person - 1, weak ref count to Person - 1
        
        john = nil //strong ref count to Person - 0, weak ref count - 1
        //calls Person destructor as no strong references to Person
        //strong ref count to Apartment becomes - 1
        unit4A = nil//strong ref count to Person - 0
        //calls Apartment destructor as no strong references to Apartment
    
    }
    
    /*
     Like weak references, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is assumed to always have a value. Because of this, an unowned reference is always defined as a nonoptional type.
    */
    func unOwnedReference() {
        print("----------------------- unowned references ------------------------")
        class Customer {
            let name: String
            var card: CreditCard? //optional
            init(name: String) {
                self.name = name
            }
            deinit { print("Customer:deinit") }
        }
        
        class CreditCard {
            let number: UInt64
            unowned let customer: Customer //this can not be nil in total life of the object
            init(number: UInt64, customer: Customer) {
                self.number = number
                self.customer = customer
            }
            deinit { print("CreditCard:deinit") }
        }
        
        var john: Customer? //Customer ref count : 0
        
        john = Customer(name: "John Appleseed") //Strong ref cycle of Customer : 1
        john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!) // strong ref cycle to credit card : 1, unowned ref cycle to Customer : 1
        
        john = nil //Strong ref cycle of Customer : 0, unowned ref cycle to Customer : 1
        //calls Customer deinit which will make strong ref cycle to credit card : 0
        //call CreditCard deinit
        // Prints "John Appleseed is being deinitialized"
        // Prints "Card #1234567890123456 is being deinitialized"
        
    }
    
    // third scenario, in which both properties should always have a value, and neither property should ever be nil once initialization is complete. In this scenario, it is useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.
    
    func unOwnedReferenceImplicitlyUnwrappedOptinalProperties() {
        print("----------------------- unowned reference implicitly unwrapped optional properties ------------------------")
        
        
        class Country {
            let name: String
            var capitalCity: City! //unwrapped optional properties, this is initialized with nil. Phase1 initialization is completed. So self can be passed to City's constructor. without !, capitalCity initialization is not completed. So self cannot be passed.
            init(name: String, capitalName: String) {
                self.name = name
                self.capitalCity = City(name: capitalName, country: self)
            }
            deinit {
                print("Country is being destroed")
            }
        }
        
        class City {
            let name: String
            unowned let country: Country
            init(name: String, country: Country) {
                self.name = name
                self.country = country
            }
            deinit {
                print("City is being destroed")
            }
        }
        
        let country = Country(name: "Canada", capitalName: "Ottawa")
        print("\(country.name)'s capital city is called \(country.capitalCity.name)")
        // Prints "Canada's capital city is called Ottawa"
    }
    
    //A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, such as self.someProperty, or because the closure calls a method on the instance, such as self.someMethod(). In either case, these accesses cause the closure to “capture” self, creating a strong reference cycle. 
    func strongReferenceCycleForClosures() {
        print("----------------------- yet to do ------------------------")
        
//        class HTMLElement {
//            
//            let name: String
//            let text: String?
//            
//            lazy var asHTML: () -> String = {
//                 [unowned self] in
//                    if let text = self.text {
//                        return "<\(self.name)>\(text)</\(self.name)>"
//                    } else {
//                        return "<\(self.name) />"
//                    }
//            }
//            
//            init(name: String, text: String? = nil) {
//                self.name = name
//                self.text = text
//            }
//            
//            deinit {
//                print("\(name) is being deinitialized")
//            }
//        
//        }
        
//        let heading = HTMLElement(name: "h1")
//        let defaultText = "some default text"
//        heading.asHTML = {
//            return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
//        }
//        print(heading.asHTML())
//        // Prints "<h1>some default text</h1>"
//        
//        var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
//        print(paragraph!.asHTML())

    }
}