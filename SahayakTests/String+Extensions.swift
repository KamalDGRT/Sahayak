//
// String+Extensions.swift
// Sahayak
//

import XCTest
@testable import Sahayak

final class String_Extensions: XCTestCase {
    func testIsBlank() throws {
        XCTAssertEqual("  ".isBlank, true)
        XCTAssertEqual("".isBlank, true)
        XCTAssertFalse("  k".isBlank)
    }
}
