//
//  PopularCountriesView.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

import SwiftUI

struct PopularCountriesView: View {
    
    @StateObject var model: PopularCountriesViewModel
    
    var body: some View {
        NavigationStack {
            switch model.loadingState {
            case .idle:
                EmptyView()
            case .loading:
                LaunchView()
            case .success(let countries):
                CountriesList(countries: countries)
            case .error(let error):
                Text(verbatim: error.localizedDescription)
                    .font(.ibmPlexSans(.regular, size: 14))
            }
        }
        .task {
            await model.fetchPopularCountries()
        }
    }
}

struct CountriesList: View {
    
    @EnvironmentObject private var appManager: AppManager
    
    let countries: [Country]
    
    var body: some View {
        ScrollView {
            /// NOTE: According to the Figma design, the vertical spacing between the first and second country rows is 12px,
            /// while the spacing between all subsequent items is 10px. This appears to be inconsistent—
            /// it's unclear if it's intentional or a design oversight.
            VStack(alignment: .leading, spacing: 12) {
                
                Text("Popular Countries")
                    .font(.ibmPlexSans(.semiBold, size: 19))
                    .foregroundColor(Color.accentColor)
                    .kerning(-0.2)
                    .frame(height: 22)
                    .padding(.top, 29)
                    .padding(.bottom, 12)
                
                LazyVStack(spacing: 10) {
                    ForEach(countries) { country in
                        NavigationLink(value: country) {
                            CountryRowView(country: country,
                                           model: AsyncImageViewModel(imageURLString: country.image.url,
                                                                      networkService: appManager.services.networkService))
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .background(Color.background)
        }
        .setupNavigationBar()
        .navigationTitle("Hello")
        .navigationDestination(for: Country.self) { country in
            let model = CountryPackagesViewModel(country: country,
                                                 networkService: appManager.services.networkService)
            CountryPackagesView(model: model)
        }
    }
}

#Preview {
    let appManager = AppManager(services: Services())
    let model = PopularCountriesViewModel(networkService: appManager.services.networkService)
    PopularCountriesView(model: model)
        .environmentObject(appManager)
}
