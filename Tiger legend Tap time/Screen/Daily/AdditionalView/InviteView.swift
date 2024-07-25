//
//  InviteView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 06.07.2024.
//

import SwiftUI

struct InviteView: View {
    @Binding var isShowing: Bool
    @State var isAvaliable: Bool = false
    var action: () -> Void
    var body: some View {
        RoundedRectangle(cornerRadius: 30)
            .foregroundStyle(LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .topLeading, endPoint: .bottomLeading))
            .frame(width: 350, height: 319)
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
                        .offset(y: 10)
                        VStack {
                            ZStack {
                                Image("award")
                                    .blur(radius: 10)
                                Image("award")
                            }
                            .padding(.bottom, 5)
                            Text("Invite a friend")
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 18, weight: .bold))
                            Text("Invite a friend to use our app and earn 500 coins!")
                                .foregroundStyle(Color.theme.mainTextColor.opacity(0.5))
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom, 10)
                        .offset(y: -20)
                       
                        Text("https://www.example.com?code=TigerLegendTapTime")
                            .tint(Color.theme.mainTextColor.opacity(0.5))
                            .multilineTextAlignment(.leading)
                            .lineLimit(1) // Ensure the text stays on one line
                            .padding(.horizontal, 20)
                            .truncationMode(.tail)
                            .frame(width: 285, height: 51)
                            .offset(x: -10)
                            .padding(.horizontal, 5)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white.opacity(0.17), lineWidth: 2)
                                    .background(Color.white.opacity(0.1))
                            )
                            .cornerRadius(10)
                            .offset(y: -25)
                            .overlay(alignment: .trailing) {
                                Button {
                                    UIPasteboard.general.string = "https://www.example.com?code=TigerLegendTapTime"
                                    isAvaliable = true
                                } label: {
                                    Image("copy")
                                }
                                .offset(x: -10,y:-25)
                            }
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
                        .allowsHitTesting(isAvaliable)
                    }
                    
                }
            }
    }
}

#Preview {
    InviteView(isShowing: .constant(false), action: {})
}
