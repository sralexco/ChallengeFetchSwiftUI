//
//  RecipesModel.swift
//  ChallengeFetchSwiftUI
//
//  Created by alex on 16/03/25.
//
import SwiftUI

struct RecipesModel: Codable {
    let recipes: [RecipeModel]?
    enum CodingKeys: String, CodingKey {
        case recipes = "recipes"
    }
}

struct RecipeModel: Identifiable, Codable {
    let id: String
    let name: String
    let cuisine: String
    let photoURLSmall: URL?
    let photoURLLarge: URL?
    let youtubeURL: URL?
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case name = "name"
        case cuisine = "cuisine"
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case youtubeURL = "youtube_url"
    }
}
