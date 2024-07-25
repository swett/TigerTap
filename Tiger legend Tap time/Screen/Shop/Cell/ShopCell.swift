//
//  ShopCell.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import SwiftUI

struct ShopCell: View {
    var model: CoinProduct
    var buyHandler: (CoinProduct) -> Void
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                       Image("coin")
                            .resizable()
                            .frame(width: 18, height: 18)
                        Text("+\(model.amount)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundStyle(Color.theme.mainTextColor)
                    }
                    Text("$\(model.price, specifier: "%.2f")")
                        .font(.system(size: 16, weight: .regular))
                        .foregroundStyle(Color.theme.mainTextColor.opacity(0.7))
                }
                Spacer()
                Button {
                    buyHandler(model)
                } label: {
                    Image("next")
                }
            }
            .padding(.horizontal, 16)
        }
        .frame(width: 349, height: 70)
        .background(Color.theme.mainTextColor.opacity(0.1))
        .cornerRadius(10)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.white.opacity(0.17), lineWidth: 1)
        )
    }
}

#Preview {
    ShopCell(model: CoinProduct(id: "", price: 9.99, discount: nil, amount: 100), buyHandler: {_ in })
}
