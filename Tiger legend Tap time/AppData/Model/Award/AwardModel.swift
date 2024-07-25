//
//  AwardModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 15.07.2024.
//

import Foundation

enum AwardType: Equatable {
    case rateApp
    case inviteFriend
    case shareOnSocialMedia
    case watchAd
    case dailyBonus(day: Int)
}

struct Award: Equatable {
    var type: AwardType
    var isCompleted: Bool
    var reward: Int
    var lastClaimed: Date?
}
