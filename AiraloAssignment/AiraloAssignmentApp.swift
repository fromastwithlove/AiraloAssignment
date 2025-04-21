//
//  AiraloAssignmentApp.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

import SwiftUI

@main
struct AiraloAssignmentApp: App {

    @StateObject private var appManager: AppManager = .init(services: Services())

    var body: some Scene {
        WindowGroup {
            let model = PopularCountriesViewModel(networkService: appManager.services.networkService)
            PopularCountriesView(model: model)
                .environmentObject(appManager)
        }
    }
}
