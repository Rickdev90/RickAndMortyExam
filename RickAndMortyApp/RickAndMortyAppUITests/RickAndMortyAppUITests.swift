//
//  RickAndMortyAppUITests.swift
//  RickAndMortyAppUITests
//
//  Created by Rick on 13/05/26.
//
import XCTest

final class RickAndMortyAppUITests:
XCTestCase { override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testCharacterFlow() throws {
        let app = XCUIApplication()
        app.launch()
        let characterName = app.staticTexts["Rick Sanchez"]
        XCTAssertTrue(
            characterName
                .waitForExistence(
                    timeout: 10
                )
        )

        characterName.tap()
        let mapText = app.staticTexts["View on Map"]

        XCTAssertTrue(
            mapText
                .waitForExistence(
                    timeout: 10
                )
        )
        mapText.tap()
    }
}
