import XCTest

// OrderFlowUITests — placeholder test target
//
// This file intentionally left empty. The XCUITest framework
// will be built out as part of the course curriculum.
//
// When you're ready, add Page Object classes, helper utilities,
// and test cases here.

final class OrderFlowUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDownWithError() throws {
        app = nil
    }
}
