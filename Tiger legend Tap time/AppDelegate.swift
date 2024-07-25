//
//  AppDelegate.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    
    var window: UIWindow?
    var coordinator: Coordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        coordinator = Coordinator(navigationController: NavigationVC())
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = coordinator?.rootViewController
        window?.makeKeyAndVisible()
        coordinator?.showPreloader()
        
        return true
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        guard let lastCallChips = UserDefaults.standard.object(forKey: Keys.keyforLastCallChips) as? Date else {
            return
        }
        guard let hour = Calendar.current.dateComponents([.hour], from: lastCallChips, to: Date()).hour else {
            return
        }
        
        guard hour != 0 else {
            AppData.shared.isAvaliableToCallChips = false
            return
        }
        
        if hour >= 24 {
            AppData.shared.isAvaliableToCallChips = true
        }
        
    }

}

