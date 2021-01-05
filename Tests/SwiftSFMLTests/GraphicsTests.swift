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

        // HSV tests
        XCTAssertEqual(Color(h: 0, s: 0, v: 0), .black)
        XCTAssertEqual(Color(h: 0, s: 0, v: 1), .white)
        XCTAssertEqual(Color(h: 0, s: 1, v: 1), .red)
        XCTAssertEqual(Color(h: 120, s: 1, v: 1), .green)
        XCTAssertEqual(Color(h: 240, s: 1, v: 1), .blue)

        XCTAssertEqual(Color(h: 60,  s: 1, v: 1), Color(r: 255, g: 255, b: 0)) // Yellow
        XCTAssertEqual(Color(h: 180, s: 1, v: 1), Color(r: 0, g: 255, b: 255)) // Cyan
        XCTAssertEqual(Color(h: 300, s: 1, v: 1), Color(r: 255, g: 0, b: 255)) // Magenta

        XCTAssertEqual(Color(h: 0, s: 0, v: 0.75), Color(r: 191, g: 191, b: 191))
        XCTAssertEqual(Color(h: 0, s: 0, v: 0.50), Color(r: 127, g: 127, b: 127))

        XCTAssertEqual(Color(h: 0  , s: 1, v: 0.5), Color(r: 127, g: 0  , b: 0))
        XCTAssertEqual(Color(h: 60 , s: 1, v: 0.5), Color(r: 127, g: 127, b: 0))
        XCTAssertEqual(Color(h: 120, s: 1, v: 0.5), Color(r: 0  , g: 127, b: 0))
        XCTAssertEqual(Color(h: 300, s: 1, v: 0.5), Color(r: 127, g: 0  , b: 127))
        XCTAssertEqual(Color(h: 180, s: 1, v: 0.5), Color(r: 0  , g: 127, b: 127))
        XCTAssertEqual(Color(h: 240, s: 1, v: 0.5), Color(r: 0  , g: 0  , b: 127))

        // Color(h: -1, s: 0, v: 0)
        // Color(h: 360, s: 0, v: 0)
        // Color(h: 0, s: -1, v: 0)
        // Color(h: 0, s: 2, v: 0)
        // Color(h: 0, s: 0, v: -1)
        // Color(h: 0, s: 0, v: 2)

    }

    func testTransform() {
        var transform: Transform = [
            1.0, 0.0, 0.0,
            0.0, 1.0, 0.0,
            0.0, 0.0, 1.0
        ]

        XCTAssertEqual(transform, Transform.identity)
        transform.rotate(by: 90)

        print(transform.matrix)
    }

    static var allTests = [
        ("graphicsTestColor", testColor),
        ("graphicsTestTransform", testTransform)
    ]
}