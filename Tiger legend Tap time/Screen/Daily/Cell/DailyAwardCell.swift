//
//  DailyAwardCell.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 19.07.2024.
//

import SwiftUI

struct DailyAwardCell: View {
    var day: Int
    var reward: Int
    var claimed: Bool
    var canClaim: Bool
    var award: Award
    var body: some View {
        VStack {
            Text("Day \(day)")
                .foregroundStyle(Color.theme.mainTextColor)
                .font(.system(size: 12, weight: .bold))
            Image("coin")
                .resizable()
                .frame(width: 24, height: 24)
            Text("\(reward.formattedTo)")
                .foregroundStyle(Color.theme.mainTextColor)
                .font(.system(size: 12, weight: .bold))
        }
        .frame(width: 64, height: 80)
        .background( claimed ? LinearGradient(colors: [Color(hex: "#5FC669"), Color(hex: "#2C7332")], startPoint: .top, endPoint: .bottom) : LinearGradient(colors: [Color.theme.mainTextColor.opacity(0.1)], startPoint: .top, endPoint: .bottom) )
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(award.type == .dailyBonus(day: day) ? Color(hex: "#52B15B") : Color.theme.mainTextColor.opacity(0.17), lineWidth: 1)
                
                
        }
    }
}

#Preview {
    DailyAwardCell(day: 1, reward: 100, claimed: false, canClaim: true, award: Award(type: .dailyBonus(day: 1), isCompleted: false, reward: 100))
}
