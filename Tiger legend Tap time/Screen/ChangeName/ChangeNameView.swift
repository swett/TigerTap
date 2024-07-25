//
//  ChangeNameView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 02.07.2024.
//

import SwiftUI

struct ChangeNameView: View {
    @State private var name: String = ""
    @State private var isAvaliableToChange: Bool = false
    @EnvironmentObject var viewModel: SettingsViewModel
    @Binding var isShowing: Bool
    var body: some View {
        VStack {
            Text("Name your tiger")
                .foregroundStyle(Color.theme.mainTextColor)
                .font(.system(size: 32, weight: .bold))
            
            RoundedRectangle(cornerRadius: 10)
                .strokeBorder(Color.theme.mainTextColor.opacity(0.5),lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 20).foregroundColor(Color.theme.mainTextColor.opacity(0.1)))
                .frame(width: 349, height: 51)
                .overlay {
                    TextField("Create a name for your tiger", text: $name)
                        .foregroundColor(.theme.mainTextColor)
                        .font(.system(size: 16, weight: .medium))
                        .padding(.horizontal, 30)
                        .padding(.vertical, 11)
                        .onChange(of: name) { newValue in
                            if newValue.count >= 3 {
                                isAvaliableToChange = true
                            } else {
                                isAvaliableToChange = false
                            }
                        }
                }
            
            Button {
                viewModel.updateName(name: name)
                isShowing.toggle()
            } label: {
                Text("Save")
                    .foregroundStyle(Color.theme.mainTextColor)
                    .font(.system(size: 16, weight: .bold))
                    .frame(width: 351, height: 43)
                    .background(Color.theme.orangeColor)
                    .cornerRadius(10)
            }
            .opacity(isAvaliableToChange ? 1 : 0.45)
            .disabled(!isAvaliableToChange)
            
        }
    }
}

#Preview {
    ChangeNameView(isShowing: .constant(false))
        .environmentObject(SettingsViewModel())
}
