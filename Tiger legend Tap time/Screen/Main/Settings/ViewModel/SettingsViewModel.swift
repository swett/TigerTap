//
//  SettingsViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var updatePlayer: PlayerModel = AppData.shared.player
    @Published var name: String = ""
    @Published var showPrivacy: Bool = false
    @Published var showSupport: Bool = false
    @Published var showInstructions: Bool = false
    private let coordinator: CoordinatorProtocol?
    var view: TabViewVC?
       init(coordinator: CoordinatorProtocol? = nil, view: TabViewVC? = nil) {
           self.coordinator = coordinator
           self.view = view
           updateOnAppear()
       }
}


extension SettingsViewModel {
    func showPolicy() {
        print("policy")
        showPrivacy.toggle()
    }
    func callSupport() {
        print("support")
        showSupport.toggle()
    }
    
    func showInstrcution() {
        print("instructions")
        showInstructions.toggle()
    }
}


extension SettingsViewModel {
    func updateOnAppear() {
        updatePlayer = AppData.shared.getPlayerStats()
    }
    
    func updateName(name: String) { // function for update player name
        updatePlayer.updateName(newName: name)
        AppData.shared.player = updatePlayer
        AppData.shared.savePlayerStats()
    }
    
    func updateCoinsAndTaps() {
        updatePlayer.addBank(amount: 5)
        updatePlayer.updateTaps()
        AppData.shared.player = updatePlayer
        AppData.shared.savePlayerStats()
        print(AppData.shared.player)
    }
    
    func updateBank(reward: Int) {
        updatePlayer.addBank(amount: reward)
        AppData.shared.player = updatePlayer
        AppData.shared.savePlayerStats()
    }
}
