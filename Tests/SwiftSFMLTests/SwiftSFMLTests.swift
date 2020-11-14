import XCTest
@testable import SwiftSFML

final class SwiftSFMLTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(SwiftSFML().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
