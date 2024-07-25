//
//  FortuneViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
import SwiftFortuneWheel
import Combine

class FortuneViewModel: ObservableObject {
    @Published var updateUI: Bool = false
    @Published var settingViewModel : SettingsViewModel?
    var view: TabViewVC?
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil, view: TabViewVC? = nil) {
        self.coordinator = coordinator
        self.view = view
        setupSettingsModel()
        prizes.append(Prize(amount: 100, description: "", priceType: .money))
        prizes.append(Prize(amount: 1000, description: "", priceType: .money))
        prizes.append(Prize(amount: 0, description: "", priceType: .money))
        prizes.append(Prize(amount: 10, description: "", priceType: .money))
        prizes.append(Prize(amount: 100, description: "", priceType: .money))
        prizes.append(Prize(amount: 1000, description: "", priceType: .money))
        prizes.append(Prize(amount: 0, description: "", priceType: .money))
        prizes.append(Prize(amount: 10, description: "", priceType: .money))
        onRotateTap = {
            self.finishIndex = self.prizes.randomIndex()
            self.rotateToIndex.send(self.finishIndex)
        }
    }
    
    
    @Published var showPopup: Bool = false
    /// Array of prizes
    @Published var prizes: [Prize] = [] {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Configurator for SwiftFortuneWheel, customizes appearance
    @Published var wheelConfiguration: SFWConfiguration = .blackCyanColorsConfiguration {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Should draw a line or not on SwiftFortuneWheel
    @Published var drawCurvedLine: Bool = false {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Responsible for whether the text should be the black color everywhere or not
    @Published var isMonochrome: Bool = false {
        didSet {
            self.shouldRedraw.send(true)
        }
    }
    
    /// Used to bind to the segment index
    @Published var colorIndex = 0 {
        didSet {
            wheelConfiguration = .blackCyanColorsConfiguration
        }
    }
    
    /// Used to bind to the TextField text
    /// Spinning of wheel will stop on the finishIndex
    @Published var finishIndex: Int = 0 {
        didSet {
                   // Trigger the popup when finishIndex changes
            DispatchQueue.main.asyncAfter(deadline: .now() + 9) {
                self.spinAmountAdd()
            }
                   
               }
    }
    
    /// On spin button tap
    @Published var onRotateTap: (() -> Void)?
    
    /// Will rotate the wheel to specified index
    let rotateToIndex = PassthroughSubject<Int, Never>()
    /// Will redraw the wheel
    let shouldRedraw = PassthroughSubject<Bool, Never>()
    
    /// Minimum prizes size
    let minimumPrize: Int = 0
    /// Maximum prizes size
    var maximumPrize: Int = 12
    

    
    
}

extension FortuneViewModel {
    func spinAmountAdd() {
        settingViewModel?.updateBank(reward:prizes[finishIndex].amount)
        updateUI.toggle()
        
    }
    
    func setupSettingsModel() {
        settingViewModel = SettingsViewModel(coordinator: self.coordinator, view: view)
    }
}
