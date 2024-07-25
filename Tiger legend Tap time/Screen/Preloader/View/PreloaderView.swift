//
//  PreloaderView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 26.06.2024.
//

import SwiftUI

struct PreloaderView: View {
    @ObservedObject var viewModel: PreloaderViewModel
    @State var isAnimated: Bool = false
    var body: some View {
        ZStack {
            Image("preloader")
                .resizable()
                .ignoresSafeArea(.all)
            Image("onBoardLogo")
                .scaleEffect(isAnimated ? 1.3 : 1)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                isAnimated = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                viewModel.showMain()
            }
        }
    }
}

#Preview {
    PreloaderView(viewModel: PreloaderViewModel())
}
