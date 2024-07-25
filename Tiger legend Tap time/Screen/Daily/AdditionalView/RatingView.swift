//
//  RatingView.swift
//  Tiger legend Tap time
//
//  Created by Mykyta Kurochka on 06.07.2024.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    @Binding var isAvaliable: Bool
    @State var highestRate: Int = 5
    let unselected = Image("unfilledStar")
    let selected = Image("filledStar")
    var body: some View {
        HStack {
            ForEach(1...highestRate, id: \.self) {
                number in
                showStar(for: number)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            rating = number
                            isAvaliable = true
                        }
                        
                    }
            }
        }
    }
    
    
    func showStar(for number: Int) -> Image {
        if number > rating  {
            return unselected
        } else {
            return selected
        }
    }
}

#Preview {
    RatingView(rating: .constant(1), isAvaliable: .constant(false))
}
