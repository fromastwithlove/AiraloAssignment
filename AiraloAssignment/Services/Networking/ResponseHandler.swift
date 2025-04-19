//
//  ResponseHandler.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

import Foundation

/// A helper class responsible for validating network responses and decoding response data.
/// Throws appropriate errors based on HTTP status codes or decoding failures.
class ResponseHandler {
    
    // MARK: - Private Properties
    
    private let logger = AppLogger(category: "Network")
    
    // MARK: - Public Methods
    
    /// Validates the HTTP response status code and logs the request.
    ///
    /// - Parameters:
    ///   - response: The raw data and URL response from the network request.
    ///   - request: The original URLRequest sent.
    ///   - duration: The time interval the request took.
    /// - Throws: A `NetworkError` if the response status code indicates failure.
    func validate(response: NetworkResponse, for request: URLRequest, with duration: TimeInterval) throws {
        
        guard let httpResponse = response.urlResponse as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        #if DEBUG
        let requestMethod = request.httpMethod ?? "Unknown Method"
        let requestPath = request.url?.absoluteString ?? "Invalid URL"
        let statusCode = httpResponse.statusCode
        let statusText = String(statusCode)
        logger.debug("[\(requestMethod)] \(requestPath) - \(statusText) - \(String(format: "%.2f", duration))s")
        #endif
        
        switch statusCode {
        case 200...299:
            return
        case 400...499:
            throw NetworkError.clientError(statusCode: statusCode)
        case 500...599:
            throw NetworkError.serverError(statusCode: statusCode)
        default:
            throw NetworkError.unknownError(statusCode: statusCode)
        }
    }
    
    /// Decodes the response data into a specified `Decodable` type.
    ///
    /// - Parameter response: The network response containing raw data.
    /// - Returns: A decoded model of type `D`.
    /// - Throws: A decoding error if the data cannot be parsed.
    func decode<D: Decodable>(response: NetworkResponse) throws -> D {
        return try JSONDecoder().decode(D.self, from: response.data)
    }
}
