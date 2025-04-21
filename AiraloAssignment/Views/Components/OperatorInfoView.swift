//
//  OperatorInfoView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import SwiftUI

struct OperatorInfoView: View {
    let operatorInfo: Operator
    let countryTitle: String
    let colorMatchingStyle: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(operatorInfo.title)
                .font(.ibmPlexSans(.semiBold, size: 19))
                .frame(height: 22)
                .kerning(-0.2)
            Text(countryTitle)
                .font(.ibmPlexSans(.medium, size: 13))
                .frame(height: 15)
        }
    }
}

#Preview {
    let imageResource1 = ImageResource(width: 1035,
                                       height: 653,
                                       url: "https://cdn.airalo.com/images/f66c118f-35ec-40d1-a784-ee9b90adf8c2.png")
    let operatorInfo1 = Operator(id: 1012,
                                 title: "Merhaba",
                                 style: "light",
                                 gradientStart: "#B91F35",
                                 gradientEnd: "#AD1E35",
                                 image: imageResource1)
    OperatorInfoView(operatorInfo: operatorInfo1,
                     countryTitle: "Turkey",
                     colorMatchingStyle: Color.accentColor)
}
