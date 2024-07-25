//
//  PreloaderViewModel.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import Foundation

class PreloaderViewModel: ObservableObject {
    private let coordinator: CoordinatorProtocol?
    init(coordinator: CoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
}


extension PreloaderViewModel {
    func showMain() {
        coordinator?.showMainScreen()
    }
}
