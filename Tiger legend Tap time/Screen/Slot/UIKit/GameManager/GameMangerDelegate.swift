//
//  GameMangerDelegate.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation
protocol GameManagerDelegate {
    func updateLabel()
    func updateWinLabel(with win: Int)
    func showAlertPopUPForBet()
    func makeASelectItemsInCollectionView()
}

enum TypeOfBet {
    case up
    case down
}

extension GameManager {
    func increaseOrDecreaseBet(with typeOfBet: TypeOfBet) {
        if AppData.shared.player.coins < 10 {
            delegate?.showAlertPopUPForBet()
        } else {
            switch typeOfBet {
            case .up: increaseBet()
            case .down: decreaseBet()
                
            }
        }
    }
    
    func increaseBet() {
        let potentialBet = 200
           if AppData.shared.player.coins >= potentialBet {
               delegate?.updateLabel()
           } else {
               
           }
    }
    
    func decreaseBet() {
        if bet > 10 {
                bet -= stepForIncreaseBet
                if bet < 10 {
                    bet = 10
                }
            delegate?.updateLabel()
            }
    }
}

class PayLines {
    
    let payline4 = [(0,0), (1,1), (2,2), (3,1), (4,0)]
    let payLine5 = [(0,2), (1,1), (2,0), (3,1), (4,2)]
    let payLine6 = [(0,1), (1,0), (2,0), (3,0), (4,1)]
    let payLine7 = [(0,1), (1,2), (2,2), (3,2), (4,1)]
    let payline8 = [(0,0), (1,0), (2,1), (3,2), (4,2)]
    let payLine9 = [(0,2), (1,2), (2,1), (3,0), (4,0)]
    let payline12 = [(0,0), (1,1), (2,1), (3,1), (4,0)]
    let payline13 = [(0,2), (1,1), (2,1), (3,1), (4,2)]
    
    let payLine1 = [(1,0),(1,1),(1,2),(1,3)]
    static let shared: PayLines = PayLines()
    
    
}
