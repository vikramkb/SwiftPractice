//
//  Subscript.swift
//  SwiftPractice
//
//  Created by vikramkb on 7/17/16.
//  Copyright © 2016 vikramkb. All rights reserved.
//

import Foundation

class Subscript {
    func start() {
        subscriptExample()
        twoDimensionalMatrix()
        
    }
    
    func subscriptExample() {
        print("----------------------- subscript example ------------------------")
        
        struct TimesTable {
            let multiplier: Int
            subscript(index: Int) -> Int {
                return multiplier * index
            }
        }
        let threeTimesTable = TimesTable(multiplier: 3)
        print("six times three is \(threeTimesTable[6])")
        // Prints "six times three is 18"
    }
    
    func twoDimensionalMatrix() {
        print("----------------------- two dimensional matrix ------------------------")
        
        struct Matrix {
            let rows: Int, columns: Int
            var grid: [Double]
            init(rows: Int, columns: Int) {
                self.rows = rows
                self.columns = columns
                grid = Array(count: rows * columns, repeatedValue: 0.0)
            }
            func indexIsValidForRow(row: Int, column: Int) -> Bool {
                return row >= 0 && row < rows && column >= 0 && column < columns
            }
            subscript(row: Int, column: Int) -> Double {
                get {
                    assert(indexIsValidForRow(row, column: column), "Index out of range")
                    return grid[(row * columns) + column]
                }
                set {
                    assert(indexIsValidForRow(row, column: column), "Index out of range")
                    grid[(row * columns) + column] = newValue
                }
            }
            
            func printMatrix() {
                for i in 0...rows-1 {
                    for j in 0...columns-1{
                        print(self[i,j], terminator:" ")
                    }
                    print("")
                }
            }
        }
        
        var matrix = Matrix(rows: 2, columns: 2)
        matrix[0, 1] = 1.5
        matrix[1, 0] = 3.2
        matrix.printMatrix()
    }
}