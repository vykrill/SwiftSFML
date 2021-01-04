import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftSFMLTests.allTests),
        testCase(SystemTests.allTests),
        testCase(WindowTests.allTests),
        testCase(GraphicsTests.allTests),
        testCase(CommonTests.allTests),
    ]
}
#endif
