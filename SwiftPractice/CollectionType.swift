//
//  collection_types.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/9/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation
class CollectionType: NSObject {
    func start() -> Void {
        createEmptyArray()
        createInsertRemoveArrays()
        createInitializingEmptySet()
        insertRemoveElementsFromSet()
        iteratingOverSets()
        setOperations()
        dictionaries()
    }
    func createEmptyArray() -> Void {
        print("----------------------- create empty array ------------------------")
        var someInts = [Int]()
        let someMoreInts = Array<Int>() //not used regularly.
        print("someInts is of type [Int] with \(someInts.count) items.")
        print("someMoreInts is of type [Int] with \(someMoreInts.count) items.")
        // Prints "someInts is of type [Int] with 0 items."
        
        someInts.append(3)
        print("someInts is of type [Int] with \(someInts.count) items.")
        // someInts now contains 1 value of type Int
        someInts = []
        print("someInts is of type [Int] with \(someInts.count) items.")
        // someInts is now an empty array, but is still of type [Int]
        
    }
    
    func createInsertRemoveArrays() -> Void {
        print("----------------------- create insert remove elements from array in diff ways ------------------------")
        let threeDoubles = [Double](count: 3, repeatedValue: 0.0)
        // threeDoubles is of type [Double], and equals [0.0, 0.0, 0.0]
        for value in threeDoubles {
            print(value, terminator:", ")
        }
        print("")
        
        let anotherThreeDoubles = [Double](count: 3, repeatedValue: 2.5)
        // anotherThreeDoubles is of type [Double], and equals [2.5, 2.5, 2.5]
        
        let sixDoubles = threeDoubles + anotherThreeDoubles
        // sixDoubles is inferred as [Double], and equals [0.0, 0.0, 0.0, 2.5, 2.5, 2.5]
        for value in sixDoubles {
            print(value, terminator:", ")
        }
        print("")
        
        //var shoppingList = ["Eggs", "Milk"]
        var shoppingList: [String] = ["Eggs", "Milk"]
        
        // shoppingList has been initialized with two initial items
        for value in shoppingList {
            print(value, terminator:", ")
        }
        print("")
        
        print("The shopping list contains \(shoppingList.count) items.")
        // Prints "The shopping list contains 2 items."
        
        if shoppingList.isEmpty {
            print("The shopping list is empty.")
        } else {
            print("The shopping list is not empty.")
        }
        // Prints "The shopping list is not empty."
        
        shoppingList.append("Flour")
        shoppingList += ["Baking Powder"]
        // shoppingList now contains 4 items
        shoppingList += ["Chocolate Spread", "Cheese", "Butter"]
        // shoppingList now contains 7 items

        for value in shoppingList {
            print(value, terminator:", ")
        }
        print("")
        
        print("first element is \(shoppingList[0])")
        shoppingList[0] = "Six eggs"
        
        //replaces 4, 5 and 6the elements with bananas and apples
        shoppingList[4...6] = ["Bananas", "Apples"]
        
        //insert element at first position
        shoppingList.insert("Maple Syrup", atIndex: 0)
        for value in shoppingList {
            print(value, terminator:", ")
        }
        print("")
        
        let mapleSyrup = shoppingList.removeAtIndex(0)
        shoppingList.removeLast()
        
        for (index, value) in shoppingList.enumerate() {
            print("Item \(index + 1): \(value)")
        }
        Main.avoidUnusedWarning(mapleSyrup)
    }
    
    func createInitializingEmptySet() -> Void {
        print("----------------------- create empty set ------------------------")
        var letters = Set<Character>()
        print("letters is of type Set<Character> with \(letters.count) items.")
        
        letters.insert("a")
        letters.insert("b")
        print("number of elements = \(letters.count)")
        // letters now contains 1 value of type Character
        letters = []
        // letters is now an empty set, but is still of type Set<Character>
    }
    
    func insertRemoveElementsFromSet() -> Void {
        print("----------------------- insert and remove elements from set ------------------------")
        var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//        var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        
        print("I have \(favoriteGenres.count) favorite music genres.")
        // Prints "I have 3 favorite music genres."
        
        if favoriteGenres.isEmpty {
            print("As far as music goes, I'm not picky.")
        } else {
            print("I have particular music preferences.")
        }
        // Prints "I have particular music preferences."
        
        favoriteGenres.insert("Jazz")
        // favoriteGenres now contains 4 items
        
        if let removedGenre = favoriteGenres.remove("Rock") {
            print("\(removedGenre)? I'm over it.")
        } else {
            print("I never much cared for that.")
        }
        // Prints "Rock? I'm over it."
        
        if favoriteGenres.contains("Funk") {
            print("I get up on the good foot.")
        } else {
            print("It's too funky in here.")
        }
        // Prints "It's too funky in here."
    }
    
    func iteratingOverSets() -> Void {
        print("----------------------- iterating over sets ------------------------")
        
        let favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
        for value in favoriteGenres {
            print(value, terminator: ", ")
        }
        print("")

        //in sorted order
        for value in favoriteGenres.sort() {
            print(value, terminator: ", ")
        }
        print("")
    }
    
    func setOperations() -> Void {
        print("----------------------- set operations ------------------------")
        let oddDigits: Set = [1, 3, 5, 7, 9]
        let evenDigits: Set = [0, 2, 4, 6, 8]
        let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]
        
        var sample = oddDigits.union(evenDigits) // set a and b
        printSet(sample)
        // [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        sample = oddDigits.intersect(evenDigits) // intersection of a and b
        printSet(sample)
        // []
        
        sample = oddDigits.subtract(singleDigitPrimeNumbers)
        printSet(sample)
        // [1, 9]
        
        sample = oddDigits.exclusiveOr(singleDigitPrimeNumbers) //set a and set b without intersection area
        printSet(sample)
        // [1, 2, 9]
    }
    
    func dictionaries() -> Void {
        print("----------------------- dictionaries ------------------------")
        var namesOfIntegers = [Int: String]()
//        var namesOfIntegers : Dictionary(Int, String)
        namesOfIntegers[16] = "sixteen"
        // namesOfIntegers now contains 1 key-value pair
        for (key,val) in namesOfIntegers {
            print("\(key) : \(val)")
        }
        namesOfIntegers = [:]
        // namesOfIntegers is once again an empty dictionary of type [Int: String]
        
        var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
        print("The airports dictionary contains \(airports.count) items.")
        // Prints "The airports dictionary contains 2 items."
        
        if airports.isEmpty {
            print("The airports dictionary is empty.")
        } else {
            print("The airports dictionary is not empty.")
        }
        // Prints "The airports dictionary is not empty."
        
        airports["LHR"] = "London"
        // the airports dictionary now contains 3 items
        
        airports["LHR"] = "London Heathrow"
        // the value for "LHR" has been changed to "London Heathrow"
        
        if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
            print("The old value for DUB was \(oldValue).")
        }
        // Prints "The old value for DUB was Dublin."
        
        if let airportName = airports["DUB"] {
            print("The name of the airport is \(airportName).")
        } else {
            print("That airport is not in the airports dictionary.")
        }
        // Prints "The name of the airport is Dublin Airport."
        
        airports["APL"] = "Apple International"
        // "Apple International" is not the real airport for APL, so delete it
        airports["APL"] = nil
        // APL has now been removed from the dictionary
        
        if let removedValue = airports.removeValueForKey("DUB") {
            print("The removed airport's name is \(removedValue).")
        } else {
            print("The airports dictionary does not contain a value for DUB.")
        }
        // Prints "The removed airport's name is Dublin Airport."

        for (key, val) in airports {
            print("\(key) - \(val)")
        }
        
        print("print keys")
        for airportCode in airports.keys {
            print("Airport code: \(airportCode)")
        }
        
        print("print values")
        for airportName in airports.values {
            print("Airport code: \(airportName)")
        }
        
        let airportCodes = [String](airports.keys)
        // airportCodes is ["YYZ", "LHR"]
        for code in airportCodes {
            print("\(code)", terminator: ",")
        }
        print("")
        
        let airportNames = [String](airports.values)
        // airportNames is ["Toronto Pearson", "London Heathrow"]
        for name in airportNames {
            print("\(name)", terminator: ",")
        }
        print("")
        
    }
    
    func printSet(set:Set<Int>) -> Void {
        for value in set.sort() {
            print(value, terminator: ", ")
        }
        print("")
    }
}
