import XCTest
@testable import SwiftSFML


final class WindowTests: XCTestCase {
    func testParameters() {
        var style: WindowStyle = [.titlebar, .close]

        style.insert(.resize)

        XCTAssertTrue(style.contains(.resize))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("windowTestParameters", testParameters),
    ]
}
