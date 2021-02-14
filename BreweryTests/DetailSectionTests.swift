//
//  DetailSectionTests.swift
//  BreweryTests
//
//  Created by Denrick on 2/14/21.
//

import XCTest
@testable import Brewery

class DetailSectionTests: XCTestCase {
    func testDetailSectionHeight() {
        XCTAssertEqual(BeerDetailSections(rawValue: 0)?.height, 160)
        XCTAssertEqual(BeerDetailSections(rawValue: 1)?.height, UITableView.automaticDimension)
        XCTAssertEqual(BeerDetailSections(rawValue: 2)?.height, UITableView.automaticDimension)
    }
}
