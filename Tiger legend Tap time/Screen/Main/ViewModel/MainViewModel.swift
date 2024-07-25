//
//  MainViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import Foundation
struct LeagueMilestone: Hashable {
    let taps: Int
    let coins: Int
    let name: String
}


class MainViewModel: ObservableObject {
    @Published var batteryCharge: Int = 1000
    @Published var leaguePosition: Int = 1
    @Published var progress: Double = 0.0
    @Published var league: String = "Bronze"
    @Published var timer: Timer?
    @Published var settingViewModel : SettingsViewModel?
    var view: TabViewVC?
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil, view: TabViewVC? = nil) {
        self.coordinator = coordinator
        self.view = view
        setupSettingsModel()
    }
    
    let leagueMilestones: [LeagueMilestone] = [
        LeagueMilestone(taps: 5000, coins: 0, name: "Bronze"),
        LeagueMilestone(taps: 10000, coins: 5000, name: "Silver"),
        LeagueMilestone(taps: 20000, coins: 25000, name: "Gold"),
        LeagueMilestone(taps: 30000, coins: 100000, name: "Platinum"),
        LeagueMilestone(taps: 40000, coins: 1000000, name: "Diamond"),
        LeagueMilestone(taps: 50000, coins: 2000000, name: "Epic"),
        LeagueMilestone(taps: 60000, coins: 50000000, name: "Legendary"),
        LeagueMilestone(taps: 70000, coins: 50000000, name: "Master")
    ]
   
}


extension MainViewModel {
    
    func setupSettingsModel() {
        settingViewModel = SettingsViewModel(coordinator: self.coordinator, view: view)
    }
    
    func getImageByLeague() -> String {
        switch league {
        case "Bronze": return "bronzeLeague"
        case "Silver": return "silverLeague"
        case "Gold": return "goldLeague"
        case "Platinum": return "platinumLeague"
        case "Diamond": return "diamondLeague"
        case "Epic": return "epicLeague"
        case "Legendary": return "legendaryLeague"
        case "Master": return "masterLeague"
        default: break
        }
        return ""
    }
    
    func getImageByLeagueName(name: String) -> String {
        switch name {
        case "Bronze": return "bronzeLeague"
        case "Silver": return "silverLeague"
        case "Gold": return "goldLeague"
        case "Platinum": return "platinumLeague"
        case "Diamond": return "diamondLeague"
        case "Epic": return "epicLeague"
        case "Legendary": return "legendaryLeague"
        case "Master": return "masterLeague"
        default: break
        }
        return ""
    }
    
    func startTimer() {
           timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { _ in
               if self.batteryCharge < 1000 {
                   self.batteryCharge += 3
               } else if self.batteryCharge >= 1000 {
                   self.batteryCharge = 1000
                   self.stopTime()
               }
           }
       }
    
    func stopTime() {
        timer?.invalidate()
    }
    
    func updateLeague() {
        for i in 0..<leagueMilestones.count {
            let milestone = leagueMilestones[i]
            if settingViewModel!.updatePlayer.taps < milestone.taps || (settingViewModel!.updatePlayer.taps >= milestone.taps && settingViewModel!.updatePlayer.coins < milestone.coins) {
                if i == 0 {
                    league = "Bronze"
                    leaguePosition = 1
                    progress = Double(settingViewModel!.updatePlayer.taps) / Double(milestone.taps)
                } else {
                    let previousMilestone = leagueMilestones[i - 1]
                    leaguePosition = i + 1
                    league = previousMilestone.name
                    let totalTapsNeeded = milestone.taps - previousMilestone.taps
                    let totalCoinsNeeded = milestone.coins - previousMilestone.coins
                    let currentTapsProgress = Double(settingViewModel!.updatePlayer.taps - previousMilestone.taps) / Double(totalTapsNeeded)
                    let currentCoinsProgress = Double(settingViewModel!.updatePlayer.coins - previousMilestone.coins) / Double(totalCoinsNeeded)
                    progress = (currentTapsProgress + currentCoinsProgress) / 2
                }
                return
            }
        }
        league = "Master"
        leaguePosition = leagueMilestones.count
        progress = 1.0
    }
    
    
}
