//
//  SlotsViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 02.07.2024.
//

import Foundation


class SlotsViewModel: ObservableObject, GameManagerDelegate {

    
    
    var visibleIndexPath: [IndexPath] = []
    @Published var settingViewModel : SettingsViewModel?
    var gameManager: GameManager?
    var view: TabViewVC?
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil, view: TabViewVC? = nil) {
        self.coordinator = coordinator
        self.view = view
        setupSettingsModel()
        self.gameManager = GameManager()
    }
}

extension SlotsViewModel {
    func setupSettingsModel() {
        settingViewModel = SettingsViewModel(coordinator: self.coordinator, view: view)
    }
    func addAVisibleCell(cells: [IndexPath]) {
        visibleIndexPath.removeAll()
        visibleIndexPath = cells
        print(visibleIndexPath)
    }
}

extension SlotsViewModel {
    func updateLabel() {
        settingViewModel?.updatePlayer = AppData.shared.player
    }
    func updateWinLabel(with win: Int) {
        settingViewModel?.updatePlayer = AppData.shared.player
    }
    
    func showLevelUpPopUp() {
        
    }
    
    func showAlertPopUPForBet() {
        
    }
    
    func showAlertPopUpForIncreaseBet() {
        
    }
    
    func makeASelectItemsInCollectionView() {
        
    }
}
