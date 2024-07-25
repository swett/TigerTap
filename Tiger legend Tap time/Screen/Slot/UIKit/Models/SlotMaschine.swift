//
//  SlotMaschine.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation
enum SymbolType: Equatable, Hashable {
    case wild
    case scatter
    case bonus
    case coin
    case card(String)
    case themed(String)
    // Add more cases as needed for different themes
}

struct Symbol {
    let type: SymbolType
    let frequency: Int
    let winFactors: [Int]?
    let image: String
    init(type: SymbolType, frequency: Int, winFactors: [Int], image: String) {
        self.type = type
        self.frequency = frequency
        self.winFactors = winFactors
        self.image = image
    }
    
    // Equatable conformance
      static func ==(lhs: Symbol, rhs: Symbol) -> Bool {
          return lhs.type == rhs.type &&
                 lhs.frequency == rhs.frequency &&
                 lhs.winFactors == rhs.winFactors &&
                 lhs.image == rhs.image
      }
}
struct SlotMachineSection {
    let symbols: [Symbol]
    
    init(symbols: [Symbol]) {
        self.symbols = symbols
    }
}
    
