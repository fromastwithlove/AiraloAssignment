//
//  CountryPackagesViewModel.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import Foundation

@MainActor
@Observable
class CountryPackagesViewModel: ObservableObject {
    
    // MARK: - Private Properties
    
    private let logger = AppLogger(category: "UI.CountryPackagesViewModel")

    private let networkService: NetworkServiceProtocol
    
    init(country: Country, networkService: NetworkServiceProtocol) {
        self.country = country
        self.networkService = networkService
    }
    
    // MARK: - Public properties
    
    enum LoadingState {
        case idle
        case loading
        case success(CountryPackages)
        case error(Error)
    }

    let country: Country
    
    // MARK: - Published Properties
    
    private(set) var loadingState: LoadingState = .idle
    
    // MARK: - Public Methods
    
    func fetchCountryPackages() async {
        loadingState = .loading
        
        do {
            let countryPackages: CountryPackages = try await networkService.fetchCountryPackages(forCountryId: country.id)
            loadingState = .success(countryPackages)
        } catch {
            logger.error("Error fetching country packages", metadata: error.localizedDescription)
            loadingState = .error(error)
        }
    }
}
