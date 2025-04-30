//
//  MockedNetworkService.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import Foundation
@testable import AiraloAssignment

actor MockNetworkService: NetworkServiceProtocol {
    
    func fetchPopularCountries() async throws -> [Country] {
        return try loadJSON(named: "fixture-PopularCountries")
    }

    func fetchCountryPackages(forCountryId id: Int) async throws -> CountryPackages {
        return try loadJSON(named: "fixture-CountryPackages")
    }

    func fetchCountryFlag(from urlString: String) async throws -> Data {
        return Data()
    }

    enum MockError: Error {
        case failed
    }
    
    // MARK: - JSON Loader Helper

    private func loadJSON<T: Decodable>(named name: String) throws -> T {
        guard let url = Bundle(for: MockNetworkService.self).url(forResource: name, withExtension: "json") else {
            throw MockError.failed
        }

        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}
