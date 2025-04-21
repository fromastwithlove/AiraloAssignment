//
//  RequestBuilderTests.swift
//  AiraloAssignmentTests
//
//  Created by Adil Yergaliyev on 21.04.25.
//

import Testing
import Foundation
@testable import AiraloAssignment


// MARK: - RequestBuilder Tests

@Suite struct RequestBuilderTests {
    
    @Test func testRequestBuilderWithTimeout() {
        // Arrange
        let requestBuilder = RequestBuilder()
        let url = URL(string: "api/v2/countries")!
        let timeout: TimeInterval = 30
        
        // Act
        let request = requestBuilder.makeRequest(method: .get, url: url, timeout: timeout)
        
        // Assert
        #expect(request.httpMethod == HTTPMethod.get.rawValue, "The HTTP method should be GET")
        #expect(request.timeoutInterval == timeout, "Timeout interval should be \(timeout)")
        #expect(request.value(forHTTPHeaderField: HTTPHeader.accept) == HTTPContentType.json, "Accept header should be application/json")

        // For region-specific header (Accept-Language)
        let expectedRegion = Locale.current.region?.identifier.lowercased()
        #expect(request.value(forHTTPHeaderField: HTTPHeader.acceptLanguage) == expectedRegion, "Accept-Language header should be \(expectedRegion ?? "unknown region")")
    }
    
    
    @Test func testRequestBuilderWithoutTimeout() {
        // Arrange
        let requestBuilder = RequestBuilder()
        let url = URL(string: "https://airalo.com/api/v2/countries")!
        
        // Act
        let request = requestBuilder.makeRequest(method: .get, url: url, timeout: nil)
        
        // Assert
        #expect(request.httpMethod == HTTPMethod.get.rawValue)
        #expect(request.timeoutInterval == URLRequest(url: url).timeoutInterval)
    }
}
