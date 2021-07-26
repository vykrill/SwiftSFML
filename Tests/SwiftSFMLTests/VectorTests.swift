import Foundation
import XCTest
@testable import SwiftSFML

final class VectorTests: XCTestCase {
    func testVector2U() {
        let v1 = Vector2U()
        let v2 = Vector2U.zero
        let v3 = Vector2U(x: 1, y: 2)
        let v4 = Vector2U(x: 2, y: 4)

        XCTAssertEqual(v1, v2)
        XCTAssertEqual(v3 + v2, v3)
        XCTAssertEqual(v3 + v3, v4)
        XCTAssertEqual(v4 - v3, v3)
        XCTAssertEqual(v4 - v2, v4)
    }

    func testVector2I() {
        let v1 = Vector2I()
        let v2 = Vector2I.zero
        let v3 = Vector2I(x: 1, y: 2)
        let v4 = Vector2I(x: 2, y: 4)

        XCTAssertEqual(v1, v2)
        XCTAssertEqual(v3 + v2, v3)
        XCTAssertEqual(v3 + v3, v4)
        XCTAssertEqual(v4 - v3, v3)
        XCTAssertEqual(v4 - v2, v4)
    }

    func testVector2F() {
        let v1 = Vector2F()
        let v4 = Vector2F(x: 2, y: 4)
        let v2 = Vector2F.zero
        let v3 = Vector2F(x: 1, y: 2)

        XCTAssertEqual(v1, v2)
        XCTAssertEqual(v3 + v2, v3)
        XCTAssertEqual(v3 + v3, v4)
        XCTAssertEqual(v4 - v3, v3)
        XCTAssertEqual(v4 - v2, v4)
    }

    func testVector3F() {
        let v1 = Vector3F()
        let v4 = Vector3F(x: 74, y: 16, z: 92)
        let v2 = Vector3F.zero
        let v3 = Vector3F(x: 37, y: 8, z: 46)

        XCTAssertEqual(v1, v2)
        XCTAssertEqual(v3 + v2, v3)
        XCTAssertEqual(v3 + v3, v4)
        XCTAssertEqual(v4 - v3, v3)
        XCTAssertEqual(v4 - v2, v4)
    }

    static let allTests = [
        ("testVector2I", testVector2I),
        ("testVector2U", testVector2U),
        ("testVector2F", testVector2F),
        ("testVector3F", testVector3F),
    ]
}