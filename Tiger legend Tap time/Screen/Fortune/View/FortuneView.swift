//
//  FortuneView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI
import SwiftMessages
struct FortuneView: View {
    @ObservedObject var viewModel: FortuneViewModel
    @State private var showingOptions = false
    @State private var showingNameChange = false
    var body: some View {
        ZStack(alignment: .top) {
            Image("preloader")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                header
                main
                    .padding(.top,DeviceType.IS_SMALL ? -10 :  12)
            }
            if showingOptions {
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showingOptions.toggle()
                            }
                            
                        }
                    BottomSheetView(isOpen: $showingOptions, maxHeight: 393) {
                        ZStack {
                            LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .leading, endPoint: .trailing)
                                .edgesIgnoringSafeArea(.all)
                            SettingsView()
                                .environmentObject(viewModel.settingViewModel!)
                                .padding(.bottom, 150)
                            
                        }
                        
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            
            if showingNameChange {
                
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showingNameChange.toggle()
                            }
                            
                        }
                    BottomSheetView(isOpen: $showingNameChange, maxHeight: 500) {
                        ZStack {
                            LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .leading, endPoint: .trailing)
                                .edgesIgnoringSafeArea(.all)
                            ChangeNameView(isShowing: $showingNameChange)
                                .environmentObject(viewModel.settingViewModel!)
                                .padding(.bottom, 350)
                            
                        }
                        
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .onAppear {
            viewModel.settingViewModel?.updateOnAppear()
            viewModel.updateUI.toggle()
        }
    }
}

#Preview {
    FortuneView(viewModel: FortuneViewModel())
}


extension FortuneView {
    private var header: some View {
        HStack {
            HStack {
                Image("profileIcon")
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            showingNameChange.toggle()
                        }
                    }
                Text("\(viewModel.settingViewModel!.updatePlayer.name)")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.theme.mainTextColor)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            showingNameChange.toggle()
                        }
                    }
                Spacer()
                Button {
                    withAnimation(.easeInOut) {
                        showingOptions = true
                    }
                    
                } label: {
                    Image("settingButton")
                }
            }
            .padding(.horizontal, 16)
        }
    }
}


extension FortuneView {
    private var main: some View {
        VStack {
            HStack {
                Image("coin")
                Text("\(viewModel.settingViewModel!.updatePlayer.coins)")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(Color.theme.mainTextColor)
                    .id(viewModel.updateUI)
            }
            
            ZStack {
                
                Circle()
                    .frame(width: 313, height: 313)
                    .foregroundStyle(LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .topLeading, endPoint: .bottomTrailing))
                Circle()
                    .frame(width: 293, height: 293)
                    .foregroundStyle(Color(hex: "#060910"))
                Circle()
                    .frame(width: 132, height: 132)
                    .foregroundStyle(Color(hex: "#FF0404").opacity(0.6))
                    .blur(radius: 60)
                SFWView(prizes: $viewModel.prizes, configuration: $viewModel.wheelConfiguration, isMonochrome: $viewModel.isMonochrome, isWithLine: $viewModel.drawCurvedLine, onSpinButtonTap: $viewModel.onRotateTap, rotateToIndex: viewModel.rotateToIndex.eraseToAnyPublisher(), shouldRedraw: viewModel.shouldRedraw.eraseToAnyPublisher())
                    .frame(width: 285,  height: 285,  alignment: .center)
                
                Circle()
                    .frame(width: 34, height: 34)
                    .foregroundStyle(Color.theme.orangeColor)
                    .shadow(color: Color(hex: "#FF0404"),radius: 35)
                Image("topImage")
                    .shadow(color: Color(hex: "#FF0404"),radius: 35)
                    .offset(y:-149)
            }
            .padding(.top, 10)
            
            
            
            Button {
                if viewModel.settingViewModel!.updatePlayer.coins < 100 {
                    let message = DemoMessage(title: "You not have enough coins", body: "")
                               let messageView = MessageHostingView(id: message.id, content: DemoMessageView(message: message))
                               SwiftMessages.show(view: messageView)
                    
                } else {
                    viewModel.settingViewModel!.updatePlayer.minusCoins(amount: 100)
                    viewModel.onRotateTap!()
                }
                
            } label: {
                Text("Spin")
                    .foregroundStyle(Color.theme.mainTextColor)
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 351, height: 43)
                    .background(Color.theme.orangeColor)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            Text("The cost of one spin is 100 coins")
                .foregroundStyle(Color.theme.mainTextColor.opacity(0.7))
                .font(.system(size: 13, weight: .bold))
        }
    }
}
