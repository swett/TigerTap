//
//  ClaimView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import SwiftUI

struct ClaimView: View {
    @Binding var isShowing: Bool
    var amount: Int
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
                            Image("coin")
                                .resizable()
                                .frame(width: 70, height: 70)
                        }
                        .padding(.bottom, 20)
                        .offset(y: -30)
                        Text("You have received an award")
                            .foregroundStyle(Color.theme.mainTextColor)
                            .font(.system(size: 18, weight: .bold))
                            .offset(y: -30)
                        HStack {
                            Image("coin")
                                .resizable()
                                .frame(width: 18, height: 18)
                            Text("+\(amount)")
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 18, weight: .bold))
                        }
                        .offset(y: -30)
                        Button {
//                            isShowing = false
                            action()
                        } label: {
                            Text("Continue".uppercased())
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 16, weight: .bold))
                                .frame(width: 285, height: 43)
                                .background(Color.theme.orangeColor)
                                .cornerRadius(10)
                        }
                        .offset(y: -10)
                    }
                    
                }
            }
    }
}

#Preview {
    ClaimView(isShowing: .constant(false), amount: 100, action: {})
}
