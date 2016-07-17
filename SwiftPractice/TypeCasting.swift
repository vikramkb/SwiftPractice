//
//  TypeCasting.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class TypeCasting {
    func start() {
        definingAClassHierarchyForTypeCasting()
        downCasting()
        anyObject()
        any()
    }

    //Type casting in Swift is implemented with the is and as operators
    func definingAClassHierarchyForTypeCasting() {
        print("----------------------- defining a class hierarchy for type casting ------------------------")
        
        var movieCount = 0
        var songCount = 0
        
        for item in library {
            if item is Movie {
                movieCount += 1
            } else if item is Song {
                songCount += 1
            }
        }
        
        print("Media library contains \(movieCount) movies and \(songCount) songs")
        // Prints "Media library contains 2 movies and 3 songs"
        
    }
    
    //as? to downcast. returns nil if down cast is not possible.
    //as! to assume downcast is possible
    func downCasting() {
        print("----------------------- down casting ------------------------")
        
        func getFormattedName(mediaItem : MediaItem) -> String {
            if let movie = mediaItem as? Movie { //downcasting to Movie
                return String("Movie: \(movie.name), dir. \(movie.director)")
            } else if let song = mediaItem as? Song {  //downcasting to Song
                return String("Song: \(song.name), by \(song.artist)")
            }
            return String("error")
        }
        //MediaItem->Movie->Song
        for item in library {
            print(getFormattedName(item))
        }
        
        // Movie: Casablanca, dir. Michael Curtiz
        // Song: Blue Suede Shoes, by Elvis Presley
        // Movie: Citizen Kane, dir. Orson Welles
        // Song: The One And Only, by Chesney Hawkes
        // Song: Never Gonna Give You Up, by Rick Astley
        

    }
    
    //AnyObject can represent an instance of any class type.
    func anyObject() {
        print("----------------------- any object ------------------------")
        
        let someObjects: [AnyObject] = [
            Movie(name: "2001: A Space Odyssey", director: "Stanley Kubrick"),
            Movie(name: "Moon", director: "Duncan Jones"),
            Movie(name: "Alien", director: "Ridley Scott")
        ]
        
        for object in someObjects {
            let movie = object as! Movie
            print("Movie: \(movie.name), dir. \(movie.director)")
        }
        // Movie: 2001: A Space Odyssey, dir. Stanley Kubrick
        // Movie: Moon, dir. Duncan Jones
        // Movie: Alien, dir. Ridley Scott

    }
    
    //Any to work with a mix of different types, including function types and non-class types.
    func any() {
        print("----------------------- any ------------------------")
        
        var things = [Any]()
        
        things.append(0)
        things.append(0.0)
        things.append(42)
        things.append(3.14159)
        things.append("hello")
        things.append(Movie(name: "Ghostbusters", director: "Ivan Reitman"))
        things.append({ (name: String) -> String in "Hello, \(name)" })
        
        for thing in things {
            switch thing {
            case 0 as Int:
                print("zero as an Int")
            case 0 as Double:
                print("zero as a Double")
            case let someInt as Int:
                print("an integer value of \(someInt)")
            case let someDouble as Double where someDouble > 0:
                print("a positive double value of \(someDouble)")
            case is Double:
                print("some other double value that I don't want to print")
            case let someString as String:
                print("a string value of \"\(someString)\"")
            case let (x, y) as (Double, Double):
                print("an (x, y) point at \(x), \(y)")
            case let movie as Movie:
                print("a movie called \(movie.name), dir. \(movie.director)")
            case let stringConverter as String -> String:
                print(stringConverter("Michael"))
            default:
                print("something else")
            }
        }

    }
    
    class MediaItem {
        var name: String
        init(name: String) {
            self.name = name
        }
    }
    
    class Movie: MediaItem {
        var director: String
        init(name: String, director: String) {
            self.director = director
            super.init(name: name)
        }
    }
    
    class Song: MediaItem {
        var artist: String
        init(name: String, artist: String) {
            self.artist = artist
            super.init(name: name)
        }
    }
    
    let library = [
        Movie(name: "Casablanca", director: "Michael Curtiz"),
        Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
        Movie(name: "Citizen Kane", director: "Orson Welles"),
        Song(name: "The One And Only", artist: "Chesney Hawkes"),
        Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
    ]
    // the type of "library" is inferred to be [MediaItem]
    
}