//
//  SpinExtension.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation
import UIKit
extension GameScreenVC {
    func spinCollection() {
        spinButton.isUserInteractionEnabled = false
        
        if (viewModel.settingViewModel?.updatePlayer.coins)! >= viewModel.gameManager!.bet {
            viewModel.settingViewModel?.updatePlayer.coins -= viewModel.gameManager!.bet
            AppData.shared.player = viewModel.settingViewModel!.updatePlayer
            AppData.shared.savePlayerStats() // here player stats update for scroll
            updateBankLabel()
            updateWinAmountLabel()
            
            if !(viewModel.gameManager?.winElements.isEmpty)! {
                makeADeselectItems()
            }
            
            var sectionIndices = Array(0..<4) // Indices of sections
            var shuffledIndices = [Int]() // Store shuffled indices for each section
            
            for _ in 0..<4 {
                let itemCount = collectionView.numberOfItems(inSection: sectionIndices.first ?? 0)
                if itemCount > 0 {
                    let randomIndices = Array(0..<itemCount).shuffled() // Shuffle indices for this section
                    shuffledIndices.append(contentsOf: randomIndices)
                }
                sectionIndices.rotate(shift: 1) // Rotate the section indices to the right
            }
            
            // Scroll through the shuffled indices
            var completedIterations = 0
            
            for (sectionIndex, itemIndex) in shuffledIndices.enumerated() {
                collectionViewScroll(itemIndex: itemIndex, sectionIndex: sectionIndex % 4) {
                    completedIterations += 1
                    
                    if completedIterations == shuffledIndices.count {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                            self.arrayIterationsCompleted()
                            let visibleSymbols = self.retrieveVisibleSymbols()
                            let betAmount = self.viewModel.gameManager?.bet
                            _ = self.viewModel.gameManager?.checkCombinations(for: visibleSymbols, withBet: betAmount!, withIndexPath: self.visibleCellsMatrix, payline: PayLines.shared.payLine1)
                            self.spinButton.isUserInteractionEnabled = true
                        }
                    }
                }
            }
            
        } else {
            
            self.spinButton.isUserInteractionEnabled = true
            
        }
    }
    
    func arrayIterationsCompleted() {
        visibleCellsIndexPaths = collectionView.indexPathsForVisibleItems
        updateVisibleCellsMatrix()
    }
    
    func updateVisibleCellsMatrix() {
        visibleCellsIndexPaths = collectionView.indexPathsForVisibleItems
        let sortedArray = visibleCellsIndexPaths.sorted { (indexPath1, indexPath2) -> Bool in
            if indexPath1.section != indexPath2.section {
                return indexPath1.section < indexPath2.section
            }
            return indexPath1.item < indexPath2.item
        }

        let numRows = 3
        let numColumns = 4

        var reshapedArray = Array(repeating: Array(repeating: [Int](), count: numColumns), count: numRows)

        for (index, indexPath) in sortedArray.enumerated() {
            let row = index / numColumns
            let col = index % numColumns

            if row < numRows && col < numColumns {
                reshapedArray[row][col] = [indexPath.section, indexPath.item]
            }
        }

        visibleCellsMatrix = reshapedArray
    }
    
    func retrieveVisibleSymbols() -> [[Symbol]] {
        var visibleSymbols: [[Symbol]] = []
        
        guard let gameManager = viewModel.gameManager else {
            print("Game manager is nil")
            return visibleSymbols
        }
        
        for row in visibleCellsMatrix {
            var symbolRow: [Symbol] = []
            
            for col in row {
                guard col.count >= 2 else {
                    print(col.count)
                    print("Invalid column format")
                    continue
                }
                
                let rowIndex = col[0]
                let colIndex = col[1]
                
                guard rowIndex < gameManager.gameElementsArray.count else {
                    print("Invalid row index: \(rowIndex)")
                    continue
                }
                
                guard colIndex < gameManager.gameElementsArray[rowIndex].symbols.count else {
                    print("Invalid column index: \(colIndex)")
                    continue
                }
                
                let symbol = gameManager.gameElementsArray[rowIndex].symbols[colIndex]
                symbolRow.append(symbol)
            }
            
            visibleSymbols.append(symbolRow)
        }
        
        return visibleSymbols
    }
    
    func collectionViewScroll(itemIndex: Int, sectionIndex: Int, completion: (() -> Void)?) {
        let indexPath = IndexPath(item: itemIndex, section: sectionIndex)
        UIView.animate(withDuration: TimeInterval.random(in: 0.2...0.7)) {
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
        
        collectionView.setNeedsLayout()
        collectionView.layoutIfNeeded()
        
        if let completion = completion {
            completion()
        }
    }
    
    func makeADeselectItems() {
        if let winElements = viewModel.gameManager?.winElements {
            for (_, indexPath) in winElements.enumerated() {
                collectionView.deselectItem(at: IndexPath(item: indexPath.1, section: indexPath.0), animated: true)
                self.collectionView(self.collectionView, didDeselectItemAt: IndexPath(item: indexPath.1, section: indexPath.0))
            }
        }
    }
    
}

extension Array {
    mutating func rotate(shift: Int) {
        let offsetIndex = shift % self.count
        let slice = self[0..<offsetIndex]
        self.removeSubrange(0..<offsetIndex)
        self.append(contentsOf: slice)
    }
}


extension GameScreenVC {
    @objc func increaseBet() {
        viewModel.gameManager?.increaseOrDecreaseBet(with: .up)
    }
    
    @objc func decreaseBet() {
        viewModel.gameManager?.increaseOrDecreaseBet(with: .down)
    }
    
    func updateBankLabel() {
        print("call bank")
        viewModel.settingViewModel?.updatePlayer = AppData.shared.player
        bankLabel.text = "\(viewModel.settingViewModel!.updatePlayer.formattedCoins)"
        
    }
    
    func updateWinAmountLabel() {
        print("call amount")
        viewModel.settingViewModel?.updatePlayer = AppData.shared.player
    }
}
