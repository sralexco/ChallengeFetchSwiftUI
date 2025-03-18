//
//  RecipesViewModel.swift
//  ChallengeFetchSwiftUI
//
//  Created by alex on 16/03/25.
//
import SwiftUI

class RecipesViewModel: BaseViewModel {
    @Published var recipes: [RecipeModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let apiURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")!
    private var urlSession: URLSession
    // https://d3jbb8n5wk0qxi.cloudfront.net/recipes-empty.json
    // https://d3jbb8n5wk0qxi.cloudfront.net/recipes-malformed.json
    
    init(urlSession: URLSession = .shared) {
          self.urlSession = urlSession
      }
    
    func fetchRecipes(){
        self.isLoading = true
        self.errorMessage = nil
        Task {
            do {
                let (data, _) = try await urlSession.data(from: apiURL)
                let res = try JSONDecoder().decode(RecipesModel.self, from: data)
                await MainActor.run {
                    if let recipes = res.recipes {
                        self.recipes = recipes.sorted { $0.name < $1.name}
                                              .sorted { $0.cuisine < $1.cuisine}
                    } else {
                        showAlert(title: "Alert", message: "We're experiencing an issue with the service at the moment. Please try again later. Thank you for your patience!.")
                    }
                }
            } catch {
                await MainActor.run {
                    showAlert(title: "Alert", message: "We're experiencing an issue with the service at the moment. Please try again later. Thank you for your patience!.")
                    self.isLoading = false
                }
            }
        }
       
     
    }
}
