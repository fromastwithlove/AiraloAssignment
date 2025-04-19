//
//  NetworkService.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 18.04.25.
//

import Foundation

/// Typealias for network response consisting of data and URLResponse.
typealias NetworkResponse = (data: Data, urlResponse: URLResponse)

// MARK: - HTTP Methods

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case put = "PUT"
}

// MARK: - HTTP Headers

enum HTTPHeader {
    static let accept = "Accept"
    static let acceptLanguage = "Accept-Language"
}

// MARK: - HTTP Content Types

enum HTTPContentType {
    static let json = "application/json"
}

// MARK: - Network Errors

enum NetworkError: LocalizedError {
    case invalidResponse
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknownError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The response from the server was invalid."
        case .clientError(let statusCode):
            return "Client error occurred. Status code: \(statusCode)."
        case .serverError(let statusCode):
            return "Server error occurred. Status code: \(statusCode)."
        case .unknownError(let statusCode):
            return "An unknown error occurred. Status code: \(statusCode)."
        }
    }
}

// MARK: - Endpoints

enum Endpoint {
    case countries
    case countryPackages(id: Int)
    
    var path: String {
        switch self {
        case .countries:
            return "/countries"
        case .countryPackages(let id):
            return "/countries/\(id)"
        }
    }
}

// MARK: - Network Service

actor NetworkService {
    
    // MARK: - Private Properties
    
    private let logger = AppLogger(category: "Network")
    
    private var session: URLSession {
        // Use an ephemeral session to avoid storing any data on disk.
        // This ensures no cookies, caches, or credentials persist between launches,
        // making it suitable for stateless API interactions and improved privacy.
        let config: URLSessionConfiguration = .ephemeral
        
        // Explicitly disable all cookie handling for extra safety and statelessness.
        config.httpCookieAcceptPolicy = .never
        config.httpCookieStorage = nil
        config.httpShouldSetCookies = false
        
        return URLSession(configuration: config)
    }
    
    private let URLScheme = "https"
    private let hostname = "airalo.com"
    
    private var baseURL: URL {
        var components = URLComponents()
        components.scheme = URLScheme
        components.host = hostname
        
        guard let url = components.url else {
            logger.error("Invalid base URL created with scheme: \(URLScheme), host: \(hostname)")
            return URL(string: "https://airalo.com")!
        }
        
        return url
    }
    
    private var apiBaseURL: URL {
        return baseURL.appending(path: "api/v2")
    }
    
    private let requestBuilder: RequestBuilder = .init()
    private let responseHandler: ResponseHandler = .init()
    
    // MARK: - Public Methods

    /// Sends an HTTP request to the specified endpoint and decodes the response.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint path relative to the base URL (e.g., "countries").
    ///   - method: The HTTP method to use (e.g., `.get`, `.head`, etc.).
    ///   - timeout: Optional timeout interval for the request.
    /// - Returns: A decoded object of type `D`.
    /// - Throws: An error if the request fails, the response is invalid, or decoding fails.
    func performRequest<D: Decodable>(endpoint: String,
                                                    method: HTTPMethod,
                                                    timeout: TimeInterval? = nil) async throws -> D {
        let url = apiBaseURL.appending(path: endpoint)
        let request = requestBuilder.makeRequest(method: method, url: url, timeout: timeout)
        
        let startTime = Date()
        let response: NetworkResponse = try await session.data(for: request)
        let duration = Date().timeIntervalSince(startTime)
        
        try responseHandler.validate(response: response, for: request, with: duration)
        return try responseHandler.decode(response: response)
    }
}
