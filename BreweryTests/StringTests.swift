//
//  StringTests.swift
//  BreweryTests
//
//  Created by Denrick on 2/14/21.
//

import XCTest
@testable import Brewery

class StringTests: XCTestCase {
    func testToCleanedDate() {
        XCTAssertEqual("04/2007".toCleanedDate(), "Apr. 2007")
        XCTAssertEqual("abc".toCleanedDate(), "")
    }
}
