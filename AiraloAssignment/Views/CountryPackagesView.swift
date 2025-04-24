//
//  CountryPackagesView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import SwiftUI

struct CountryPackagesView: View {
    
    @StateObject var model: CountryPackagesViewModel
    
    var body: some View {
        ScrollView {
            switch model.loadingState {
            case .idle:
                EmptyView()
            case .loading:
                ProgressView()
            case .success(let countryPackages):
                PackagesList(countryPackages: countryPackages)
            case .error(let error):
                Text(verbatim: error.localizedDescription)
                    .font(.ibmPlexSans(.regular, size: 14))
            }
        }
        .setupNavigationBar()
        .navigationTitle(model.country.title)
        .task {
            await model.fetchCountryPackages()
        }
    }
}

struct PackagesList: View {
    
    @EnvironmentObject private var appManager: AppManager
    
    let countryPackages: CountryPackages
    
    var body: some View {
        /// Packages
        LazyVStack(spacing: 20) {
            ForEach(countryPackages.packages) { package in
                let imageViewModel = AsyncImageViewModel(imageURLString: package.operatorInfo.image.url,
                                                         networkService: appManager.services.networkService)
                PackageCardView(model: imageViewModel,
                                countryTitle: countryPackages.title,
                                package: package)
            }
        }
        .shadow(color: Color.black.opacity(0.15), radius: 30, x: 0, y: 10)
        .padding(20)
        .background(Color.background)
    }
}

#Preview {
    let appManager = AppManager(services: Services())
    let imageResource = ImageResource(width: 132,
                                      height: 99,
                                      url: "https://cdn.airalo.com/images/8efbff32-b788-4098-a957-7fc4b9febb50.png")
    let country = Country(id: 227,
                          slug: "turkey",
                          title: "Turkey",
                          image: imageResource)
    let model = CountryPackagesViewModel(country: country, networkService: appManager.services.networkService)
    NavigationStack {
        CountryPackagesView(model: model)
            .environmentObject(appManager)
    }
}
