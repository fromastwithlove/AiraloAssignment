//
//  Services.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

/// A container class that holds references to various service instances, such as `NetworkService`.
/// This class is designed to be easily extended to include other services (e.g., `DatabaseService`, `NotificationService`)
/// as the app grows, ensuring centralised management of all service instances.
class Services {
    let networkService: NetworkService = NetworkService()
}
