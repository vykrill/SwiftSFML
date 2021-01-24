import XCTest
@testable import SwiftSFML


final class RenderTextureTests: XCTestCase {

    func generateTexture() -> Texture {
        RenderTexture(width: 128, height: 128).texture
    }

    func testRenderTexture() {
        let target = RenderTexture(width: 64, height: 64)
        print(target.size)
        print(target.view.size)
        let texture = target.texture
        let anotherTexture = generateTexture()
        
        // We verify the link between the two textures.
        texture.isSmooth.toggle()
        XCTAssertEqual(target.isSmooth, texture.isSmooth)
        XCTAssertEqual(target.size, texture.size)
        // We verify the data of the second texture.
        XCTAssertEqual(anotherTexture.size, Vector2U(x: 128, y: 128))

        // Test of mapCoordsToPoint
        XCTAssertEqual(target.mapCoordsToPixel(Vector2F(x: 10, y: 10), view: target.view), Vector2I(x: 10, y: 10))
        XCTAssertEqual(target.mapPixelToCoords(Vector2I(x: 10, y: 10), view: target.view), Vector2F(x: 10, y: 10))
    }

    static var allTests = [
        ("renderTextureMainTest", testRenderTexture),
    ]
}
