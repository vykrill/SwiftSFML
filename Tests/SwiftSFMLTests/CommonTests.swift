import XCTest
@testable import SwiftSFML


final class CommonTests: XCTestCase {
    func unicodeTest() {
        let string = "Swift SFML"
        let scalars = string.utf32.map{Unicode.Scalar($0)!}
        // let newString = String(string.utf32.map {UnicodeScalar($0)})
        var newString = String(String.UnicodeScalarView(scalars))
        print(string.utf32)
        print(newString)
        // These two strings are different because 'newString' has an null character at the end.
        let _ = newString.popLast()
        XCTAssertEqual(string, newString)
    }

    static var allTests = [
        ("commonTestUnicode", unicodeTest),
    ]
}
