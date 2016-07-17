//
//  Protocols.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

protocol FullyNamed {
    var fullName: String { get }
}

protocol RandomNumberGenerator {
    func random() -> Double
}

protocol Togglable {
     mutating func toggle()
}

protocol License {
    init(number: String)
}



class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

/*DiceGame is the protocol followed by the games which uses Dice. Which will delegate the dice game progression responsibility to DiceGameDelegate protocol*/
protocol DiceGame {
    var dice: Dice { get }
    func play()
}
protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}


protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

protocol Vehicle {
    func start()
    func stop()
}

protocol DefenceVehicle :class, Vehicle {
    func launch()
}

protocol Gun {
    func shoot()
}

extension Gun {
    func shoot() {
        print("shooting is in progress........")
    }
}


//A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements.
class Protocols {
    func start() {
        propertyRequirements()
        methodRequirements()
        mutatingMethodRequirements()
        initializerRequirements()
        protocolsAsTypes()
        delegation()
        addingProtocolConformanceWithAnExtension()
        declaringProtocolAdoptionWithAnExtension()
        collectionOfProtocolTypes()
        protocolInheritance()
        classOnlyProtocols()
        protocolExtension()
        addingConstraintsToProtocolExtensions()
    }
    
    func propertyRequirements() {
        print("----------------------- property requirements ------------------------")
        
        struct Person: FullyNamed {
            var fullName: String
        }
        let john = Person(fullName: "John Appleseed")
        // john.fullName is "John Appleseed"
        print("must use fullName in Person class")
        print("person name = \(john.fullName)")
    }
    
    //must implement protocol methods.
    func methodRequirements() {
        print("----------------------- method requirements ------------------------")
        
        let generator = LinearCongruentialGenerator()
        print("Here's a random number: \(generator.random())")
        // Prints "Here's a random number: 0.37464991998171"
        print("And another one: \(generator.random())")
        // Prints "And another one: 0.729023776863283"
    }
    
    //mutating is required to alter the self. If the protocal method can change the self then mutating keyword should be used
    func mutatingMethodRequirements() {
        print("----------------------- mutating method requirements ------------------------")
        enum OnOffSwitch: Togglable {
            case Off, On
             mutating func toggle() {
                switch self {
                case Off:
                    self = On
                case On:
                    self = Off
                }
            }
        }
        var lightSwitch = OnOffSwitch.Off
        lightSwitch.toggle()
        if lightSwitch == OnOffSwitch.On {
            print("light is on")
        }else{
            print("light is off")
        }
    }
    
    func initializerRequirements() {
        print("----------------------- initializer requirements ------------------------")
        
        class DrivingLicense : License {
            var number : String
            required init(number: String) {
                self.number = number
            }
        }
        
        print("protocol init force you to provide the implementation for the initializer")
        
    }
    
    /*
     Protocols do not actually implement any functionality themselves. Nonetheless, any protocol you create will become a fully-fledged type for use in your code.
     
     Because it is a type, you can use a protocol in many places where other types are allowed, including:
     
     As a parameter type or return type in a function, method, or initializer
     
     As the type of a constant, variable, or property
     
     As the type of items in an array, dictionary, or other container
    */

    func protocolsAsTypes() {
        print("----------------------- protocols as types ------------------------")
        
        let d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())
        for _ in 1...5 {
            print("Random dice roll is \(d6.roll())")
        }

    }
    
    //     Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated.

    func delegation() {
        print("----------------------- delegation ------------------------")
        
        
        /* SnakesAndLadders is the DiceGame, which will notify the game start, game end and dice roll to DiceGameTracker so that it will do necessary things*/
        class SnakesAndLadders: DiceGame {
            let finalSquare = 25
            let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
            var square = 0
            var board: [Int]
            init() {
                board = [Int](count: finalSquare + 1, repeatedValue: 0)
                board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
                board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
            }
            var delegate: DiceGameDelegate?
            func play() {
                square = 0
                delegate?.gameDidStart(self) //deletegation
                gameLoop: while square != finalSquare {
                    let diceRoll = dice.roll()
                    delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)  //deletegation
                    switch square + diceRoll {
                    case finalSquare:
                        break gameLoop
                    case let newSquare where newSquare > finalSquare:
                        continue gameLoop
                    default:
                        square += diceRoll
                        square += board[square]
                    }
                }
                delegate?.gameDidEnd(self) //deletegation
            }
        }
        
        class DiceGameTracker: DiceGameDelegate {
            var numberOfTurns = 0
            func gameDidStart(game: DiceGame) {
                numberOfTurns = 0
                if game is SnakesAndLadders {
                    print("Started a new game of Snakes and Ladders")
                }
                print("The game is using a \(game.dice.sides)-sided dice")
            }
            func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
                numberOfTurns += 1
                print("Rolled a \(diceRoll)")
            }
            func gameDidEnd(game: DiceGame) {
                print("The game lasted for \(numberOfTurns) turns")
            }
        }
        
        let tracker = DiceGameTracker()
        let game = SnakesAndLadders()
        game.delegate = tracker
        game.play()
        
    }
    
    //    You can extend an existing type to adopt and conform to a new protocol, even if you do not have access to the source code for the existing type.
    func addingProtocolConformanceWithAnExtension() {
        print("----------------------- adding protocol conformance with an extension ------------------------")
        
        let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
        print(d12.textualDescription)
        // Prints "A 12-sided dice"
    }
    
    //    If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:
    func declaringProtocolAdoptionWithAnExtension() {
        print("----------------------- declaring protocol adoption with an extension ------------------------")
        
        //though Hamster implements the methods of protocol TextRepresentable, but it was not stated. Later using empty extension, Hamster stated to extend from TextRepresentable
        let simonTheHamster = Hamster(name: "Simon")
        let somethingTextRepresentable: TextRepresentable = simonTheHamster
        print(somethingTextRepresentable.textualDescription)
        // Prints "A hamster named Simon"
        
    }
    
    func collectionOfProtocolTypes() {
        print("----------------------- collection of protocol types ------------------------")
        class Animal : TextRepresentable {
            var textualDescription: String
            init(name: String) {
                textualDescription = name
            }
        }
        class Bird : TextRepresentable {
            var textualDescription: String
            init(name: String) {
                textualDescription = name
            }
        }
        
        //collection of prototypes
        let things: [TextRepresentable] = [Animal(name: "dog"), Bird(name: "peacock"), Animal(name: "elephent"), Bird(name: "duck")]
        
        for thing in things {
            print(thing.textualDescription)
        }
    }
    
    //     A protocol can inherit one or more other protocols and can add further requirements on top of the requirements it inherits.
    func protocolInheritance() {
        print("----------------------- protocol inheritance ------------------------")
        
        //Vehicle prototype -> DefenceVehicle prototype
        //ArmyTanker has to implement the methods of Vehicle and Defence Vehicle prototypes
        class ArmyTanker : DefenceVehicle {
            func start() {
                print("starting Vehicle")
            }
            func stop() {
                print("stopiing Vehicle")
            }
            func launch() {
                print("launching missile")
            }
        }
        
        let tank = ArmyTanker()
        tank.start()
        tank.launch()
        tank.stop()
    }
    
    func classOnlyProtocols() {
        print("----------------------- class only protocols ------------------------")
        //The DefenceVehicle inherits Vehicle protocol to only used by class. Not by struct or enum. class keyword will be used in the syntax
        class ArmyTanker : DefenceVehicle {
            func start() {
                print("starting Vehicle")
            }
            func stop() {
                print("stopiing Vehicle")
            }
            func launch() {
                print("launching missile")
            }
        }
        let vehicle : Vehicle = ArmyTanker()
        vehicle.start()
        vehicle.stop()
    }
    
    //    Protocols can be extended to provide method and property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
    func protocolExtension() {
        print("----------------------- protocol extension ------------------------")
        //shoot is implemented on protocol itself using extension
        class MachineGun : Gun {
            
        }
        MachineGun().shoot()
    }
    
    func addingConstraintsToProtocolExtensions() {
        print("----------------------- Adding Constraints to Protocol Extensions ------------------------")
        print("yet to be done.......")
    }
    
    class LinearCongruentialGenerator: RandomNumberGenerator {
        var lastRandom = 42.0
        let m = 139968.0
        let a = 3877.0
        let c = 29573.0
        func random() -> Double { //must implement random function
            lastRandom = ((lastRandom * a + c) % m)
            return lastRandom / m
        }
    }
    
}