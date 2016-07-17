//
//  OptionalChaining.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class OptionalChaining {
    func start() {
        accessingPropertiesThroughOptionalChaining()
        callingMethodsThroughOptionalChaining()
        accessingSubscriptsThroughOptionalChaining()
        accessingSubscriptsOfOptionalType()
        linkingMultipleLevelsOfChaining()
    }
    
    func accessingPropertiesThroughOptionalChaining() {
        print("----------------------- accessing properties through optional chaining ------------------------")
        let john = Person()
        //john.residence is nil
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        // Prints "Unable to retrieve the number of rooms."
        
        
        john.residence?.address?.printAddress()
        john.residence = createResidence()
        //john.residence is not nil so it will go to if block
        if let roomCount = john.residence?.numberOfRooms {
            print("John's residence has \(roomCount) room(s).")
        } else {
            print("Unable to retrieve the number of rooms.")
        }
        john.residence?.address = createAddress()
        //prints address
        john.residence?.address?.printAddress()
        
    }
    
    func callingMethodsThroughOptionalChaining() {
        print("----------------------- calling methods through optional chaining ------------------------")
        let john = Person()

        if john.residence?.printNumberOfRooms() != nil {
            print("It was possible to print the number of rooms.")
        } else {
            print("It was not possible to print the number of rooms.")
        }
    }
    
    func accessingSubscriptsThroughOptionalChaining() {
        print("----------------------- access subscripts through optional chaining ------------------------")
        let john = Person()
        
        if let firstRoomName = john.residence?[0].name {
            print("The first room name is \(firstRoomName).")
        } else {
            print("Unable to retrieve the first room name.")
        }
        // Prints "Unable to retrieve the first room name."
        
    }
    
    func accessingSubscriptsOfOptionalType() {
        print("----------------------- access subscripts of optional type ------------------------")
        var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
        testScores["Dave"]?[0] = 91
        testScores["Bev"]?[0] += 1
        testScores["Brian"]?[0] = 72
        print( "testScores['Dave']?[0] = \(testScores["Dave"]?[0])" ) // prints 91
        print( "testScores['Vishu'][4]? = \(testScores["Vishu"]?[0])" ) // testScores["Vishu"] is nil
    }
    
    func linkingMultipleLevelsOfChaining() {
        print("----------------------- linking multiple levels of chaining ------------------------")
        let john = Person()
        john.residence = createResidence()
        john.residence?.address = createAddress()
        
        if let johnsStreet = john.residence?.address?.street {
            print("John's street name is \(johnsStreet).")
        } else {
            print("Unable to retrieve the address.")
        }
        // Prints "Unable to retrieve the address."
        

    }
    class Person {
        var residence: Residence?
    }
    
    class Room {
        let name: String
        init(name: String) { self.name = name }
    }
    
    class Address {
        var buildingName: String?
        var buildingNumber: String?
        var street: String?
        func buildingIdentifier() -> String? {
            if buildingName != nil {
                return buildingName
            } else if buildingNumber != nil && street != nil {
                return "\(buildingNumber) \(street)"
            } else {
                return nil
            }
        }
        
        func printAddress() {
            print("building number : \(buildingNumber), building name : \(buildingName)")
        }
    }
    
    class Residence {
        var rooms = [Room]()
        var numberOfRooms: Int {
            return rooms.count
        }
        subscript(i: Int) -> Room {
            get {
                return rooms[i]
            }
            set {
                rooms[i] = newValue
            }
        }
        func printNumberOfRooms() {
            print("The number of rooms is \(numberOfRooms)")
        }
        var address: Address?
    }
    
    func createAddress() -> Address {
        let someAddress = Address()
        someAddress.buildingNumber = "29"
        someAddress.street = "Acacia Road"
        
        return someAddress
    }
    
    func createResidence() -> Residence {
        var rooms = [Room]()
        let hall = Room(name: "Hall")
        let kitchen = Room(name: "Kitchen")
        let bedRoom = Room(name: "Bedroom")
        let kidsRoom = Room(name: "Kidsroom")
        
        let home = Residence()
        rooms.append(hall)
        rooms.append(kitchen)
        rooms.append(bedRoom)
        rooms.append(kidsRoom)
        home.rooms = rooms
        return home
    }
    
}