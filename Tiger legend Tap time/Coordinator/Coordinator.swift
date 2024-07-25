//
//  Coordinator.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import Foundation
import UIKit
protocol CoordinatorProtocol {
    var rootViewController: UIViewController? { get }
    func showPreloader()
    func showMainScreen()
    func showTermsPolicy()
    func popToMain()
    func popOneScreenBack()
    func hidePopUpScreens()
}

final class Coordinator {
    
    private let navigationController: UINavigationController
    
    init(navigationController: NavigationVC) {
        self.navigationController = navigationController
    }
    
    
}


extension Coordinator: CoordinatorProtocol {
    
    var rootViewController: UIViewController? {
        navigationController
    }
    
    
    func showPreloader() {
        let viewModel = PreloaderViewModel(coordinator: self)
        let preloaderVC = PreloaderVC(viewModel: viewModel)
        navigationController.pushViewController(preloaderVC, animated: true)
    }
    
    func showMainScreen() {
        let viewModel = TabViewModel(coordinator: self)
        let tabViewVC = TabViewVC(viewModel: viewModel)
        navigationController.pushViewController(tabViewVC, animated: true)
    }
    
    func showTermsPolicy() {
//        let viewModel = TermsAndPrivacyViewModel(coordinator: self, termsPrivacy: type)
//        let policyTermsVC = PolicyTermsVC(viewModel: viewModel)
//        navigationController.pushViewController(policyTermsVC, animated: true)
    }

    
    func popOneScreenBack() {
        navigationController.popViewController(animated: true)
    }
    

    
    func popToMain() {
//        for controller in self.navigationController.viewControllers as Array {
//            if controller.isKind(of: MainVC.self) {
//                self.navigationController.popToViewController(controller, animated: true)
//                break
//            }
//        }
    }
    
    func hidePopUpScreens() {
        navigationController.viewControllers.last?.dismiss(animated: true, completion: nil)
    }
    
}
