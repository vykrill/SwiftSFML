import XCTest
@testable import SwiftSFML


final class WindowTests: XCTestCase {
    func testParameters() {
        let style: WindowStyle = [.titlebar, .close, .resize]

        XCTAssertTrue(style == WindowStyle.defaultStyle)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    /// Test if `RenderWindow` is working properly
    func testRenderWindowCreation() {
        let videoMode = VideoMode(width: 640, height: 480, bitsPerPixel: 32)
        // If we do not provide a name, the window does't appear on screen.
        let renderWindow = RenderWindow(mode: videoMode, title: "Swift SFML")

        sleep(Time(seconds: 3.0))
    }

    static var allTests = [
        ("windowTestParameters", testParameters),
        ("windowTestCreation", testRenderWindowCreation)
    ]
}
