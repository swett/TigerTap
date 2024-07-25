//
//  BonusModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 22.07.2024.
//

import Foundation

struct BonusModel: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var claimed: Bool = false
    var amount: Int = 0
    var date: Date
}
