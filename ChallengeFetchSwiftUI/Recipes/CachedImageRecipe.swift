//
//  CachedImageRecipe.swift
//  ChallengeFetchSwiftUI
//
//  Created by alex on 16/03/25.
//
import SwiftUI

struct CachedImageRecipe: View {
    let url: URL
    @State private var image: UIImage?
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                ProgressView()
                    .onAppear { loadImage() }
            }
        }
        .frame(width: 40, height: 40)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
    
    private func loadImage() {
        if let cachedImage = ImageCacheManager.shared.loadImage(url: url) {
            image = cachedImage
        } else {
            Task {
                do {
                    let request = URLRequest(url: url, timeoutInterval: 5)
                    let (data, _) = try await URLSession.shared.data(for: request)
                    
                    if let downloadedImage = UIImage(data: data) {
                        ImageCacheManager.shared.saveImage(image:downloadedImage, url: url)
                        DispatchQueue.main.async {
                            image = downloadedImage
                        }
                    } else {
                        image = UIImage(named: "imageEmptySmall")
                    }
                } catch {
                    DispatchQueue.main.async {
                        image = UIImage(named: "imageEmptySmall") }
                }
            }
        }
    }
}
