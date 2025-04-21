//
//  AppManager.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

import Foundation

/// `AppManager` is an `ObservableObject` that holds a reference to the app's core `Services`.
/// It is injected as an `@EnvironmentObject` into all views, providing global access to essential services.
///
/// - Properties:
///   - `services`: The core service dependencies (e.g., network, database).
///
/// `AppManager` is initialised in the `@main` entry point of the app and ensures that the services are available throughout the app without needing to pass them manually between views.
@Observable
@MainActor
class AppManager: ObservableObject {

    // MARK: - Public Properties

    private(set) var services: Services

    init(services: Services) {
        self.services = services
    }
}
