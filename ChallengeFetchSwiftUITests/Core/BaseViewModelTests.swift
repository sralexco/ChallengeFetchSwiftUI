//
//  BaseViewModelTests.swift
//  ChallengeFetchSwiftUITests
//
//  Created by alex on 17/03/25.
//

import XCTest
import SwiftUI
@testable import ChallengeFetchSwiftUI

class BaseViewModelTests: XCTestCase {
    var viewModel: BaseViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = BaseViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testShowAlert_SetsActiveAlert() {
        // Given
        let title = "Test Title"
        let message = "Test Message"
        let action = { print("Test Action") }
        // When
        viewModel.showAlert(title: title, message: message, action: action)
        // Then
        XCTAssertNotNil(viewModel.activeAlert, "activeAlert should not be nil")
        XCTAssertNotNil(viewModel.activeAlert?.id, "id should not be nil")
    }
    
    func testAlertItem_Init() {
        // Given
        let defaultUUID = UUID(uuidString: "12345678-1234-1234-1234-1234567890AB")!
        let alert = Alert(title: Text("Error"), message: Text("Try again more later"))
        // When
        let alertItem = AlertItem(id: defaultUUID, alert: alert)
        // Then
        XCTAssertEqual(alertItem.id, defaultUUID, "id should have the correct UUID")
     }
     
}
