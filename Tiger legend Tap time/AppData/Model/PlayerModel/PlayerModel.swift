//
//  PlayerModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import Foundation

struct PlayerModel: Identifiable, Codable {
    let id: UUID = UUID()
    var coins: Int = 0
    var taps: Int = 0
    var name: String = ""
    
    mutating func updateTaps() {
        self.taps += 1
    }
    
    mutating func addCoins() {
        self.coins += 5
    }
    
    mutating func minusCoins(amount: Int) {
        self.coins -= amount
    }
    
    mutating func updateName(newName: String) {
        self.name = newName
    }
    mutating func addBank(amount: Int) {
        self.coins += amount
    }
    var formattedCoins: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: coins)) ?? "\(coins)"
    }
}
