//
//  ArrayUtils.swift
//  TicTacToe
//
//  Created by Zach Jiroun on 2/12/16.
//  Copyright © 2016 Zach Jiroun. All rights reserved.
//

import Foundation


// Taken from http://stackoverflow.com/a/32999166
// Splits an array into equally sized chunks (used to create GameBoards)
extension Array {
    func chunk(chunkSize : Int) -> Array<Array<Element>> {
        return 0.stride(to: self.count, by: chunkSize)
            .map { Array(self[$0..<$0.advancedBy(chunkSize, limit: self.count)]) }
    }
}

// Taken from http://stackoverflow.com/a/29588187
// Calculates if all elements of an array are equal
func allEqual<T : Equatable>(array : [T]) -> Bool {
    if let firstElem = array.first {
        return !array.dropFirst().contains { $0 != firstElem }
    }
    return true
}

func flipArray<T>(array: [[T]]) -> [[T]] {
    var toReturn: [[T]] = []
    for var rowIndex = 0; rowIndex < array.count; rowIndex++ {
        var temp: [T] = []
        for var colIndex = 0; colIndex < array[0].count; colIndex++ {
            temp.append(array[colIndex][rowIndex])
        }
        toReturn.append(temp)
    }
    return toReturn
}