import XCTest
@testable import SwiftSFML
import Foundation


final class ImageTests: XCTestCase {

    /// A temporary image destination.
    let saveDestination = URL(
        fileURLWithPath: "savedImage.png",
        relativeTo: FileManager.default.temporaryDirectory
    )

    /// The path to the image located in the `Resources` folder.
    let testImageLocation = Bundle.module.url(
        forResource: "texture", 
        withExtension: "png"
    )

    let imageSize = Vector2U(x: 256, y: 256)

    /// Tests image creation, modification, saving and opening.
    func testImageBasics() {
        // Image creation
        let srcImage = Image(width: 16, height: 16, fillColor: .black)
        
        // Image modification
        srcImage[ 0,  0] = .red
        srcImage[ 0, 15] = .green
        srcImage[15, 15] = .blue
        srcImage[15,  0] = .transparent
        
        // Image saving
        XCTAssertTrue(srcImage.save(to: saveDestination))

        // Image opening
        let dstImage = Image(fromFileURL: saveDestination)
        XCTAssertNotNil(dstImage)
        
        // The two images are the same.
        XCTAssertEqual(srcImage[ 0,  0], .red)
        XCTAssertEqual(srcImage[ 0, 15], .green)
        XCTAssertEqual(srcImage[15, 15], .blue)
        XCTAssertEqual(srcImage[15,  0], .transparent)

        let srcPixels = srcImage.getPixels()!
        let dstPixels = dstImage!.getPixels()!

        for i in srcPixels.indices {
            let src = srcPixels[i]
            let dst = dstPixels[i]
            XCTAssertEqual(src, dst)
        }
    }

    /// An empty image should fail saving.
    func testEmptyImage() {
        let img = Image(width: 0, height: 0)
        XCTAssertFalse(img.save(to: saveDestination))
    }

    /// Asserts image's size data are coherent
    func testImageSize() {
        if let img = Image(fromFileURL: testImageLocation) {
            let correctSize: UInt32 = 4 * imageSize.x * imageSize.y
            let imageSize = UInt32(4 * img.width * img.height)
            let arraySize = UInt32(img.getPixels()?.count ?? 0)
            XCTAssertEqual(correctSize, imageSize)
            XCTAssertEqual(correctSize, arraySize)
        } else { XCTAssert(false, "Unable to load the test image.") }
    }

    static var allTests = [
        ("graphicsImageTestGeneral", testImageBasics),
        ("graphicsImageTestEmpty", testEmptyImage),
        ("graphicsImageTestSize", testImageSize),
    ]
}