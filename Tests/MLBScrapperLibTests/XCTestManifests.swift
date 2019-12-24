import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(MLBScrapperLibTests.allTests),
    ]
}
#endif
