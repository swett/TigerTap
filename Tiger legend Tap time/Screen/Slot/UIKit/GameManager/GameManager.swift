//
//  GameManager.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation



class GameManager {
    var gameElementsArray: [SlotMachineSection] = []
    var winningPositions: [[Int]] = []
    var bet: Int = 200
    var stepForIncreaseBet: Int = 10
    var delegate: GameManagerDelegate?
    var winElements: [(Int, Int)] = []
    var isJackpot: Bool = false
    var totalWinAll: Int = 0
}


extension GameManager {
    func createElementsForGame() -> [SlotMachineSection] {
        let allSymbols: [Symbol] = [
            Symbol(type: .themed("brilliant"), frequency: 4, winFactors: [1, 5, 20], image: "element0"),
            Symbol(type: .themed("raspberry"), frequency: 4, winFactors: [1, 5 , 20], image: "element1"),
            Symbol(type: .themed("bar"), frequency: 3, winFactors: [1, 5, 20], image: "element2"),
            Symbol(type: .themed("7"), frequency: 1, winFactors: [1, 8, 30], image: "element3"),
            Symbol(type: .themed("clover"), frequency: 3, winFactors: [1,8,30], image: "element4"),
            Symbol(type: .themed("goldenCherry"), frequency: 1, winFactors: [6, 20, 150], image: "element5"),
            Symbol(type: .themed("goldenRaspberry"), frequency: 1, winFactors: [25, 200, 700], image: "element6")
        ]
        var tempSections: [SlotMachineSection] = []
        for _ in 0..<4 {
            let sectionSymbols = createSectionSymbols(using: allSymbols)
            let section = SlotMachineSection(symbols: sectionSymbols)
            tempSections.append(section)
        }
        
        return tempSections
    }
    func createSectionSymbols(using symbols: [Symbol]) -> [Symbol] {
        var sectionSymbols: [Symbol] = []
        
        for symbol in symbols {
            for _ in 0..<symbol.frequency {
                sectionSymbols.append(symbol)
            }
        }
        
        return sectionSymbols.shuffled()
    }
    func createElements() {
        gameElementsArray = createElementsForGame()
    }
}



extension GameManager {
    func checkCombinations(for matrix: [[Symbol]], withBet bet: Int, withIndexPath indexPaths: [[[Int]]], payline: [(Int, Int)]) -> Int {
        var totalWin = 0
        var winElements: [(Int, Int)] = []
        
        // Helper function to check if the positions match the payline
        func isPayline(_ positions: [(Int, Int)]) -> Bool {
            guard positions.count == payline.count else { return false }
            for (index, position) in positions.enumerated() {
                if position != payline[index] {
                    return false
                }
            }
            return true
        }
        
        // Check rows for wins
        for (rowIndex, row) in matrix.enumerated() {
            var matchCount = 1
            var previousSymbol: Symbol? = nil
            var winElementsInRow: [(Int, Int)] = []
            
            for (colIndex, symbol) in row.enumerated() {
                if let prevSymbol = previousSymbol, prevSymbol.type == symbol.type {
                    matchCount += 1
                } else {
                    matchCount = 1
                }
                
                previousSymbol = symbol
                
                if matchCount >= 3 {
                    let index = matchCount - 3
                    if let winFactors = symbol.winFactors {
                        let winAmountRow = bet * winFactors[index]
                        let positions = (0..<matchCount).map { offset in
                            (rowIndex, colIndex - offset)
                        }
                        
                        if isPayline(positions) {
                            totalWin += winAmountRow
                            for i in 0..<matchCount {
                                let winRow = indexPaths[rowIndex][colIndex - i][0]
                                let winColumn = indexPaths[rowIndex][colIndex - i][1]
                                winElementsInRow.append((winRow, winColumn))
                            }
                        }
                    }
                }
            }
            winElements.append(contentsOf: winElementsInRow)
        }
        
        // Transpose the matrix and indexPaths
        var transposedArray: [[Symbol]] = []
        for colIndex in 0..<matrix[0].count {
            var column: [Symbol] = []
            for row in matrix {
                column.append(row[colIndex])
            }
            transposedArray.append(column)
        }
        
        var swappedPathArray: [[[Int]]] = []
        for colIndex in 0..<indexPaths[0].count {
            var column: [[Int]] = []
            for row in indexPaths {
                column.append(row[colIndex])
            }
            swappedPathArray.append(column)
        }
        
        // Check columns for wins
        for (colIndex, column) in transposedArray.enumerated() {
            var matchCount = 1
            var previousSymbol: Symbol? = nil
            var winElementsInColumn: [(Int, Int)] = []
            
            for (rowIndex, symbol) in column.enumerated() {
                if let prevSymbol = previousSymbol, prevSymbol.type == symbol.type {
                    matchCount += 1
                } else {
                    matchCount = 1
                }
                
                previousSymbol = symbol
                
                if matchCount >= 3 {
                    let index = matchCount - 3
                    if let winFactors = symbol.winFactors {
                        let winAmountCol = bet * winFactors[index]
                        let positions = (0..<matchCount).map { offset in
                            (rowIndex, colIndex - offset)
                        }
                        
                        if isPayline(positions) {
                            totalWin += winAmountCol
                            for i in 0..<matchCount {
                                let winRow = swappedPathArray[rowIndex][colIndex - i][0]
                                let winColumn = swappedPathArray[rowIndex][colIndex - i][1]
                                winElementsInColumn.append((winRow, winColumn))
                            }
                        }
                    }
                }
            }
            winElements.append(contentsOf: winElementsInColumn)
        }
        
        // Update UI and delegate
        print("Winning positions: \(winElements)")
        print("Total Win: \(totalWin)")
        totalWinAll = totalWin
        if totalWin > 0 {
            delegate?.updateLabel()
            delegate?.updateWinLabel(with: totalWin)
            delegate?.makeASelectItemsInCollectionView()
        } else {
            delegate?.updateLabel()
        }
        
        return totalWin
    }
    
}
