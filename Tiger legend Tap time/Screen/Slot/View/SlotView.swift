//
//  SlotView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI

struct SlotView: View {
    @ObservedObject var viewModel: SlotsViewModel
    @State private var showingOptions = false
    @State private var showingNameChange = false
    @State private var isSpinning = false
    @State var updateUI: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            Image("preloader")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                header
                main
                    .padding(.top,DeviceType.IS_SMALL ? -50 : 12)
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
            viewModel.settingViewModel!.updateOnAppear()
            updateUI.toggle()
        }
    }
    

    
}
#Preview {
    SlotView(viewModel: SlotsViewModel())
}



extension SlotView {
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
            .id(updateUI)
        }
    }
}

extension SlotView {
    private var main: some View {
        VStack(spacing: 0) {
            GameScreenView(viewModel: viewModel)
            Text("The cost of one spin is 200 coins")
                .foregroundStyle(Color.theme.mainTextColor.opacity(0.7))
                .font(.system(size: 13, weight: .bold))
                .offset(y: DeviceType.IS_SMALL ? -100 :  -130)
            
        }
    }
}
