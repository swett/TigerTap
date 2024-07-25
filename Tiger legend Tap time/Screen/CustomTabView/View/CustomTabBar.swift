//
//  CustomTabBar.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: TabViewModel
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $viewModel.selectedTab) {
                FortuneView(viewModel: viewModel.fortuneViewModel!)
                    .tag(Tab.fortune)
                SlotView(viewModel: viewModel.slotsViewModel!)
                    .tag(Tab.slots)
                MainView(viewModel: viewModel.mainViewModel!)
                    .tag(Tab.main)
                DailyView(viewModel: viewModel.dailyViewModel!)
                    .tag(Tab.bonuses)
                ShopView(viewModel: viewModel.shopViewModel!)
                    .tag(Tab.shop)
            }
            .background(.clear)
            
            ZStack(alignment: .bottom){
                RoundedRectangle(cornerRadius: 16)
                    .foregroundStyle(LinearGradient(colors: [Color(hex: "#141925"), Color(hex:"#060910")], startPoint: .topLeading, endPoint: .bottom))
                    .frame(height: 108)
                    .offset(y: DeviceType.IS_SMALL ? 50 : 20)
                HStack{
                    ForEach(Tab.allCases){
                        item in
                        Button {
                            viewModel.previousTab =  viewModel.selectedTab
                            viewModel.selectedTab = item
                        } label: {
                            CustomTabItem(imageName: item.iconName, tag: item.rawValue, isActive: ( viewModel.selectedTab.rawValue == item.rawValue))
                        }
                        .offset(y: item.rawValue == 2 ? DeviceType.IS_SMALL ? -10 : -50 :  DeviceType.IS_SMALL ? 15 : 0)
                    }
                }
                .padding(.horizontal, 10)
            }
            .frame(height:DeviceType.IS_SMALL ? 126 : 146)
            .background(.clear)
            .cornerRadius(16)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            UITabBar.appearance().isHidden = true
            viewModel.updateModels()
        }
        .environment(\.colorScheme, .dark)
        
    }
    
}

#Preview {
    CustomTabBar(viewModel: TabViewModel())
}


extension CustomTabBar {
    func CustomTabItem(imageName: String, tag: Int, isActive: Bool) -> some View{
        HStack{
            Spacer()
            Image(getImageWhenActive(tag: tag, isActive: isActive))
                .resizable()
                .frame(width: tag == 2 ? 78 : 44, height: tag == 2 ? 78 : 44)
            Spacer()
        }
        .frame(width: tag == 2 ? 78 : 44, height:tag == 2 ? 78 : 44)
        .padding(.horizontal, 6)
    }
    
    
    func getImageWhenActive(tag: Int, isActive: Bool) -> String {
        
        switch tag {
        case 0: return "\(isActive ? "fortuneActive": "fortunePassive")"
        case 1: return "\(isActive ? "slotsActive": "slotsPassive")"
        case 2: return "\(isActive ? "homeActive": "homePassive")"
        case 3: return "\(isActive ? "bonusActive": "bonusPassive")"
        case 4: return "\(isActive ? "shopActive" : "shopPassive")"
        default: return ""
        }
    }
}
