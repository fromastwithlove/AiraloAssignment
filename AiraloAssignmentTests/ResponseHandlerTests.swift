//
//  ResponseHandlerTests.swift
//  AiraloAssignment
//
//  Created by Adil Yergaliyev on 22.04.25.
//

import Testing
import Foundation
@testable import AiraloAssignment


// MARK: - ResponseHandler Tests

@Suite struct ResponseHandlerTests {
    
    @Test func testResponseHandlerValidation_Success() throws {
        // Arrange
        let responseHandler = ResponseHandler()
        let mockData = Data()
        let mockResponse = HTTPURLResponse(url: URL(string: "api/v2/countries")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!
        let response = NetworkResponse(data: mockData, urlResponse: mockResponse)
        let request = URLRequest(url: mockResponse.url!)
    
        // Act and Assert
        #expect(throws: Never.self, "Should not throw an error", performing: {
            try responseHandler.validate(response: response, for: request, with: 1.0)
        })
    }
    
    @Test func testResponseHandlerValidation_ClientError() throws {
        // Arrange
        let responseHandler = ResponseHandler()
        let mockData = Data()
        let mockResponse = HTTPURLResponse(url: URL(string: "api/v2/countries")!,
                                            statusCode: 400,
                                            httpVersion: nil,
                                            headerFields: nil)!
        let response = NetworkResponse(data: mockData, urlResponse: mockResponse)
        let request = URLRequest(url: mockResponse.url!)
    
        // Act and Assert
        #expect(throws: NetworkError.clientError(statusCode: 400), "Should throw a client error with status code \(400)", performing: {
            try responseHandler.validate(response: response, for: request, with: 1.0)
        })
    }
    
    @Test func testResponseHandlerValidation_ServerError() throws {
        // Arrange
        let responseHandler = ResponseHandler()
        let mockData = Data()
        let mockResponse = HTTPURLResponse(url: URL(string: "api/v2/countries")!,
                                            statusCode: 500,
                                            httpVersion: nil,
                                            headerFields: nil)!
        let response = NetworkResponse(data: mockData, urlResponse: mockResponse)
        let request = URLRequest(url: mockResponse.url!)
    
        // Act and Assert
        #expect(throws: NetworkError.serverError(statusCode: 500), "Should throw a server error with status code \(500)", performing: {
            try responseHandler.validate(response: response, for: request, with: 1.0)
        })
    }
    
    @Test func testResponseHandlerDecode_Success() throws {
        // Arrange
        let responseHandler = ResponseHandler()
        let mockData = try! JSONEncoder().encode(Country(id: 1, slug: "germany", title: "Germany", image: ImageResource(width: 100, height: 100, url: "api/v2/image/flag-germany.png")))
        let mockResponse = HTTPURLResponse(url: URL(string: "api/v2/countries")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!
        let response = NetworkResponse(data: mockData, urlResponse: mockResponse)
    
        // Act
        let country: Country = try responseHandler.decode(response: response)
    
        // Assert
        #expect(country.id == 1)
        #expect(country.title == "Germany")
        #expect(country.image.url == "api/v2/image/flag-germany.png")
    }
    
    @Test func testResponseHandlerDecode_Failure() throws {
        // Arrange
        let responseHandler = ResponseHandler()
        let invalidData = "Invalid data".data(using: .utf8)!
        let mockResponse = HTTPURLResponse(url: URL(string: "api/v2/countries")!,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)!
        let response = NetworkResponse(data: invalidData, urlResponse: mockResponse)
    
        // Act and Assert
        #expect(throws: DecodingError.self, "Should throw an error", performing: {
            let _: [CountryPackages] = try responseHandler.decode(response: response)
        })
    }
}
