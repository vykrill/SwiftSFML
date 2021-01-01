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
        let renderWindow = RenderWindow(mode: videoMode, title: "Swift SFML", style: .defaultStyle)

        // Just to ensure our conversion from `Bool` to `sfBool` is correct.
        renderWindow.setMouseCursorVisible(false)

        renderWindow.position = Vector2I(x: 100, y: 100)
        renderWindow.size = Vector2U(x: 800, y: 800)

        sleep(Time(seconds: 3.0))
        // This seems to be flawed, or the operating system has the final word on the window's position.
        // XCTAssertEqual(renderWindow.position, Vector2I(x: 100, y: 100))
        XCTAssertEqual(renderWindow.size, Vector2U(x: 800 , y: 800))

        // We can't test this one, since the result are not guaranted.
        print(renderWindow.settings)
    }

    static var allTests = [
        ("windowTestParameters", testParameters),
        ("windowTestCreation", testRenderWindowCreation)
    ]
}
