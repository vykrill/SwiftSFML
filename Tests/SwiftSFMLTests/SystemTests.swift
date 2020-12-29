import XCTest
@testable import SwiftSFML


final class SystemTests: XCTestCase {
    func testTime() {
        print("Two seconds wait...")
        let clock = Clock()
        let time = Time(microseconds: 2000000)
        sleep(duration: time)
        XCTAssertGreaterThan(clock.elapsedTime, time)
        print("Done (clk = \(clock.elapsedTime), time = \(time)")
        
        // Time Tests
        XCTAssertEqual(time.seconds, 2)
        XCTAssertEqual(time.milliseconds, 2000)
        XCTAssertEqual(time.microseconds, 2000000)
    }

    static var allTests = [
        ("SystemTimeTest", testTime),
    ]
}
