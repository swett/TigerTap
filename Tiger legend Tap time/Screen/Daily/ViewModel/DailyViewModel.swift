//
//  DailyViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 06.07.2024.
//

import Foundation


class DailyViewModel: ObservableObject {
    @Published var dailyAwards: [Award] = []
    @Published var repeatableAwards: [Award] = []
    @Published var oneOffAwards: [Award] = []
    @Published var claimedReward: Int?
    @Published var activeAward: Award?
    @Published var showingInvite = false
    @Published var showingRate = false
    @Published var showingSocials = false
    @Published var showingDailyAwardsPopup = false
    @Published var showingAds = false
    @Published var showingClaiming = false
    @Published var settingViewModel : SettingsViewModel?
    var view: TabViewVC?
    let appData = AppData.shared
    var showingClaimBonus: () -> Void = {}
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil, view: TabViewVC? = nil) {
        self.coordinator = coordinator
        self.view = view
        setupSettingsModel()
        loadAwards()
        setupClaimBonus()
        
    }
}

extension DailyViewModel {
    func setupSettingsModel() {
        settingViewModel = SettingsViewModel(coordinator: self.coordinator, view: view)
    }
    func loadAwards() {
        setupDailyAwards()
        repeatableAwards = [
            Award(type: .watchAd, isCompleted: canWatchAd(), reward: 1000, lastClaimed: appData.loadLastClaimDate(for: .watchAd))        ]
        
        oneOffAwards = [
            Award(type: .rateApp, isCompleted: canClaimOneOffAward(.rateApp), reward: 1000, lastClaimed:  appData.loadLastClaimDate(for: .rateApp)),
            
            Award(type: .shareOnSocialMedia, isCompleted: canClaimOneOffAward(.shareOnSocialMedia), reward: 250, lastClaimed:  appData.loadLastClaimDate(for: .shareOnSocialMedia))
        ]
    }
    
    func setupClaimBonus() {
        showingClaimBonus = {
            switch self.activeAward?.type {
            case .rateApp:
                self.showingClaiming.toggle()
                self.claimActiveAward()
                self.settingViewModel?.updateBank(reward: self.activeAward!.reward)
            case .inviteFriend:
                self.showingClaiming.toggle()
                self.claimActiveAward()
                self.settingViewModel?.updateBank(reward:  self.activeAward!.reward)
             
            case .shareOnSocialMedia:
                self.showingSocials = false
                self.showingClaiming.toggle()
                self.claimActiveAward()
                self.settingViewModel?.updateBank(reward:  self.activeAward!.reward)
                
            case .watchAd:
                self.showingAds = false
                self.showingClaiming = false
                self.claimActiveAward()
                self.settingViewModel?.updateBank(reward:  self.activeAward!.reward)
            case .dailyBonus(_):
                self.showingDailyAwardsPopup.toggle()
                self.claimActiveAward()
                self.settingViewModel?.updateBank(reward:  self.activeAward!.reward)
                
            case .none:
                break
            }
        }
    }
}

extension DailyViewModel {
    
    func setupDailyAwards() {
        print(appData.dailyBonusStreak)
        let canClaimBonus = canClaimDailyBonus(day: appData.dailyBonusStreak)
        dailyAwards = [
            Award(type: .inviteFriend, isCompleted: !canInviteFriend(), reward: 500, lastClaimed: appData.loadLastClaimDate(for: .inviteFriend)),
            Award(type: .dailyBonus(day: appData.dailyBonusStreak), isCompleted: !canClaimBonus, reward: calculateReward(for: appData.dailyBonusStreak), lastClaimed: nil)
        ]
    }
    
    
    func calculateReward(for day: Int) -> Int {
        
        switch day {
        case 1: return 500
        case 2: return 1000
        case 3: return 2500
        case 4: return 5000
        case 5: return 15000
        case 6: return 25000
        case 7: return 100000
        case 8: return 500000
        case 9: return 1000000
        case 10: return 5000000
        default: return 0
        }
    }
    func completeAward(_ award: Award) {
        activeAward = award
        switch award.type {
        case .inviteFriend:
            showingInvite.toggle()
        case .rateApp:
            showingRate.toggle()
        case .shareOnSocialMedia:
            showingSocials.toggle()
        case .watchAd:
            showingAds.toggle()
        case .dailyBonus(day: _):
            showingDailyAwardsPopup.toggle()
        }
        
    }
    
    func claimActiveAward() {
        guard let award = activeAward else { return }
        
        switch award.type {
        case .dailyBonus(let day):
            if canClaimDailyBonus(day: day) {
                if let index = dailyAwards.firstIndex(where: { $0.type == .dailyBonus(day: day) }) {
                    dailyAwards[index].isCompleted = true
                    dailyAwards[index].lastClaimed = Date()
                    appData.saveLastClaimDate(for: .dailyBonus(day: day), date: dailyAwards[index].lastClaimed)
                    if appData.dailyBonusStreak >= 10 {
                        appData.dailyBonusStreak = 1
                    } else {
                        appData.dailyBonusStreak += 1
                    }
                   
                    appData.isAvaliableToCallChips = false
                    appData.isLastCallDate = Date()
                    claimedReward = dailyAwards[index].reward
                    activeAward = dailyAwards[index]
                    setupDailyAwards()
                }
            }
            
        case .inviteFriend:
            if let index = dailyAwards.firstIndex(where: { $0.type == .inviteFriend }) {
                dailyAwards[index].isCompleted = true
                dailyAwards[index].lastClaimed = Date()
                appData.saveLastClaimDate(for: .inviteFriend, date: dailyAwards[index].lastClaimed)
                claimedReward = dailyAwards[index].reward
                activeAward = dailyAwards[index]
                setupDailyAwards()
            }
        case .watchAd:
            if let index = repeatableAwards.firstIndex(where: { $0.type == .watchAd }) {
                repeatableAwards[index].isCompleted = true
                repeatableAwards[index].lastClaimed = Date()
                appData.saveLastClaimDate(for: .watchAd, date: Date())
                claimedReward = repeatableAwards[index].reward
                activeAward = repeatableAwards[index]
            }
        case .rateApp:
            if let index = oneOffAwards.firstIndex(where: { $0.type == .rateApp }) {
                oneOffAwards[index].isCompleted = true
                oneOffAwards[index].lastClaimed = Date()
                appData.saveLastClaimDate(for: .rateApp, date: oneOffAwards[index].lastClaimed)
                claimedReward = oneOffAwards[index].reward
                activeAward = oneOffAwards[index]
            }
        case .shareOnSocialMedia:
            if let index = oneOffAwards.firstIndex(where: { $0.type == .shareOnSocialMedia }) {
                oneOffAwards[index].isCompleted = true
                oneOffAwards[index].lastClaimed = Date()
                appData.saveLastClaimDate(for: .shareOnSocialMedia, date: oneOffAwards[index].lastClaimed)
                claimedReward = oneOffAwards[index].reward
                activeAward = oneOffAwards[index]
            }
        }
    }
    
//    var currentDay: Int {
//        let streak = appData.dailyBonusStreak
//        return streak % 10 + 1
//    }

    
    func canClaimDailyBonus(day: Int) -> Bool {
        let isBonusClaimed = AppData.shared.isAvaliableToCallChips
        print(isBonusClaimed)
        return isBonusClaimed
        
    }

    
    func canWatchAd() -> Bool {
        if let lastClaimed = appData.loadLastClaimDate(for: .watchAd) {
            return Date().timeIntervalSince(lastClaimed) <= 5 * 60 * 60
        } else {
            return false
        }
        
    }
    func canInviteFriend() -> Bool {
        guard appData.loadLastClaimDate(for: .inviteFriend) != nil else {
               return true
           }
        return appData.canInviteFriend()
    }
    func canClaimOneOffAward(_ type: AwardType) -> Bool {
        guard appData.loadLastClaimDate(for: type) != nil else {
               return false
           }
        let lastClaimed = appData.loadLastClaimDate(for: type)
        return lastClaimed != nil
    }
    
}
