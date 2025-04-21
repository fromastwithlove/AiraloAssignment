//
//  AppManager.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

import Foundation

@Observable
@MainActor
class AppManager: ObservableObject {

    // MARK: - Public Properties

    private(set) var services: Services

    init(services: Services) {
        self.services = services
    }
}
