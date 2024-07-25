//
//  ShopView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI

struct ShopView: View {
    @ObservedObject var viewModel: ShopViewModel
    @State private var showingOptions = false
    @State private var showingNameChange = false
    @State var updateUI: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            Image("preloader")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                header
                cell
                    .padding(.top, 32)
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
                                updateUI.toggle()
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
            viewModel.fetch()
            
        }
    }
}

#Preview {
    ShopView(viewModel: ShopViewModel())
}


extension ShopView {
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

extension ShopView {
    private var cell: some View {
        VStack {
            Image("coin")
                .resizable()
                .frame(width: 130, height: 130)
            Text("Buy coins")
                .foregroundStyle(Color.theme.mainTextColor)
                .font(.system(size: 32, weight: .bold))
            ScrollView(.vertical, showsIndicators: false) {
                ForEach(viewModel.products, id: \.self) {
                    item in
                    ShopCell(model: item, buyHandler: viewModel.buyHandler)
                }
                Spacer(minLength: 120)
            }
        }
    }
}
