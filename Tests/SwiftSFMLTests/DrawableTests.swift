import XCTest
@testable import SwiftSFML


final class DrawableTests: XCTestCase {

    struct Triangle: Drawable {
        var vertices: [Vertex]
        let type = PrimitiveType.triangles
        var transformations = TransformHandler()
        var texture: Texture?

        init(width: Float, height: Float) {
            self.vertices = [
                Vertex(position: Vector2F(x: width / 2, y: 0), color: .white, texCoords: Vector2F()),
                Vertex(position: Vector2F(x: width, y: height), color: .white, texCoords: Vector2F()),
                Vertex(position: Vector2F(x: 0, y: height), color: .white, texCoords: Vector2F())
            ]
        }
    }

    struct TestResetRectModif: Drawable {
        var vertices = [Vertex]()
        var transformations = TransformHandler()
        let type = PrimitiveType.lines
        var texture: Texture?

        func getTextureCoordinate(for vertex: Vertex, textureRect rect: RectF) -> Vector2F {
            print("Yeah!")
            let vect = Vector2F(x: 1, y: 1)
            return vect
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

    public func testTransform() {
        let triangle = Triangle(width: 10, height: 10)
        triangle.scale(by: Vector2F(x: 2, y: 2))

        XCTAssertEqual(triangle.getGlobalBounds(), RectF(left: 0, top: 0, width: 20, height: 20))
        XCTAssertEqual(triangle.getGlobalBounds(), triangle.transform.transform(triangle.bounds))
    }

    func testResetRectOverriding() {
        var shape = TestResetRectModif()
        shape.vertices = [Vertex()]
        shape.setTextureRect(to: RectF(left: 0, top: 0, width: 1, height: 1))
        
        XCTAssertEqual(shape.vertices[0].texCoords, Vector2F(x: 1, y: 1))
    }

    static var allTests = [
        ("DrawableResetRectTest", testResetRect),
        ("DrawableTestResetRectOverride", testResetRectOverriding),
        ("DrawableTestTransform", testTransform)
    ]
}
