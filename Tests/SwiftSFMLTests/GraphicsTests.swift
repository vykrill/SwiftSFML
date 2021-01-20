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

        var transform2 = Transform()
        transform2.rotate(by: 90, withCenter: Vector2F(x: 0, y: 0))

        XCTAssertEqual(transform, transform2)

        transform.translate(by: Vector2F(x: 10, y: 10))
        transform2.translate(by: Vector2F(x: 10, y: 10))
        transform.rotate(by: 90)
        transform2.rotate(by: 90, withCenter: Vector2F(x: 0, y: 0))
        XCTAssertEqual(transform, transform2)

        print(transform.matrix)
    }

    func testTextures() {
        let url = URL(fileURLWithPath: "/foo.png")
        var tex = Texture(fromURL: url, withArea: nil)
        tex = Texture(width: 512, height: 512)
        print(tex as Any)
    }

    func testSprite() {
        let sprite = Sprite.init()
        XCTAssertNil(sprite.texture)
        print(sprite.sprite)
    } 

    func testBlendMode() {

        let sourceFactor = BlendMode.Factor.zero
        let destFactor = BlendMode.Factor.zero
        let equation = BlendMode.Equation.add

        let blend1 = BlendMode(sourceFactor: sourceFactor, destinationFactor: destFactor, blendEquation: equation)
        let blend2 = BlendMode()

        XCTAssertEqual(blend1, blend2)
    }

    func testImage() {
        let savedImageURL = URL(string: Bundle.main.resourcePath! + "/savedImage.png")
        let sourceImageURL = Bundle.module.url(forResource: "texture", withExtension: "png")
        print(Bundle.module)
        print(String(describing: savedImageURL))
        print(String(describing: sourceImageURL))
        print(Bundle.allBundles.count)

        /// Empty Image
        let image = Image(width: 0, height: 0)
        XCTAssertFalse(image.save(to: savedImageURL!))

        /// Normal image
        let image2 = Image(fromFileURL: sourceImageURL!)
        XCTAssertNotNil(image2)
        let size = Int(image2!.size.x * image2!.size.y * 4)
        XCTAssertEqual(size, image2!.getPixels()!.count)
        XCTAssertTrue(image2!.save(to: savedImageURL!))
    }

    func testView() {
        var view = View()
        XCTAssertEqual(view.size, Vector2F(x: 1000, y: 1000))

    }

    static var allTests = [
        ("graphicsTestColor", testColor),
        ("graphicsTestTransform", testTransform),
        ("graphicsTestTextures", testTextures),
        ("graphicTestSprite", testSprite),
        ("graphicTestBlendMode", testBlendMode),
        ("graphicTestImage", testImage),
        ("graphicTestView", testView)
    ]
}
