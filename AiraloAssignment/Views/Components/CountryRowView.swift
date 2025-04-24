//
//  CountryRowView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

struct CountryRowView: View {
    let country: Country
    let model: AsyncImageViewModel
    
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            /// Fetch and display the country flag
            AsyncImageView(model: model) { image in
                image
                    .resizable()
                    .frame(width: 37, height: 28)
            }

            /// Country name
            Text(country.title)
                .font(.ibmPlexSans(.medium, size: 15))
                .frame(height: 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color.accentColor)

            /// Chevron arrow
            Image("ic_arrow_general")
                .resizable()
                .frame(width: 22,
                       height: 22)
        }
        /// NOTE:
        /// The Figma design specifies a fixed 20px horizontal padding for the entire view.
        /// To match this, the country rows are given dynamic widths based on the available space.
        /// An alternative approach would be to fix the row width (335 px) and adjust padding dynamically instead,
        /// but here we preserve the 20px horizontal padding to stay consistent.
        .frame(height: 55)
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(7)
        .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
        .task {
            await model.loadImage()
        }
    }
}

#Preview {
    let imageResource = ImageResource(width: 132,
                                      height: 99,
                                      url: "https://cdn.airalo.com/images/8efbff32-b788-4098-a957-7fc4b9febb50.png")
    let country = Country(id: 227,
                          slug: "turkey",
                          title: "Turkey",
                          image: imageResource)
    let model = AsyncImageViewModel(imageURLString: imageResource.url,
                                    networkService: NetworkService())
    CountryRowView(country:  country,
                   model: model)
}
