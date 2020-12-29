import XCTest
@testable import SwiftSFML


final class SystemTests: XCTestCase {
    func testTime() {
        var time = Time(microseconds: 0)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("SystemTimeTest", testTime),
    ]
}
