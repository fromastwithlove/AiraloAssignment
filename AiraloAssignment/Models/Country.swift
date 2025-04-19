//
//  Country.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

struct Country: Codable, Identifiable {
    let id: Int
    let slug: String
    let title: String
    let image: ImageResource
}
