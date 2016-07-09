//
//  strings.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/9/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation
class StringRef: NSObject {
    func start() -> Void {
        emptyString()
        stringMutatability()
        workingWithCharacters()
        concatStringsAndChars()
        stringInterpolation()
        specialCharsInStringLiterals()
        extendedGraphemeClusters()
        countingCharacters()
        accessModifyString()
        insertingRemovingChars()
        compareStrings()
        stringHasPrefixSuffix()
    }
    
    func emptyString() -> Void {
        print("----------------------- empty string ------------------------")
        let emptyString = ""               // empty string literal
        let anotherEmptyString = String()  // initializer syntax
        // these two strings are both empty, and are equivalent to each other
        if emptyString.isEmpty {
            print("Nothing to see here")
        }
        // Prints "Nothing to see here"
        
        Main.avoidUnusedWarning(emptyString, anotherEmptyString)
    }
    
    func stringMutatability() -> Void {
        print("----------------------- string mutability ------------------------")
        var variableString = "Horse"
        variableString += " and carriage"
        // variableString is now "Horse and carriage"
        print(variableString)
        
        //let constantString = "Highlander"
        //constantString += " and another Highlander"
        // this reports a compile-time error - a constant string cannot be modified
    }
    
    func workingWithCharacters() -> Void {
        print("----------------------- working with characters ------------------------")
        let otherExclamationMark: Character = "!"
        for character in "Dog!🐶".characters {
            print(character)
        }
        print(otherExclamationMark)
        
        
        let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
        let catString = String(catCharacters)
        print(catString)
        // Prints "Cat!🐱"
    }
    
    func concatStringsAndChars() -> Void {
        print("----------------------- concat strings and characters ------------------------")
        let string1 = "hello"
        let string2 = " there"
        var welcome = string1 + string2
        // welcome now equals "hello there"
        print(welcome)
        
        //append character to existing string
        let exclamationMark: Character = "!"
        welcome.append(exclamationMark)
        // welcome now equals "hello there!"
        print(welcome)
    }
    
    //    String interpolation is a way to construct a new String value from a mix of constants, variables, literals, and expressions by including their values inside a string literal
    func stringInterpolation() -> Void {
        print("----------------------- string interpolation ------------------------")
        let multiplier = 3
        let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"
        // message is "3 times 2.5 is 7.5"
        print(message)
    }
    
    func specialCharsInStringLiterals() -> Void {
        print("----------------------- special chars in strings ------------------------")
        let wiseWords = "\"Imagination is more important than knowledge\" - Einstein"
        // "Imagination is more important than knowledge" - Einstein
        let dollarSign = "\u{24}"        // $,  Unicode scalar U+0024
        let blackHeart = "\u{2665}"      // ♥,  Unicode scalar U+2665
        let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
        print(wiseWords + "\n" + dollarSign + blackHeart + sparklingHeart)
    }
    
    //    Every instance of Swift’s Character type represents a single extended grapheme cluster. An extended grapheme cluster is a sequence of one or more Unicode scalars that (when combined) produce a single human-readable character.
    func extendedGraphemeClusters() -> Void {
        print("----------------------- extended grapheme clusters ------------------------")
        let eAcute: Character = "\u{E9}"                         // é
        let combinedEAcute: Character = "\u{65}\u{301}"          // e followed by ́
        // eAcute is é, combinedEAcute is é
        print(eAcute)
        print(combinedEAcute)
        
        let precomposed: Character = "\u{D55C}"                  // 한
        let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
        // precomposed is 한, decomposed is 한
        print(precomposed)
        print(decomposed)
        
        let enclosedEAcute: Character = "\u{E9}\u{20DD}"
        // enclosedEAcute is é⃝
        print(enclosedEAcute)
        
        let regionalIndicatorForUS: Character = "\u{1F1FA}\u{1F1F8}"
        // regionalIndicatorForUS is 🇺🇸
        print(regionalIndicatorForUS)
    }
    
    func countingCharacters() -> Void {
        print("----------------------- counting chars ------------------------")
        let unusualMenagerie = "Koala 🐨, Snail 🐌, Penguin 🐧, Dromedary 🐪"
        print("unusualMenagerie has \(unusualMenagerie.characters.count) characters")
        // Prints "unusualMenagerie has 40 characters"
    }
    
 
    // As strings use unicode scalars, swift cannot use index directly to access the positins.
    // Attempting to access a Character at an index outside of a string’s range will trigger a runtime error.
    func accessModifyString() -> Void {
        print("----------------------- access and modify of strings ------------------------")
        let greeting = "Guten Tag!"
        let firstChar = greeting[greeting.startIndex]
        print(firstChar)
        // G
        
        let lastChar = greeting[greeting.endIndex.predecessor()] //endIndex is character of last characters. predessor is the previous character from the index.
        print(lastChar)
        // !
        let secondChar = greeting[greeting.startIndex.successor()]
        //successor is the next character after the index
        print(secondChar)
        // u
        
        let eighthCharIndex = greeting.startIndex.advancedBy(7)
        print(greeting[eighthCharIndex])
        // a
        
        
        //indices to return Range of index.
        for index in greeting.characters.indices {
            print("\(greeting[index]) ", terminator: "")
        }
        print("")
        // prints "G u t e n   T a g ! "

    }
    
    func insertingRemovingChars() -> Void {
        print("----------------------- insert and removing chars------------------------")
        
        //insert single character
        var welcome = "hello"
        welcome.insert("!", atIndex: welcome.endIndex)
        print(welcome)
        // welcome now equals "hello!"
        
        //insert another string
        welcome.insertContentsOf(" there".characters, at: welcome.endIndex.predecessor())
        print(welcome)
        // welcome now equals "hello there!"
        
        //remove character
        welcome.removeAtIndex(welcome.endIndex.predecessor())
        print(welcome)
        // welcome now equals "hello there"

        //remove substring.
        let range = welcome.endIndex.advancedBy(-6)..<welcome.endIndex // from character o(which is space) till the last character(which is e)
        welcome.removeRange(range)
        print(welcome)
        // welcome now equals "hello"
    }
    
    func compareStrings() -> Void {
        print("----------------------- compare strings ------------------------")
        
        let quotation = "We're a lot alike, you and I."
        let sameQuotation = "We're a lot alike, you and I."
        if quotation == sameQuotation {
            print("These two strings are considered equal")
        }
        // Prints "These two strings are considered equal"
        
        let characterA : Character = "A"
        if characterA == "A" {
            print("These two charactes are same")
        }
        
    }
    
    func stringHasPrefixSuffix() -> Void {
        print("----------------------- string has prefix and suffix ------------------------")
        let romeoAndJuliet = [
            "Act 1 Scene 1: Verona, A public place",
            "Act 1 Scene 2: Capulet's mansion",
            "Act 1 Scene 3: A room in Capulet's mansion",
            "Act 1 Scene 4: A street outside Capulet's mansion",
            "Act 1 Scene 5: The Great Hall in Capulet's mansion",
            "Act 2 Scene 1: Outside Capulet's mansion",
            "Act 2 Scene 2: Capulet's orchard",
            "Act 2 Scene 3: Outside Friar Lawrence's cell",
            "Act 2 Scene 4: A street in Verona",
            "Act 2 Scene 5: Capulet's mansion",
            "Act 2 Scene 6: Friar Lawrence's cell"
        ]
        
        var act1SceneCount = 0
        for scene in romeoAndJuliet {
            if scene.hasPrefix("Act 1 ") {
                act1SceneCount += 1
            }
        }
        print("There are \(act1SceneCount) scenes in Act 1")
        // Prints "There are 5 scenes in Act 1"
        
        var mansionCount = 0
        var cellCount = 0
        for scene in romeoAndJuliet {
            if scene.hasSuffix("Capulet's mansion") {
                mansionCount += 1
            } else if scene.hasSuffix("Friar Lawrence's cell") {
                cellCount += 1
            }
        }
        print("\(mansionCount) mansion scenes; \(cellCount) cell scenes")
        // Prints "6 mansion scenes; 2 cell scenes"

    }
}