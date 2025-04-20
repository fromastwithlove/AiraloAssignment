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
    case invalidURL(String)
    case invalidResponse
    case clientError(statusCode: Int)
    case serverError(statusCode: Int)
    case unknownError(statusCode: Int)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL(let urlString):
            return "The provided string URL was invalid: \(urlString)."
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

actor NetworkService: NetworkServiceProtocol {
    
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
    
    // MARK: - Network Service Protocol Methods

    /// Fetches a list of popular countries from the API.
    func fetchPopularCountries() async throws -> [Country] {
        return try await performRequest(endpoint: Endpoint.countries.path, method: .get, params: ["type": "popular"])
    }
    
    /// Fetches country-specific packages based on a given country ID.
    func fetchCountryPackages(forCountryId id: Int) async throws -> CountryPackages {
        return try await performRequest(endpoint: Endpoint.countryPackages(id: id).path, method: .get)
    }
    
    /// Downloads the raw image data for a country flag from a given URL string.
    func fetchCountryFlag(from urlString: String) async throws -> Data {
        return try await performImageRequest(from: urlString)
    }
    
    // MARK: - Private Methods
    
    /// Sends an HTTP request to the specified endpoint and decodes the response.
    ///
    /// - Parameters:
    ///   - endpoint: The API endpoint path relative to the base URL (e.g., "countries").
    ///   - method: The HTTP method to use (e.g., `.get`, `.head`, etc.).
    ///   - params: Optional dictionary of query parameters to append to the URL.
    ///   - timeout: Optional timeout interval for the request.
    /// - Returns: A decoded object of type `D`.
    /// - Throws: An error if the request fails, the response is invalid, or decoding fails.
    private func performRequest<D: Decodable>(endpoint: String,
                                              method: HTTPMethod,
                                              params: [String: String]? = nil,
                                              timeout: TimeInterval? = nil) async throws -> D {
        let url = buildURL(endpoint: endpoint, params: params)
        let request = requestBuilder.makeRequest(method: method, url: url, timeout: timeout)
        
        let startTime = Date()
        let response: NetworkResponse = try await session.data(for: request)
        let duration = Date().timeIntervalSince(startTime)
        
        try responseHandler.validate(response: response, for: request, with: duration)
        return try responseHandler.decode(response: response)
    }
    
    /// Builds a URL with query parameters.
    /// - Parameters:
    ///   - endpoint: The API endpoint path relative to the base URL .
    ///   - params: The query parameters to be added to the URL.
    /// - Returns: The full URL with query parameters.
    private func buildURL(endpoint: String, params: [String: String]?) -> URL {
        let url = apiBaseURL.appending(path: endpoint)
        
        guard let params = params else { return url }
            
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        return components?.url ?? url
    }
    
    /// Performs a network request to retrieve raw image data from a given URL string.
    ///
    /// This method attempts to construct a valid `URL` from the provided string, sends a data task request,
    /// measures the request duration, validates the HTTP response, and returns the image as raw `Data`.
    ///
    /// - Parameter urlString: A string representing the complete image URL.
    /// - Returns: The raw image data.
    /// - Throws: A `NetworkError` if the URL is invalid or the response is invalid.
    private func performImageRequest(from urlString: String) async throws -> Data {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL(urlString)
        }
        
        let startTime = Date()
        let response: NetworkResponse = try await session.data(from: url)
        let duration = Date().timeIntervalSince(startTime)
        
        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        #if DEBUG
        logger.info("Image: \(url.lastPathComponent) - \(httpResponse.statusCode) - \(String(format: "%.2f", duration))s")
        #endif
        
        switch httpResponse.statusCode {
        case 200..<300:
            return response.data
        case 400..<500:
            throw NetworkError.clientError(statusCode: httpResponse.statusCode)
        case 500..<600:
            throw NetworkError.serverError(statusCode: httpResponse.statusCode)
        default:
            throw NetworkError.unknownError(statusCode: httpResponse.statusCode)
        }
    }
}
