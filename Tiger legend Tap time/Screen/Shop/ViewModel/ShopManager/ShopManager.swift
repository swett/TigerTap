//
//  ShopManager.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 30.06.2024.
//

import Foundation
import StoreKit

@available(iOS 15.0, *)
class ShopManager: ObservableObject {
    static let shared = ShopManager()
    
    @Published var products: [Product] = []
    @Published var coinProducts: [CoinProduct] = [
        CoinProduct(id: "com.yourapp.coins500000", price: 69.90, discount: nil, amount: 500000),
        CoinProduct(id: "com.yourapp.coins50000", price: 29.90, discount: nil, amount: 50000),
        CoinProduct(id: "com.yourapp.coins10000", price: 24.90, discount: nil, amount: 10000),
        CoinProduct(id: "com.yourapp.coins7000", price: 19.90, discount: nil, amount: 7000),
        CoinProduct(id: "com.yourapp.coins5000", price: 14.90, discount: nil, amount: 5000),
        CoinProduct(id: "com.yourapp.coins1000", price: 9.90, discount: nil, amount: 1000),
        CoinProduct(id: "com.yourapp.coins500", price: 4.90, discount: nil, amount: 500)
    ]
    
    private init() {
        Task {
            await fetchProducts()
            await checkForPendingTransactions()
        }
    }
    
//     Fetch products from the App Store
       func fetchProducts() async {
           do {
               let storeProducts = try await Product.products(for: coinProducts.map { $0.id })
               DispatchQueue.main.async {
                   self.products = storeProducts
                   for product in storeProducts {
                       if let index = self.coinProducts.firstIndex(where: { $0.id == product.id }) {
                           self.coinProducts[index].price = NSDecimalNumber(decimal: product.price).doubleValue
                       }
                   }
               }
           } catch {
               print("Failed to fetch products: \(error)")
           }
       }
    
       
       // Purchase a product
    func purchase(productID: String) async -> Bool {
        if let product = products.first(where: { $0.id == productID }) {
            do {
                let result = try await product.purchase()
                switch result {
                case .success(let verification):
                    switch verification {
                    case .verified(let transaction):
                        await handlePurchase(transaction: transaction)
                        await transaction.finish()
                        return true
                    case .unverified(let transaction, let error):
                        print("Unverified transaction: \(error.localizedDescription)")
                        await transaction.finish()
                        return false
                    }
                case .pending:
                    print("Transaction pending")
                    return false
                case .userCancelled:
                    print("Transaction cancelled by user")
                    return false
                @unknown default:
                    print("Unknown transaction result")
                    return false
                }
            } catch {
                print("Purchase failed: \(error)")
                return false
            }
        } else {
            print("Product not found: \(productID)")
            return false
        }
    }
       // Handle successful purchase
       private func handlePurchase(transaction: Transaction) async {
           print("Purchase successful for product: \(transaction.productID)")
           if let coinProduct = coinProducts.first(where: { $0.id == transaction.productID }) {
               // Add the coins to the user's account
               print("Adding \(coinProduct.amount) coins to user's account")
           }
       }
       
       // Check for pending transactions (e.g., offline purchases)
       private func checkForPendingTransactions() async {
           for await result in Transaction.updates {
               switch result {
               case .verified(let transaction):
                   await handlePurchase(transaction: transaction)
                   await transaction.finish()
               case .unverified(let transaction, _):
                   await transaction.finish()
               }
           }
       }
}
