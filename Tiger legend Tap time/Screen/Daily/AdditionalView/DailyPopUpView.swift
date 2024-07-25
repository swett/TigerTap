//
//  DailyPopUpView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 19.07.2024.
//

import SwiftUI

struct DailyPopUpView: View {
    @Binding var isShowing: Bool
    var model: Award
    var action: () -> Void
    @EnvironmentObject var viewModel: DailyViewModel
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .topLeading, endPoint: .bottomLeading))
            .frame(width: 349, height: 563)
            .overlay {
                ZStack(alignment: .topLeading) {
                    
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                isShowing.toggle()
                            } label: {
                                Image("closeButton")
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.bottom, 0)
                        
                        ZStack {
                            Image("dailyAward")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .blur(radius: 10)
                            Image("dailyAward")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        
                        
                        Text("Daily reward")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.theme.mainTextColor)
                        Text("Accrue coins for logging into the game daily without skipping")
                            .multilineTextAlignment(.center)
                            .font(.system(size: 16, weight: .regular))
                            .foregroundStyle(Color.theme.mainTextColor.opacity(0.5))
                            .padding(.top, 5)
                        
                        LazyVGrid(columns: [GridItem(.fixed(64), spacing: 20),GridItem(.fixed(64), spacing: 20),GridItem(.fixed(64), spacing: 20),GridItem(.fixed(64), spacing: 20)]) {
                            ForEach(1...10, id: \.self) {
                                item in
                                DailyAwardCell(day: item, reward:  calculateReward(for: item), claimed: claimedBonus(day: item), canClaim: canClaimDailyBonus(day: item), award: model
                                )
                            }
                        }
                        .padding(.top, 5)
                        Button {
                            let currentDay = (AppData.shared.dailyBonusStreak % 10) + 1
                            if canClaimDailyBonus(day: currentDay) {
                                action()
                            } else {
                            
                            }
                            
                        } label: {
                            Text("Claim".uppercased())
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: 285, height: 43)
                                .background(Color.theme.orangeColor)
                                .cornerRadius(10)
                        }
                        .padding(.top, 9)
                    }
                }
            }
    }
    
    func calculateReward(for day: Int) -> Int {
            switch day {
            case 1: return 500
            case 2: return 1000
            case 3: return 2500
            case 4: return 5000
            case 5: return 15000
            case 6: return 25000
            case 7: return 100000
            case 8: return 500000
            case 9: return 1000000
            case 10: return 5000000
            default: return 0
            }
        }
    func claimedBonus(day: Int) -> Bool {
        if day <= AppData.shared.dailyBonusStreak && AppData.shared.isAvaliableToCallChips {
            return false
        } else {
           return false
        }
    }
        
    func canClaimDailyBonus(day: Int) -> Bool {
           guard let lastClaimed = model.lastClaimed else { return true }
           let currentDate = Date()
           let timeInterval = currentDate.timeIntervalSince(lastClaimed)
           return timeInterval >= 24 * 60 * 60
       }
}

#Preview {
    DailyPopUpView(isShowing: .constant(false), model: Award(type: .dailyBonus(day: 1), isCompleted: false, reward: 100, lastClaimed: nil), action: {})
        .environmentObject(DailyViewModel())
}
