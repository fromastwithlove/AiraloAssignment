//
//  PackageCardView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

struct PackageCardView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.horizontalSizeClass) var sizeClass
    
    let model: AsyncImageViewModel
    let countryTitle: String
    let package: Package
    
    /// Dynamically returns a content colour matching the operator's style.
    var colorMatchingStyle: Color {
        let schemeString = colorScheme == .dark ? "dark" : "light"
        return schemeString == package.operatorInfo.style ? .white : Color.accentColor
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading, spacing: 0) {
                /// Package and country name
                OperatorInfoView(operatorInfo: package.operatorInfo,
                                 countryTitle: countryTitle,
                                 colorMatchingStyle: colorMatchingStyle)
                Spacer()
                Divider()
                    .background(colorMatchingStyle)
                    .padding(.horizontal, -20)
                
                /// Data amount
                PackageInfoRowView(iconName: "arrow.up.arrow.down",
                                   label: "Data",
                                   value: package.data,
                                   colorMatchingStyle: colorMatchingStyle)
                Divider()
                    .background(colorMatchingStyle)
                    .padding(.horizontal, -20)
                
                /// Validity duration
                PackageInfoRowView(iconName: "calendar.badge.clock",
                                   label: "Validity",
                                   value: package.validity,
                                   colorMatchingStyle: colorMatchingStyle)
                Divider()
                    .background(colorMatchingStyle)
                    .padding(.horizontal, -20)
                
                Spacer()
                /// Buy package button
                BuyButtonView(price: package.price)
            }
            .padding(20)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(hex: package.operatorInfo.gradientStart),
                        Color(hex: package.operatorInfo.gradientEnd)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .foregroundStyle(colorMatchingStyle)
            .cornerRadius(7)
            
            /// Operator Logo
            OperatorLogoView(model: model)
                .offset(x: -20, y: -20)
                .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
        }
        .padding(.top)
        /// NOTE:
        /// The Figma design specifies a fixed 20px horizontal padding for the entire view.
        /// To match this, the package cards are given dynamic widths based on the available space.
        /// An alternative approach would be to fix the card's width (335 px) and adjust padding dynamically instead,
        /// but here we preserve the 20px horizontal padding to stay consistent.
        .frame(height: 308)
        /// Limit width to 400pt on iPad, full width on iPhone
        /// Not required by Figma, but used to avoid overly wide layout on iPad.
        /// Can be removed if strict design alignment is needed — worth discussing with Design team.
        .frame(maxWidth: sizeClass == .regular ? 400 : .infinity)
        .task {
            await model.loadImage()
        }
    }
}

#Preview {
    
    /// Turkey
    
    let imageResource1 = ImageResource(width: 1035,
                                       height: 653,
                                       url: "https://cdn.airalo.com/images/f66c118f-35ec-40d1-a784-ee9b90adf8c2.png")
    let operatorInfo1 = Operator(id: 1012,
                                 title: "Merhaba",
                                 style: "light",
                                 gradientStart: "#B91F35",
                                 gradientEnd: "#AD1E35",
                                 image: imageResource1)
    let package1 = Package(id: 8356,
                           data: "Unlimited",
                           validity: "10 days",
                           price: 35,
                           operatorInfo: operatorInfo1)
    let model1 = AsyncImageViewModel(imageURLString: operatorInfo1.image.url,
                                     networkService: NetworkService())
    PackageCardView(model: model1, countryTitle: "Turkey", package: package1)
    
    /// United Arab Emirates
    
    let imageResource2 = ImageResource(width: 1035,
                                       height: 653,
                                       url: "https://cdn.airalo.com/images/4a974944-3716-44b8-bbdd-ab29737c5e93.png")
    let operatorInfo2 = Operator(id: 908,
                                 title: "Burj Mobile",
                                 style: "light",
                                 gradientStart: "#E26400",
                                 gradientEnd: "#8F4000",
                                 image: imageResource2)
    let package2 = Package(id: 7346,
                           data: "1 GB",
                           validity: "7 days",
                           price: 4.5,
                           operatorInfo: operatorInfo2)
    let model2 = AsyncImageViewModel(imageURLString: operatorInfo2.image.url,
                                    networkService: NetworkService())
    
    PackageCardView(model: model2, countryTitle: "United Arab Emirates", package: package2)
}
