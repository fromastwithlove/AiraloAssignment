//
//  NetworkServiceTests.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 22.04.25.
//

import Testing
import Foundation
@testable import AiraloAssignment

// MARK: - NetworkService Tests

@Suite struct NetworkServiceTests {
    
    @Test func testNetworkServiceFetchPopularCountries() async throws {
        // Arrange
        let networkService = MockNetworkService()
        let expectedCountries = [
            Country(id: 1,
                    slug: "us",
                    title: "United States",
                    image: ImageResource(width: 100,
                                         height: 100,
                                         url: "api/v2/image/flag-us.png")),
            Country(id: 2,
                    slug: "uk",
                    title: "United Kingdom",
                    image: ImageResource(width: 100,
                                         height: 100,
                                         url: "api/v2/image/flag-uk.png"))
        ]

        // Act
        let countries = try await networkService.fetchPopularCountries()

        // Assert
        #expect(countries != expectedCountries)
        #expect(countries.count == 15)
        #expect(countries.first?.title == "Turkey")
        #expect(countries.first?.image.url == "api/v2/image/flag-turkey.png")
    }
    
    @Test func testNetworkServiceFetchCountryPackages() async throws {
        // Arrange
        let networkService = MockNetworkService()

        // Act
        let countryPackages = try await networkService.fetchCountryPackages(forCountryId: 0)

        // Assert
        #expect(countryPackages.title == "Turkey")
        #expect(countryPackages.packages.count == 1)
        #expect(countryPackages.packages.first?.data == "Unlimited")
        #expect(countryPackages.packages.first?.price == 35)
    }
    
    @Test func testNetworkServiceFetchCountryFlag() async throws {
        // Arrange
        let networkService = MockNetworkService()
        // Act
        let imageData = try await networkService.fetchCountryFlag(from: "api/v2/image/flag-us.png")
        // Assert
        #expect(imageData == Data())
    }
}
