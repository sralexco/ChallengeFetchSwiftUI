//
//  ImageCacheManager.swift
//  ChallengeFetchSwiftUI
//
//  Created by alex on 16/03/25.
//

import SwiftUI

class ImageCacheManager {
    static let shared = ImageCacheManager()
    private let fileManager = FileManager.default
    private let directory: URL
    
    init() {
        let paths = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        directory = paths[0].appendingPathComponent("CachedImage", isDirectory: true)
        if !fileManager.fileExists(atPath: directory.path) {
            try? fileManager.createDirectory(at: directory, withIntermediateDirectories: true)
        }
    }
    
    func cacheFileURL(url: URL) -> URL {
        let str = url.absoluteString + ".png"
        return directory.appendingPathComponent(str)
    }
    
    func saveImage(image: UIImage, url: URL) {
        guard let data = image.pngData() else { return }
        try? data.write(to: cacheFileURL(url: url))
    }
    
    func loadImage(url: URL) -> UIImage? {
        let fileURL = cacheFileURL(url: url)
        if let data = try? Data(contentsOf: fileURL) {
            return UIImage(data: data)
        }
        return nil
    }
}
