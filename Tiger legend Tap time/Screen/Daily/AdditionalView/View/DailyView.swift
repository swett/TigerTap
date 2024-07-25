//
//  DailyView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI

struct DailyView: View {
    @ObservedObject var viewModel: DailyViewModel
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
                main
                    .padding(.top,DeviceType.IS_SMALL ? -5 :  12)
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
                changeName
            }
            
            if viewModel.showingRate {
                rating
            }
            
            if  viewModel.showingInvite {
                inviteView
            }
            
            if  viewModel.showingSocials {
                socials
            }
            
            if viewModel.showingAds {
                claimView
            }
            
            if viewModel.showingClaiming {
                claimView
            }
            if viewModel.showingDailyAwardsPopup {
                popUpDayli
            }
        }
        .onAppear {
            viewModel.settingViewModel?.updateOnAppear()
            updateUI.toggle()
        }
    }
}

#Preview {
    DailyView(viewModel: DailyViewModel())
}


extension DailyView {
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

extension DailyView {
    private var main: some View {
        VStack {
            Image("coin")
                .resizable()
                .frame(width: 130, height: 130)
                .shadow(color: Color.black.opacity(0.1) ,radius: 20, x: -4, y: -4)
                .shadow(color: Color.black.opacity(0.2) ,radius: 20, x: 4, y: 4)
            Text("Earn more coins")
                .foregroundStyle(Color.theme.mainTextColor)
                .font(.system(size: 32, weight: .bold))
            ScrollView {
                Section(header:
                            HStack {
                    Text("Daily Tasks")
            .foregroundStyle(Color.theme.mainTextColor)
            .font(.system(size: 14, weight: .bold))
                    Spacer()
                }
                    .padding(.horizontal, 16)
                ) {
                    AwardCells(award: $viewModel.dailyAwards[1], canClaim: viewModel.canClaimDailyBonus(day: viewModel.appData.dailyBonusStreak), action: {viewModel.completeAward(viewModel.dailyAwards[1])})
                    AwardCells(award: $viewModel.dailyAwards[0], canClaim: viewModel.canInviteFriend(), action:{ viewModel.completeAward(viewModel.dailyAwards[0])}
                    )
                }
                Section(header:
                            HStack {
                    Text("Repeatable Tasks")
                        .foregroundStyle(Color.theme.mainTextColor)
                        .font(.system(size: 14, weight: .bold))
                    Spacer()
                }
                    .padding(.horizontal, 16)
                ) {
                    ForEach(viewModel.repeatableAwards.indices, id: \.self) { index in
                        AwardCells(award: $viewModel.repeatableAwards[index], canClaim: viewModel.canWatchAd(), action: {
                            viewModel.completeAward(viewModel.repeatableAwards[index])
                        })
                    }
                }
                Section(header:
                            HStack {
                    Text("One-Off Tasks")
                        .foregroundStyle(Color.theme.mainTextColor)
                        .font(.system(size: 14, weight: .bold))
                    Spacer()
                }
                    .padding(.horizontal, 16)
                        
                ) {
                    ForEach(viewModel.oneOffAwards.indices, id: \.self) { index in
                        AwardCells(award: $viewModel.oneOffAwards[index], canClaim: true, action: {
                            viewModel.completeAward(viewModel.oneOffAwards[index])
                        })
                    }
                }
                Spacer(minLength: 90)
            }
        }
    }
}


extension DailyView {
    private var changeName: some View {
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
}

extension DailyView {
    private var inviteView: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.showingInvite.toggle()
                    }
                    
                }
            
            VStack {
                Spacer()
                InviteView(isShowing: $viewModel.showingInvite, action: viewModel.showingClaimBonus)
                Spacer()
            }
        }
    }
}

extension DailyView {
    private var rating: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.showingRate.toggle()
                    }
                    
                }
            
            VStack {
                Spacer()
                RatingPopUpView(isShowing: $viewModel.showingRate, action: viewModel.showingClaimBonus)
                Spacer()
            }
        }
    }
}

extension DailyView {
    private var socials: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.showingSocials.toggle()
                    }
                    
                }
            
            VStack {
                Spacer()
                SocialNetworksPopUpView(isShowing: $viewModel.showingSocials, action: viewModel.showingClaimBonus)
                Spacer()
            }
        }
    }
}

extension DailyView {
    private var claimView: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        if viewModel.showingAds {
                            viewModel.showingAds.toggle()
                            viewModel.showingClaiming.toggle()
                        } else {
                            viewModel.showingClaiming.toggle()
                        }
                        
                    }
                    
                }
            VStack {
                ClaimView(isShowing:  viewModel.showingAds ? $viewModel.showingAds : $viewModel.showingClaiming, amount: viewModel.activeAward!.reward, action: viewModel.showingClaimBonus)
            }
        }
    }
}

extension DailyView {
    private var popUpDayli: some View {
        ZStack {
            VisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterialDark))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        viewModel.showingDailyAwardsPopup.toggle()
                    }
                    
                }
            VStack {
                DailyPopUpView(isShowing: $viewModel.showingDailyAwardsPopup, model: viewModel.dailyAwards[1], action: viewModel.showingClaimBonus)
            }
        }
    }
}
