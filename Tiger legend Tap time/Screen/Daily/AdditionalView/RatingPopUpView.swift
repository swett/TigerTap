//
//  RatingPopUpView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 06.07.2024.
//

import SwiftUI

struct RatingPopUpView: View {
    @Binding var isShowing: Bool
    @State var rating: Int = 0
    @State var isAvaliable: Bool = false
    var action: () -> Void
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .topLeading, endPoint: .bottomLeading))
            .frame(width: 349, height: 319)
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
                            Image("award")
                                .blur(radius: 10)
                            Image("award")
                        }
                        .padding(.bottom, 20)
                        .offset(y: -30)
                        Text("Enjoying Tiger legend: Tap time?")
                            .foregroundStyle(Color.theme.mainTextColor)
                            .font(.system(size: 18, weight: .bold))
                            .offset(y: -30)
                        Text("Tap a star to rate it on the App Store.")
                            .foregroundStyle(Color.theme.mainTextColor.opacity(0.5))
                            .font(.system(size: 16, weight: .regular))
                            .offset(y: -30)
                        RatingView(rating: $rating, isAvaliable: $isAvaliable, highestRate: 5)
                            .offset(y: -20)
                        Button {
                            isShowing.toggle()
                            action()
                        } label: {
                            Text("Claim Bonus".uppercased())
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: 285, height: 43)
                                .background(Color.theme.orangeColor)
                                .cornerRadius(10)
                        }
                        .opacity(isAvaliable ? 1 : 0.45)
                        .offset(y: -10)
                    }
                    
                }
            }
    }
}

#Preview {
    RatingPopUpView(isShowing: .constant(false), action: {})
}
