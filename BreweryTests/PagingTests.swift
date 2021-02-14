//
//  PagingTests.swift
//  BreweryTests
//
//  Created by Denrick on 2/14/21.
//

import XCTest
import Unrealm
@testable import Brewery

class PagingTests: XCTestCase {

    override class func setUp() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    override class func tearDown() {
        guard let realm = try? Realm() else { return }
        try? realm.write {
            realm.deleteAll()
        }
    }
    
    func testPaging() {
        var result1: Result<[BeerResponse], APIError>?
        var result2: Result<[BeerResponse], APIError>?
        var result3: Result<[BeerResponse], APIError>?
        
        let stub1 = loadStub(name: "page1", ofType: "json")
        let stub2 = loadStub(name: "page2", ofType: "json")
        let stub3 = loadStub(name: "page3", ofType: "json")
        
        let beersService = BeersService()
        let expectation = self.expectation(description: "waiting for beers data fetch")
        
        beersService.fetchBeers(name: "", page: 1, provider: PunkAPI.provider(stubData: stub1)) { result in
            result1 = result
            
            beersService.fetchBeers(name: "", page: 2, provider: PunkAPI.provider(stubData: stub2)) { result in
                result2 = result
                
                beersService.fetchBeers(name: "", page: 3, provider: PunkAPI.provider(stubData: stub3)) { result in
                    result3 = result
                    expectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            switch result1 {
            case .success(let response1):
                XCTAssertEqual(response1[0].id, 1)
                switch result2 {
                case .success(let response2):
                    XCTAssertEqual(response2[0].id, 11)
                    switch result3 {
                    case .success(let response3):
                        XCTAssertEqual(response3.count, 0)
                    default: break
                    }
                default: break
                }
            default: break
            }
        }
    }

}
