//
//  NetworkServiceProtocol.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 20.04.25.
//

import Foundation

/// A protocol that defines a set of methods for fetching data from the Airalo API.
///
/// This is intended to provide a lightweight abstraction over networking logic,
/// making it easier to manage dependencies, test logic in isolation, and evolve the networking layer over time.
///
/// Conforming types are expected to:
/// - Perform API requests related to countries, packages, and related media.
/// - Return decoded model objects or raw data on success.
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
    
    /// Downloads the raw image data for a country flag from a given URL string.
    ///
    /// This method is useful when you need to display flag images that are associated
    /// with a `Country` object. It performs a basic data task and returns the binary image data.
    ///
    /// - Parameter urlString: The string representation of the image URL.
    /// - Returns: A `Data` object containing the raw image bytes.
    /// - Throws: An error if the URL is invalid, the request fails, or the response is invalid.
    func fetchCountryFlag(from urlString: String) async throws -> Data
}
