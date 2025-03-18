//
//  RecipesViewModelTests.swift
//  ChallengeFetchSwiftUITests
//
//  Created by alex on 17/03/25.
//

import XCTest
import SwiftUI
@testable import ChallengeFetchSwiftUI

class RecipesViewModelTests: XCTestCase {
    var viewModel: RecipesViewModel!
    var mockSession: URLSession!
    
    override func setUp() {
        super.setUp()
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        mockSession = URLSession(configuration: config)
        viewModel = RecipesViewModel(urlSession: mockSession)
    }
    
    override func tearDown() {
        viewModel = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testFetchRecipes_Success() async {
        // Given
        let mockJSON = """
        {
            "recipes": [
                { "uuid": "1", "name": "RiceGreen", "cuisine": "American" },
                { "uuid": "2", "name": "Chifa", "cuisine": "Peruvian" }
            ]
        }
        """.data(using: .utf8)!
        // When
        MockURLProtocol.mockResponse = { _ in
            let response = HTTPURLResponse(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)!
            return (mockJSON, response)
        }

        viewModel.fetchRecipes()
        sleep(1)
        
        // Then
        XCTAssertEqual(viewModel.recipes.count, 2, "recipes.count hould be 2")
        XCTAssertEqual(viewModel.recipes[0].name, "RiceGreen", "name should be Pasta")
        XCTAssertEqual(viewModel.recipes[1].name, "Chifa", "name should be Sushi")
    }
    
    func testFetchRecipes_EmptyResponse() async {
        // Given
       let emptyJSON = """
       { "recipes": [] }
       """.data(using: .utf8)!
        
       // When
       MockURLProtocol.mockResponse = { _ in
           let response = HTTPURLResponse(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)!
       return (emptyJSON, response)}
       
       viewModel.fetchRecipes()
       sleep(1)
        
        // Then
       XCTAssertTrue(viewModel.recipes.isEmpty, "recipes should be empty")
   }
       
   func testFetchRecipes_MalformedResponse() async {
       // Given
       let malformedJSON = """
       { "invalidJson": "122" }
       """.data(using: .utf8)!
       // When
       MockURLProtocol.mockResponse = { _ in
           let response = HTTPURLResponse(url: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!,
                                          statusCode: 200,
                                          httpVersion: nil,
                                          headerFields: nil)!
           return (malformedJSON, response)
       }
       
       viewModel.fetchRecipes()
       sleep(1)
       // Then
       XCTAssertTrue(viewModel.recipes.isEmpty, "recipes should be empty")
   }
       
}

class MockURLProtocol: URLProtocol {
    static var mockResponse: ((URLRequest) -> (Data, URLResponse)?)?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let handler = MockURLProtocol.mockResponse,
           let (data, response) = handler(request) {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else {
            client?.urlProtocol(self, didFailWithError: URLError(.badServerResponse))
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
