//
//  DetailView.swift
//  ChallengeFetchSwiftUI
//
//  Created by alex on 16/03/25.
//

import SwiftUI

struct RecipeDetailView: View {
    
    let recipe:RecipeModel!
   
    @StateObject private var viewModel = RecipesViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            if let url = recipe.photoURLLarge {
                AsyncImage(url: url){ phase in
                    switch phase {
                    case .success(let image):
                        image.resizable().scaledToFit()
                    case .failure:
                        Image("imageEmptyXL").resizable().scaledToFit()
                    default:
                        ProgressView()
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .frame(width: 400, height: 300)
                
            } else {
                Image("imageEmptyXL")
                    .resizable().scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 400, height: 300)
            }
            Text(recipe.name)
                .padding(.top, 10)
                .font(.headline)
            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            if let youtubeUrl = recipe.youtubeURL {
                Link("Watch on YouTube", destination: youtubeUrl)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
        }
        .padding(.top, 50)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

#Preview {
    //RecipeDetailView()
}
