//
//  SocialNetworksPopUpView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 14.07.2024.
//

import SwiftUI

struct SocialNetworksPopUpView: View {
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
                            Text("Share on social networks")
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 18, weight: .bold))
                            Text("Share on social networks and earn\n 250 coins!")
                                .foregroundStyle(Color.theme.mainTextColor.opacity(0.5))
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                        }
                        .padding(.bottom, 10)
                        .offset(y: -20)
                       
                        HStack {
                            Image("facebook")
                                .onTapGesture {
                                    UIPasteboard.general.string = "https://www.example.com?code=TigerLegendTapTime"
                                    isAvaliable = true
                                }
                            Spacer()
                            Image("twitter")
                                .onTapGesture {
                                    UIPasteboard.general.string = "https://www.example.com?code=TigerLegendTapTime"
                                    isAvaliable = true
                                }
                            Spacer()
                            Image("linkiden")
                                .onTapGesture {
                                    UIPasteboard.general.string = "https://www.example.com?code=TigerLegendTapTime"
                                    isAvaliable = true
                                }
                        }
                        .offset(y: -25)
                        .padding(.horizontal, 79.5)
                        Button {
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
    SocialNetworksPopUpView(isShowing: .constant(false), action: {})
}
