//
//  CountryPackages.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

struct CountryPackages: Codable {
    let id: Int
    let slug: String
    let title: String
    let image: ImageResource
    let packages: [Package]
}

struct Package: Codable {
    let id: Int
    let data: String
    let validity: String
    let price: Double
    let operatorInfo: Operator
    
    enum CodingKeys: String, CodingKey {
        case id, data, validity, price
        case operatorInfo = "operator"
    }
}

struct Operator: Codable {
    let id: Int
    let title: String
    let style: String
    let gradientStart: String
    let gradientEnd: String
    let image: ImageResource
    
    enum CodingKeys: String, CodingKey {
        case id, title, style, image
        case gradientStart = "gradient_start"
        case gradientEnd = "gradient_end"
    }
}
