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
        #expect(countries.count == 2)
        #expect(countries.first?.title == "Turkey")
        #expect(countries.first?.image.url == "api/v2/image/flag-turkey.png")
    }
    
    @Test func testNetworkServiceFetchCountryPackages() async throws {
        // Arrange
        let networkService = MockNetworkService()

        // Act
        let countryPackages = try await networkService.fetchCountryPackages(forCountryId: 1)

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
        let imageData = try await networkService.fetchCountryFlag(from: "https://example.com/flag.png")
        // Assert
        #expect(imageData == Data())
    }
    
    @Test func testNetworkServiceShouldThrowError() async throws {
        // Arrange
        var networkService = MockNetworkService()
        networkService.shouldThrow = true
        
        // Assert
        await #expect(throws: Error.self, "Should throw an error", performing: {
            let _: [Country] = try await networkService.fetchPopularCountries()
        })
    }
}
