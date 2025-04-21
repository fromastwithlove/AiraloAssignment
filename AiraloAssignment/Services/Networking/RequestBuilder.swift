//
//  RequestBuilder.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 19.04.25.
//

import Foundation

/// A utility class responsible for constructing `URLRequest` objects
/// with the appropriate HTTP method, headers, and optional timeout.
///
/// Currently tailored for requests without a body (e.g., `GET`, `HEAD`),
/// but can be extended to support encoded request bodies for other HTTP methods.
class RequestBuilder {

    /// Creates a configured `URLRequest` for the given HTTP method and URL.
    ///
    /// - Parameters:
    ///   - method: The HTTP method to use (e.g., `.get`, `.head`).
    ///   - url: The full URL for the request.
    ///   - timeout: Optional timeout interval for the request.
    /// - Returns: A configured `URLRequest` ready to be sent.
    func makeRequest(method: HTTPMethod, url: URL, timeout: TimeInterval?) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let timeout {
            request.timeoutInterval = timeout
        }
        
        request.setValue(HTTPContentType.json, forHTTPHeaderField: HTTPHeader.accept)
        request.setValue(Locale.current.region?.identifier.lowercased(), forHTTPHeaderField: HTTPHeader.acceptLanguage)
        
        return request
    }
}
