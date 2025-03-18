//
//  ImageCacheManagerTests.swift
//  ChallengeFetchSwiftUITests
//
//  Created by alex on 17/03/25.
//

import XCTest
import SwiftUI
@testable import ChallengeFetchSwiftUI

class ImageCacheManagerTests: XCTestCase {
    var cacheManager: ImageCacheManager!
    var testImage: UIImage!
    var testURL: URL!
    
    override func setUp() {
        super.setUp()
        cacheManager = ImageCacheManager.shared
        testImage = UIImage(named: "imageEmptySmall")!
        testURL = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg")!
    }
    
    override func tearDown() {
        let fileURL = cacheManager.cacheFileURL(url: testURL)
        try? FileManager.default.removeItem(at: fileURL)
        super.tearDown()
    }
    
    func testSaveImage() {
        // Given
        cacheManager.saveImage(image: testImage, url: testURL)
        // When
        let fileURL = cacheManager.cacheFileURL(url: testURL)
        // Then
        XCTAssertNotNil(fileURL, "file should not be nil")
    }
        
    func testLoadImage(){
        // Given
        cacheManager.saveImage(image:testImage, url: testURL)
        // When & Then
        if let image = cacheManager.loadImage(url: testURL) {
            XCTAssertNotNil(image, "lmage should not be nil")
        }
    }
        
    func testLoadNilImage() {
        // Given & When
        let image = cacheManager.loadImage(url: URL(string: "https://imagecom/random.png")!)
        // Then
        XCTAssertNil(image, "image should be nil")
    }
       
}

