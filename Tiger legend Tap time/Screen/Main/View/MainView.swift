//
//  MainView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    @State private var showingOptions = false
    @State private var showingNameChange = false
    @State private var showPlusFive: Bool = false
    @State private var tapLocation: CGPoint = .zero
    @State private var buttonScale: CGFloat = 1.0
    @State private var tapLocations: [TapLocation] = []
    @State private var showLeague = false
    @State var updateUI: Bool = false
    var body: some View {
        ZStack(alignment: .top) {
            Image("preloader")
                .resizable()
                .ignoresSafeArea(.all)
            VStack {
                header
                main
                    .padding(.top,DeviceType.IS_SMALL ? 10 : 92)
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
                    BottomSheetView(isOpen: $showingNameChange, maxHeight: 393) {
                        ZStack {
                            LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .leading, endPoint: .trailing)
                                .edgesIgnoringSafeArea(.all)
                            ChangeNameView(isShowing: $showingNameChange)
                                .environmentObject(viewModel.settingViewModel!)
                                .padding(.bottom, 150)
                            
                        }
                        
                        
                    }
                    .edgesIgnoringSafeArea(.all)
                }
            }
            
            
            if showLeague {
                ZStack {
                    VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                        .edgesIgnoringSafeArea(.all)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                showLeague.toggle()
                            }
                            
                        }
                    BottomSheetView(isOpen: $showLeague, maxHeight: 593) {
                        ZStack {
                            LinearGradient(colors: [Color(hex: "#141925"), Color(hex: "#060910")], startPoint: .leading, endPoint: .trailing)
                                .edgesIgnoringSafeArea(.all)
                            LeaguesView()
                                .background(.clear)
                                .environmentObject(viewModel)
                                .padding(.bottom, 150)
                            
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
    MainView(viewModel: MainViewModel())
}

extension MainView {
    private var header: some View {
        HStack {
            Image("profileIcon")
                .onTapGesture {
                    showingNameChange.toggle()
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
    }
}


extension MainView {
    private var main: some View {
        VStack {
            HStack {
                Image("coin")
                Text("\(viewModel.settingViewModel!.updatePlayer.coins)")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundStyle(Color.theme.mainTextColor)
                    .id(updateUI)
            }
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    Image("\(viewModel.getImageByLeague())")
                        .shadow(color:Color(hex: "#000000").opacity(0.14),radius: 20, x: -8, y: -8)
                        .shadow(color:Color(hex: "#000000").opacity(0.3),radius: 20, x: 8, y: 8)
                        .scaleEffect(buttonScale)
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onEnded { value in
                                    let tapPosition = value.location
                                    tapAction(at: tapPosition)
                                }
                        )
                        .animation(.spring(), value: buttonScale)
                        .overlay {
                            if showPlusFive {
                                ForEach(tapLocations) { tapLocation in
                                    Text("+5")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.theme.mainTextColor)
                                        .position(x: tapLocation.location.x, y: tapLocation.location.y)
                                        .opacity(showPlusFive ? 1 : 0)
                                        .shadow(color: Color(hex: "#FF0404"), radius: 5)
                                        .animation(.easeOut(duration: 1).delay(0.2), value: showPlusFive)
                                }
                                
                            }
                        }
                    
                }
            }
            .frame(width: 250, height: 250)
            
            HStack {
                HStack {
                    Image("energyIcon")
                    Text("\(viewModel.batteryCharge) / 1000")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundStyle(Color.theme.mainTextColor)
                }
                Spacer()
                VStack {
                    HStack {
                        Text("\(viewModel.leagueMilestones[viewModel.leaguePosition - 1].name)")
                            .font(.system(size: 13, weight: .regular))
                            .foregroundStyle(Color.theme.mainTextColor)
                        Image("chevron-right")
                        Spacer()
                        Text("\(viewModel.leaguePosition)/8")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(Color.theme.mainTextColor.opacity(0.7))
                    }
                    .frame(width: 140)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            showLeague.toggle()
                        }
                    }
                    ProgressView(value: viewModel.progress, total: 1)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(LinearGradient(colors: [Color(hex: "#992703"), Color(hex: "#FF4004")], startPoint: .top, endPoint: .bottom))
                        .frame(width: 140)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
        }
    }
}


extension MainView {
    func tapAction(at location: CGPoint) {
        if viewModel.batteryCharge >= 5 {
            viewModel.batteryCharge -= 5
            viewModel.settingViewModel!.updateCoinsAndTaps()
            showPlusFive = true
            let newTapLocation = TapLocation(location: location)
            tapLocations.append(newTapLocation)
            buttonScale = 1.2
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                buttonScale = 1.0
            }
            withAnimation(.easeOut(duration: 1).delay(0.5)) {
                showPlusFive = false
                tapLocations.removeAll { $0.id == newTapLocation.id }
            }
            viewModel.updateLeague()
            if viewModel.timer == nil {
                viewModel.startTimer()
            }
            
        } else {
            // Not enough battery charge
        }
    }
}




