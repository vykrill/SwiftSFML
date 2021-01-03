import XCTest
@testable import SwiftSFML


final class GraphicsTests: XCTestCase {
    func testColor() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var color = Color(r: 255, g: 255, b: 0)
        
        color += Color(r: 0, g: 0, b: 255)
        XCTAssertEqual(color, Color.white)

        XCTAssertEqual(color * Color.blue, Color.blue)
    }

    static var allTests = [
        ("graphicsTestColor", testColor),
    ]
}