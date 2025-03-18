//
//  RecipeDetailViewTests.swift
//  ChallengeFetchSwiftUITests
//
//  Created by alex on 17/03/25.
//

import XCTest
import SwiftUI

@testable import ChallengeFetchSwiftUI

class RecipeDetailViewTests: XCTestCase {
 
    func testRecipe_DetailView() throws {
        // Given
        let recipe = RecipeModel(
            id: "1",
            name: "Test Recipe",
            cuisine: "Italian",
            photoURLSmall: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg"),
            photoURLLarge: URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg"),
            youtubeURL: URL(string: "https://youtube.com/watch?v=123213")
        )
        // When
        let recipeDetailView = RecipeDetailView(recipe: recipe)
        // Then
        XCTAssertNotNil(recipeDetailView, "recipeDetailView should be not nil")
      
    }
}

