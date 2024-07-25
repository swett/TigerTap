//
//  GameScreenView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import Foundation
import SwiftUI
import UIKit
struct GameScreenView: UIViewControllerRepresentable {
    let viewModel: SlotsViewModel

    func makeUIViewController(context: Context) -> GameScreenVC {
        let gameScreenVC = GameScreenVC(viewModel: viewModel)
        return gameScreenVC
    }

    func updateUIViewController(_ uiViewController: GameScreenVC, context: Context) {
        // Update the view controller if needed.
//        uiViewController.updateUI()
    }

    static func dismantleUIViewController(_ uiViewController: GameScreenVC, coordinator: ()) {
        // Perform cleanup if necessary.
    }
}

