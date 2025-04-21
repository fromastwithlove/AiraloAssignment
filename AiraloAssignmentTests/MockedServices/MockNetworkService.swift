//
//  MockedNetworkService.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import Foundation
@testable import AiraloAssignment

struct MockNetworkService: NetworkServiceProtocol {
    
    let countries: [Country] = [
        Country(id: 1, slug: "turkey", title: "Turkey", image: ImageResource(width: 100, height: 100, url: "api/v2/image/flag-turkey.png")),
        Country(id: 2, slug: "germany", title: "Germany", image: ImageResource(width: 100, height: 100, url: "api/v2/image/flag-germany.png"))
    ]
    
    let packages: CountryPackages = CountryPackages(
        id: 0,
        slug: "turkey",
        title: "Turkey",
        image: ImageResource(width: 0, height: 0, url: "api/v2/image/flag-turkey.png"),
        packages: [
            Package(id: 1,
                    data: "Unlimited",
                    validity: "10 Days",
                    price: 35,
                    operatorInfo: Operator(id: 1,
                                           title: "Merhaba",
                                           style: "light",
                                           gradientStart: "",
                                           gradientEnd: "",
                                           image: ImageResource(width: 0, height: 0, url: "")
                                          )
                   )
        ]
    )
    
    var flagData: Data = Data()
    var shouldThrow: Bool = false

    func fetchPopularCountries() async throws -> [Country] {
        if shouldThrow { throw MockError.failed }
        return countries
    }

    func fetchCountryPackages(forCountryId id: Int) async throws -> CountryPackages {
        if shouldThrow { throw MockError.failed }
        return packages
    }

    func fetchCountryFlag(from urlString: String) async throws -> Data {
        if shouldThrow { throw MockError.failed }
        return flagData
    }

    enum MockError: Error {
        case failed
    }
}
