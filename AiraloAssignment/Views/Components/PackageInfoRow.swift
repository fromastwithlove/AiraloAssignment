//
//  PackageInfoRow.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import SwiftUI

struct PackageInfoRowView: View {
    let iconName: String
    let label: String
    let value: String
    let colorMatchingStyle: Color
    
    var body: some View {
        HStack(spacing: 10) {
            Image(iconName)
                .renderingMode(.template)
                .resizable()
                .frame(width: 22, height: 22)
                .foregroundStyle(colorMatchingStyle)
            Text(label)
                .font(.ibmPlexSans(.semiBold, size: 11))
                .foregroundStyle(colorMatchingStyle)
                .frame(height: 14)
                .kerning(1)
                .textCase(.uppercase)
                
            Spacer()
            Text(value)
                .font(.ibmPlexSans(.medium, size: 17))
                .foregroundStyle(colorMatchingStyle)
                .frame(height: 20)
                .kerning(-0.1)
        }
        .frame(height: 58)
    }
}

#Preview {
    PackageInfoRowView(iconName: "ic_data",
                       label: "Data",
                       value: "1 GB",
                       colorMatchingStyle: Color.accentColor)
    
    PackageInfoRowView(iconName: "ic_validity",
                       label: "Validity",
                       value: "7 Days",
                       colorMatchingStyle: Color.accentColor)
}
