//
//  PopularCountriesViewModel.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

import Foundation

@MainActor
@Observable
class PopularCountriesViewModel: ObservableObject {
    
    // MARK: - Private Properties
    
    private let logger = AppLogger(category: "UI.PopularCountriesViewModel")
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    // MARK: - Public properties
    
    enum LoadingState {
        case idle
        case loading
        case success([Country])
        case error(Error)
    }
    
    // MARK: - Published Properties
    
    private(set) var loadingState: LoadingState = .idle
    
    // MARK: - Public Methods
    
    func fetchPopularCountries() async {
        loadingState = .loading
        
        do {
            let countries: [Country] = try await networkService.fetchPopularCountries()
            loadingState = .success(countries)
        } catch {
            logger.error("Error fetching countries", metadata: error.localizedDescription)
            loadingState = .error(error)
        }
    }
}
