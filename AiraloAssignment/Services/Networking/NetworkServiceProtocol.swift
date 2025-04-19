//
//  NetworkServiceProtocol.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

/// A protocol that defines a set of methods for fetching data from the Airalo API.
///
/// This is intended to provide a lightweight abstraction over networking logic,
/// making it easier to manage dependencies, test logic in isolation, and evolve the networking layer over time.
///
/// Conforming types are expected to:
/// - Perform API requests related to countries and packages.
/// - Return decoded model objects on success.
/// - Propagate networking or decoding errors when needed.
protocol NetworkServiceProtocol {
    /// Fetches a list of popular countries, typically shown in the Store screen.
    ///
    /// - Returns: An array of `Country` objects representing popular travel destinations.
    /// - Throws: An error if the request or decoding fails.
    func fetchPopularCountries() async throws -> [Country]

    /// Fetches the available packages for a given country ID.
    ///
    /// - Parameter id: The identifier of the country.
    /// - Returns: A `CountryPackages` object containing available packages.
    /// - Throws: An error if the request or decoding fails.
    func fetchCountryPackages(forCountryId id: Int) async throws -> CountryPackages
}
