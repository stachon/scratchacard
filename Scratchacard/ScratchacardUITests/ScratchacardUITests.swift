//
//  ScratchacardUITests.swift
//  ScratchacardUITests
//
//  Created by Martin Stachon on 25.03.2024.
//

import XCTest

final class ScratchacardUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testScratch() throws {
        let app = XCUIApplication()
        app.launch()
        app.buttons["Go to Scratching Screen"].tap()
        app.buttons["Scratch it!"].tap()

        let searchText = "Card State: Scratched"
        let predicate = NSPredicate(format: "label CONTAINS[c] %@", searchText)

        XCTAssert(app.staticTexts.matching(predicate).firstMatch.waitForExistence(timeout: 5))
    }
}

