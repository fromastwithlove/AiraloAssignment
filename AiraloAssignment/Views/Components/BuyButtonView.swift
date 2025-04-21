//
//  BuyButtonView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import SwiftUI

struct BuyButtonView: View {
    let price: Double
    
    var body: some View {
        Button {
            /// Buy tapped
        } label: {
            Text("US$\(String(format: "%.2f", price)) - Buy Now")
                .font(.ibmPlexSans(.semiBold, size: 11))
                .frame(height: 11)
                .kerning(1)
                .textCase(.uppercase)
        }
        .frame(height: 44)
        .frame(maxWidth: .infinity)
        .overlay {
            RoundedRectangle(cornerRadius: 7)
                .stroke()
        }
    }
}

#Preview {
    BuyButtonView(price: 4.5)
}
