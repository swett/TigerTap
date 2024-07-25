//
//  TabViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import Foundation
enum Tab: Int, CaseIterable, Identifiable {
  case fortune = 0, slots = 1, main = 2, bonuses = 3, shop = 4
    var title: String{
            switch self {
            case .slots:
                return ""
            case .fortune:
                return ""
            case .main:
                return ""
            case .bonuses:
                return ""
            case .shop:
                return ""
            }
        }
        
        var iconName: String{
            switch self {
            case .slots:
                return "slots"
            case .fortune:
                return "fortune"
            case .main:
                return "main"
            case .bonuses:
                return "bonuses"
            case .shop:
                return "shop"
            }
        }
    var id: Self { self }
 }


class TabViewModel: ObservableObject {
    
    var fortuneViewModel: FortuneViewModel?
    var shopViewModel: ShopViewModel?
    var slotsViewModel: SlotsViewModel?
    var dailyViewModel: DailyViewModel?
    var mainViewModel: MainViewModel?
    @Published var selectedTab: Tab = .main
    @Published var previousTab: Tab = .main
    var view: TabViewVC?
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil) {
        self.coordinator = coordinator
        self.updateModels()
    }
}


extension TabViewModel {
    func updateModels() {
        mainViewModel = MainViewModel(coordinator: self.coordinator, view: view)
        fortuneViewModel = FortuneViewModel(coordinator: self.coordinator, view: view)
        shopViewModel = ShopViewModel(coordinator: self.coordinator, view: view)
        slotsViewModel = SlotsViewModel(coordinator: self.coordinator, view: view)
        dailyViewModel = DailyViewModel(coordinator: self.coordinator, view: view)
    }
    
    func setView(_ view: TabViewVC) {
              self.view = view
              updateModels() // Ensure the models are set up correctly after setting the view
          }
}
