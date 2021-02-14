//
//  APIErrorTests.swift
//  BreweryTests
//
//  Created by Denrick on 2/14/21.
//

import XCTest
@testable import Brewery

class APIErrorTests: XCTestCase {
    func testAPIErrors() {
        XCTAssertEqual(APIError.network.errorTitle, L10n.Error.title)
        XCTAssertEqual(APIError.network.errorMessage, L10n.Error.Network.message)
        XCTAssertEqual(APIError.jsonParse.errorTitle, L10n.Error.title)
        XCTAssertEqual(APIError.jsonParse.errorMessage, L10n.Error.Json.message)
        XCTAssertEqual(APIError.api(code: 500).errorTitle, L10n.Error.title)
        XCTAssertEqual(APIError.api(code: 500).errorMessage, L10n.Error.Api.message(500))
    }
}
