//
//  SettingsCell.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
import SwiftUI

struct StaticCellView: View {
    let option: String
    var onTap: () -> Void
    var body: some View {
        HStack {
            Text(option)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(Color.theme.mainTextColor)
            Spacer()
            Image("next")
        }
        .padding(.horizontal, 36)
        .frame(height: 30)
        .onTapGesture {
            onTap() // Call the closure when tapped
        }
    }
}
