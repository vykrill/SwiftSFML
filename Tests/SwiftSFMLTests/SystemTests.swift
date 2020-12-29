import XCTest
@testable import SwiftSFML


final class SystemTests: XCTestCase {
    func testTime() {
        print("Two seconds wait...")
        let time = Time(microseconds: 2000000)
        sleep(duration: time)
        print("done")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    static var allTests = [
        ("SystemTimeTest", testTime),
    ]
}
