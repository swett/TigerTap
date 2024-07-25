//
//  AwardCells.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import SwiftUI

struct AwardCells: View {
    @Binding var award: Award
    var canClaim: Bool
    var action: () -> Void
    var body: some View {
        HStack {
            ZStack {
                Image("\(getImageByText(type: award.type))")
                    .resizable()
                    .frame(width: 44, height: 44)
                    .blur(radius: 10)
                Image("\(getImageByText(type: award.type))")
                    .resizable()
                    .frame(width: 44, height: 44)
            }
            VStack(alignment: .leading) {
                Text("\(getTextByType(type: award.type))")
                    .foregroundStyle(Color.theme.mainTextColor.opacity(0.5))
                    .font(.system(size: 16, weight: .regular))
                HStack {
                    Image("coin")
                        .resizable()
                        .frame(width: 18, height: 18)
                    Text("+\(award.type == .dailyBonus(day: AppData.shared.dailyBonusStreak) ? 6649000: award.reward)")
                        .foregroundStyle(Color.theme.mainTextColor)
                        .font(.system(size: 18, weight: .bold))
                }
            }
            Spacer()
            Button {
                if award.isCompleted {
                    
                } else {
                    action()
                }
                
            } label: {
                Image(award.isCompleted ? "check-circle":"next")
            }
        }
        .padding(.horizontal, 16)
        .frame(height: 72)
        .background(Color.theme.mainTextColor.opacity(0.1))
        .cornerRadius(10)
        .padding(.horizontal, 16)
    }
}

#Preview {
    AwardCells(award: .constant(Award(type: .inviteFriend, isCompleted: false, reward: 500)), canClaim: true, action: {})
}


extension AwardCells {
    func getTextByType(type: AwardType) -> String {
        switch type {
        case .rateApp:
            return "Leave a review about the app"
        case .inviteFriend:
            return "Recommend the app to a friend"
        case .shareOnSocialMedia:
            return "Share the app on social media"
        case .watchAd:
            return "Watch the video"
        case .dailyBonus(_):
            return "Daily rewards"
        }
    }
    
    func getImageByText(type: AwardType) -> String {
        switch type {
        case .rateApp:
            return "award"
        case .inviteFriend:
            return "recomend"
        case .shareOnSocialMedia:
            return "shareSocial"
        case .watchAd:
            return "playAds"
        case .dailyBonus(_):
            return "dailyAward"
        }
    }
}
