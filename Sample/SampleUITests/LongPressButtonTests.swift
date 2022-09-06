//
//  LongPressButtonTests.swift
//  SampleUITests
//
//  Created by Łukasz Rutkowski on 06/09/2022.
//

import XCTest
import XCAppTest

final class LongPressButtonTests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    func testTap() throws {
        app.buttons[.longPressButton].tap()
        assert(taps: 1, longPresses: 0)

        app.buttons[.longPressButton].tap()
        assert(taps: 2, longPresses: 0)
    }

    func testLongPress() throws {
        app.buttons[.longPressButton].press(forDuration: 0.6)
        assert(taps: 0, longPresses: 1)

        app.buttons[.longPressButton].press(forDuration: 0.6)
        assert(taps: 0, longPresses: 2)
    }

    func testTooShortLongPress() throws {
        app.buttons[.longPressButton].press(forDuration: 0.4)
        assert(taps: 1, longPresses: 0)
    }

    func testVeryLongPress() throws {
        app.buttons[.longPressButton].press(forDuration: 1.1)
        assert(taps: 0, longPresses: 1)
    }

    func testMixedTapAndLongPress() throws {
        app.buttons[.longPressButton].tap()
        assert(taps: 1, longPresses: 0)
        app.buttons[.longPressButton].press(forDuration: 0.6)
        assert(taps: 1, longPresses: 1)
        app.buttons[.longPressButton].press(forDuration: 0.6)
        assert(taps: 1, longPresses: 2)
        app.buttons[.longPressButton].tap()
        assert(taps: 2, longPresses: 2)
    }

    private func assert(taps: Int, longPresses: Int) {
        app.staticTexts[.tapCountLabel].assertHasLabel("Taps: \(taps)")
        app.staticTexts[.longPressLabel].assertHasLabel("Long presses: \(longPresses)")
    }
}

extension XCUIElementQuery {
    subscript(_ id: ElementIdentifier) -> XCUIElement {
        return self[id.rawValue]
    }

    subscript(_ id: ElementIdentifier, boundBy index: Int) -> XCUIElement {
        return self.matching(identifier: id.rawValue).element(boundBy: index)
    }
}
