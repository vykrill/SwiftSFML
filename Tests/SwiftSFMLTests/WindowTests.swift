import XCTest
@testable import SwiftSFML


final class WindowTests: XCTestCase {
    
    // On macOS, the test suite crashes if we put this variable inside a test.
    var testWindow = RenderWindow(
        mode: VideoMode(width: 500, height: 500, bitsPerPixel: 32),
        title: "Test Window"
    )
    
    func testParameters() {
        let style: WindowStyle = [.titlebar, .close, .resize]

        XCTAssertTrue(style == WindowStyle.defaultStyle)
        
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
    }

    func setView(to window: RenderWindow) {
        let view = View(rect: RectF(left: 0, top: 0, width: 355, height: 355))
        window.setView(to: view)
    }

    /// Test if `RenderWindow` is working properly
    func testRenderWindowCreation() {
        
        testWindow.clear()
        testWindow.display()

        // Just to ensure our conversion from `Bool` to `sfBool` is correct.
        testWindow.setMouseCursorVisible(to: false)

        // View tests
        let foo = testWindow.getView()
        print("Default: \(testWindow.getDefaultView().size), \(testWindow.getDefaultView().center)")
        print(foo.size)
        testWindow.position = Vector2I(x: 100, y: 100)
        XCTAssertEqual(testWindow.mapCoordsToPixel(Vector2F(x: 200, y: 200)), Vector2I(x: 200, y: 200))
        testWindow.size = Vector2U(x: 800, y: 800)

        sleep(Time(seconds: 3.0))
        
        // This seems to be flawed, or the operating system has the final word on the window's position.
        // XCTAssertEqual(renderWindow.position, Vector2I(x: 100, y: 100))
        XCTAssertEqual(testWindow.size, Vector2U(x: 800 , y: 800))
 
        testWindow.setView(to: View(rect: RectF(left: 0, top: 0, width: 200, height: 200)))
        XCTAssertEqual(testWindow.mapPixelToCoords(Vector2I(x: 800, y: 800)), Vector2F(x:200, y: 200))

        setView(to: testWindow)
        XCTAssertEqual(testWindow.getView().size, Vector2F(x: 355, y: 355))

        // We can't test this one, since the result are not guaranted.
        print(testWindow.settings)
    }
    
    func testEvent() {
        let event = Event.resized(width: 100, height: 100)
        
        switch event {
        case let .resized(width, height):
            XCTAssertEqual(width, 100)
            XCTAssertEqual(height, 100)
        default: XCTAssertTrue(false)
        }
    }

    static var allTests = [
        ("windowTestParameters", testParameters),
        ("windowTestCreation", testRenderWindowCreation),
        ("windowEventTest", testEvent),
    ]
}
