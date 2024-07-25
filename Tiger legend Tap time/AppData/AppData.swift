//
//  AppData.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
class AppData: NSObject {
    
    
    fileprivate override init() {
        super.init()
        if !UserDefaults.standard.bool(forKey: "isDataLoaded"){
            defaultLoad()
            UserDefaults.standard.set(true, forKey: "isDataLoaded")
        } else {
            loadData()
        }
    }
    
    
    var defaultData: UserDefaults = UserDefaults.standard
    
    var isNotifications: Bool {
        get {
            return defaultData.bool(forKey: Keys.notifications)
        }
        set {
            defaultData.set(newValue, forKey: Keys.notifications)
        }
    }
    
    var isAvaliableToCallChips: Bool {
        get {
            return defaultData.bool(forKey: Keys.keyforCallChipsAvaliable)
        }
        
        set {
            defaultData.set(newValue, forKey: Keys.keyforCallChipsAvaliable)
        }
    }
    
    var isLastCallDate: Date {
        get {
            return defaultData.object(forKey: Keys.keyforLastCallChips) as? Date ?? Date()
        }
        set {
            defaultData.set(newValue, forKey: Keys.keyforLastCallChips)
        }
    }
    
    var isInviteFriendDate: Date {
        get {
            return defaultData.object(forKey: Keys.keyIsCallFriend) as? Date ?? Date()
        }
        
        set {
            defaultData.set(newValue, forKey: Keys.keyIsCallFriend)
        }
    }
    
    var dailyBonusStreak: Int {
        get {
            return defaultData.integer(forKey: "dailyBonusStreak")
        }
        set {
            defaultData.set(newValue, forKey: "dailyBonusStreak")
        }
    }
    
    
    var player: PlayerModel = PlayerModel()
    
    static let shared: AppData = AppData()
}


extension AppData {
    func defaultLoad() {
        savePlayerStats()
        dailyBonusStreak = 1
        isAvaliableToCallChips = true
    }
    
    func loadData() {
        player = getPlayerStats()
    }
}



extension AppData {
    func savePlayerStats() {
        let encoder = JSONEncoder()
        let key = Keys.playerStats
        guard let data = try? encoder.encode(player) else {
            return
        }
        defaultData.set(data, forKey: key)
    }
    
    func getPlayerStats() -> PlayerModel {
        let decoder = JSONDecoder()
        let key = Keys.playerStats
        player = try! decoder.decode(PlayerModel.self, from: defaultData.data(forKey: key)!)
        return player
    }
    
    func saveLastClaimDate(for type: AwardType, date: Date?) {
        guard let date = date else { return }
        let key = "\(type)-lastClaimed"
        defaultData.set(date, forKey: key)
    }
    
    func loadLastClaimDate(for type: AwardType) -> Date? {
        let key = "\(type)-lastClaimed"
        return defaultData.object(forKey: key) as? Date
    }
    
    func updateLastInviteDate() {
        isLastCallDate = Date().addingTimeInterval(3600)
        isInviteFriendDate = Date().addingTimeInterval(3600)
    }
    
    func canInviteFriend() -> Bool {
        return Date().timeIntervalSince(loadLastClaimDate(for: .inviteFriend)!) >= 3600
        
    }
}



