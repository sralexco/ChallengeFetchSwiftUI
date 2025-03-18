//
//  RecipeView.swift
//  ChallengeFetchSwiftUI
//
//  Created by alex on 16/03/25.
//

import SwiftUI

struct RecipesView: View {
    @StateObject var VM = RecipesViewModel()
    
    var body: some View {
        NavigationView {
            Group {
                if VM.recipes.isEmpty {
                    Text("No recipes available")
                       .foregroundColor(.gray)
                       .italic()
                } else {
                    List(VM.recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            HStack {
                                if let url = recipe.photoURLSmall {
                                    CachedImageRecipe(url: url)
                                }
                                VStack(alignment: .leading) {
                                    Text(recipe.name)
                                        .font(.headline)
                                    Text(recipe.cuisine)
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .onAppear { VM.fetchRecipes() }
            .toolbar {
                Button("Refresh") {
                   VM.fetchRecipes()
                }
            }
            .alert(item: $VM.activeAlert) { alertItem in alertItem.alert }
        }
        
    }
}

#Preview {
    RecipesView()
}
