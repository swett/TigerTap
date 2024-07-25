//
//  SettingsView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    var body: some View {
        VStack {
            StaticCellView(option: "Privacy Policy", onTap: viewModel.showPolicy)
                .sheet(isPresented: $viewModel.showPrivacy) {
                    NavigationStack {
                        // 3
                        WebView(url: URL(string: "https://www.google.com")!)
                        
                            .ignoresSafeArea()
                            .navigationTitle("")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            Divider()
                .background(Color.white.opacity(0.17))
                .frame(width: 327,height: 0.33)
                .padding(.leading, 30)
            StaticCellView(option: "Support Request", onTap: viewModel.callSupport)
                .sheet(isPresented: $viewModel.showSupport) {
                    NavigationStack {
                        // 3
                        WebView(url: URL(string: "https://www.google.com")!)
                        
                            .ignoresSafeArea()
                            .navigationTitle("")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            Divider()
                .background(Color.white.opacity(0.17))
                .frame(width: 327,height: 0.33)
                .padding(.leading, 30)
            StaticCellView(option: "Instructions", onTap: viewModel.showInstrcution)
                .sheet(isPresented: $viewModel.showInstructions) {
                    NavigationStack {
                        // 3
                        WebView(url: URL(string: "https://www.google.com")!)
                        
                            .ignoresSafeArea()
                            .navigationTitle("")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
        }
        .frame(width: 361, height: 150)
        .background(Color.white.opacity(0.1))
        .cornerRadius(10)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.17), lineWidth: 1)
        )
       
        
    }
}

#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
        
}
