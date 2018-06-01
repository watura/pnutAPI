import XCTest
@testable import pnutAPI

final class pnutAPITests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(pnutAPI().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
