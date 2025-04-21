//
//  OperatorLogoView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import SwiftUI

struct OperatorLogoView: View {
    let model: AsyncImageViewModel
    
    var body: some View {
        AsyncImageView(model: model) { image in
            image
                .resizable()
                .frame(width: 140, height: 88)
        }
    }
}
