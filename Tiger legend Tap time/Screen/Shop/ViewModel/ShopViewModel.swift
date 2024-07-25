//
//  ShopViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
class ShopViewModel: ObservableObject {
    @Published  var shopManager = ShopManager.shared
    @Published var products: [CoinProduct] = []
    @Published var purchaseStatus: Bool = false
    @Published var showPopUpResult: Bool = false
    @Published var playerUpdate: PlayerModel = AppData.shared.player
    @Published var settingViewModel : SettingsViewModel?
    private let coordinator: CoordinatorProtocol?
    var buyHandler: (CoinProduct) -> Void = {_ in }
    var view: TabViewVC?
    init(coordinator: CoordinatorProtocol? = nil, view: TabViewVC? = nil) {
        self.coordinator = coordinator
        self.view = view
        self.bind()
        self.setupSettingsModel()
    }
}

extension ShopViewModel {
    func fetchProducts() async {
        await shopManager.fetchProducts()
        DispatchQueue.main.async {
            self.products = self.shopManager.coinProducts
        }
    }
    
    func fetch() {
        Task {
            await fetchProducts()
        }
    }
    
    func buyProduct(product: CoinProduct) async {
        
        
        let success = await shopManager.purchase(productID: product.id)
        DispatchQueue.main.async {
            print(success)
            self.purchaseStatus = success
            self.showPopUpResult = true
            if success {
                self.playerUpdate.addBank(amount: product.amount)
                AppData.shared.player = self.playerUpdate
                AppData.shared.savePlayerStats()
            }
        }
    }
    
    func bind() {
        buyHandler = { product in
            print(product)
            Task {
                await self.buyProduct(product: product)
            }
        }
    }
    
    func setupSettingsModel() {
        settingViewModel = SettingsViewModel(coordinator: self.coordinator, view: view)
    }
}
