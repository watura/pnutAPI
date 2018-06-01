import XCTest

import pnutAPITests

var tests = [XCTestCaseEntry]()
tests += pnutAPITests.allTests()
XCTMain(tests)