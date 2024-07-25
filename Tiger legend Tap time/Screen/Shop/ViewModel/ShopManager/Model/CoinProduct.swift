//
//  CoinProduct.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
struct CoinProduct: Hashable {
    let id: String
    var price: Double // Price in your local currency
    let discount: Double? // Optional discount percentage, e.g., 0.20 for 20% off
    let amount: Int // Amount of coins
    
    // Calculate the final price after applying the discount
    var discountedPrice: Double {
        if let discount = discount {
            return price * (1.0 - discount)
        } else {
            return price
        }
    }
}
