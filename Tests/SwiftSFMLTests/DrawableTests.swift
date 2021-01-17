import XCTest
@testable import SwiftSFML


final class DrawableTests: XCTestCase {

    struct Triangle: Drawable {
        var vertices: [Vertex]
        let type = PrimitiveType.triangles
        var origin = Vector2F()
        var transform = Transform.identity
        var texture: Texture?

        init(width: Float, height: Float) {
            self.vertices = [
                Vertex(position: Vector2F(x: width / 2, y: 0), color: .white, texCoords: Vector2F()),
                Vertex(position: Vector2F(x: width, y: height), color: .white, texCoords: Vector2F()),
                Vertex(position: Vector2F(x: 0, y: height), color: .white, texCoords: Vector2F())
            ]
        }
    }

    func testResetRect() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        var triangle = Triangle(width: 32, height: 32)
        XCTAssertEqual(triangle.bounds, RectF(left: 0, top: 0, width: 32, height: 32))
        
        let texture = Texture(width: 32, height: 32)!
        triangle.texture = texture
        triangle.resetTextureRect()

        print(triangle.vertices[0].texCoords.x)

        XCTAssertEqual(Vector2F(x: 16, y: 0), Vector2F(x: 16, y: 0))

        XCTAssertEqual(triangle.vertices[0].texCoords, Vector2F(x: 16, y: 0))
    }

    static var allTests = [
        ("DrawableResetRectTest", testResetRect),
    ]
}
