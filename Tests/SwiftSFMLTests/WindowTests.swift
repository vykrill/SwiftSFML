import XCTest
@testable import SwiftSFML


final class WindowTests: XCTestCase {
    func testParameters() {
        let style: WindowStyle = [.titlebar, .close, .resize]

        XCTAssertTrue(style == WindowStyle.defaultStyle)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("windowTestParameters", testParameters),
    ]
}
