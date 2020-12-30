import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SwiftSFMLTests.allTests),
        testCase(SystemTests.allTests),
        testCase(WindowTests.allTests),
    ]
}
#endif
