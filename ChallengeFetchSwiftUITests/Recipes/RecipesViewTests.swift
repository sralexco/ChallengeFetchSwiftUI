//
//  RecipesViewTests.swift
//  ChallengeFetchSwiftUITests
//
//  Created by alex on 17/03/25.
//

import XCTest
import SwiftUI

@testable import ChallengeFetchSwiftUI

class RecipesViewTests: XCTestCase {
 
    func testRecipe_DetailView() throws {
        // Given
        var urlSession: URLSession = .shared
        var viewModel = RecipesViewModel(urlSession: urlSession)
        let recipe1 = RecipeModel(
            id: "1",
            name: "Test Recipe",
            cuisine: "Italian",
            photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
            youtubeURL: URL(string: "https://youtube.com/watch?v=123213")
        )
        let recipe2 = RecipeModel(
            id: "1",
            name: "Test Recipe",
            cuisine: "Italian",
            photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
            youtubeURL: URL(string: "https://youtube.com/watch?v=123213")
        )
        viewModel.recipes = [recipe1, recipe2]
        // When
        let recipesView = RecipesView(VM: viewModel)
        // Then
        XCTAssertNotNil(recipesView, "recipesView should be not nil")
    }
}

