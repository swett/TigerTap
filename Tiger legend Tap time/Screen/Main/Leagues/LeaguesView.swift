//
//  LeaguesView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 06.07.2024.
//

import SwiftUI

struct LeaguesView: View {
    @EnvironmentObject var viewModel: MainViewModel
    @State var position: Int = 0
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                Button {
                    if position > viewModel.leagueMilestones.startIndex  {
                        position -= 1
                    } else {
                        position = viewModel.leagueMilestones.endIndex - 1
                    }
                } label: {
                    Image("chevron-left")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                TabView(selection: $position) {
                    ForEach(Array(viewModel.leagueMilestones.enumerated()), id: \.element) {
                        item, index in
                        VStack {
                            Image("\(viewModel.getImageByLeagueName(name: viewModel.leagueMilestones[item].name))")
                                .shadow(color:Color(hex: "#000000").opacity(0.14),radius: 20, x: -8, y: -8)
                                .shadow(color:Color(hex: "#000000").opacity(0.3),radius: 20, x: 8, y: 8)
                            Text("\(index.name)")
                                .foregroundStyle(Color.theme.mainTextColor)
                                .font(.system(size: 32, weight: .bold))
                            if viewModel.leaguePosition != item + 1 {
                                Text("From \(index.taps)")
                            } else {
                                Text("\(viewModel.settingViewModel!.updatePlayer.coins) / \(index.taps)")
                                    .foregroundStyle(Color.theme.mainTextColor.opacity(0.5))
                                    .font(.system(size: 16, weight: .semibold))
                                    .padding(.top, -5)
                                ProgressView(value: viewModel.progress, total: 1)
                                    .progressViewStyle(RoundedRectProgressViewStyle())
                            }
                            
                            
                            
                        }
                        .tag(item)
                        
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .background(.clear)
                Button {
                    if position < viewModel.leagueMilestones.endIndex - 1 {
                        position += 1
                    } else {
                        position =  viewModel.leagueMilestones.startIndex
                    }
                    
                } label: {
                    Image("buttonRight")
                        .resizable()
                        .frame(width: 24, height: 24)
                }
                
            }
            
        }
        .background(.clear)
    }
}

#Preview {
    LeaguesView()
        .environmentObject(MainViewModel())
}


struct RoundedRectProgressViewStyle: ProgressViewStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 16)
                .frame(width: 349, height: 18)
                .foregroundColor(Color.white.opacity(0.1))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.17), lineWidth: 1))
            
            RoundedRectangle(cornerRadius: 16)
                .frame(width: CGFloat(configuration.fractionCompleted ?? 0) * 345, height: 18)
                .foregroundStyle(LinearGradient(colors: [Color(hex: "#992703"), Color(hex: "#FF4004")], startPoint: .top, endPoint: .bottom))
        }
        .padding()
    }
}
