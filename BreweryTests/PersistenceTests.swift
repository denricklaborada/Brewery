//
//  PersistenceTests.swift
//  BreweryTests
//
//  Created by Denrick on 2/14/21.
//

import XCTest
import Unrealm
@testable import Brewery

class PersistenceTests: XCTestCase {

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
    
    func testPersistence() {
        var onlineResult: Result<[BeerResponse], APIError>?
        var offlineResult: Result<[BeerResponse], APIError>?
        
        let beersService = BeersService()
        let expectation = self.expectation(description: "waiting for beers data fetch")
        let stub = loadStub(name: "page1", ofType: "json")
        
        beersService.fetchBeers(name: "", page: 1, provider: PunkAPI.provider(stubData: stub)) { result in
            onlineResult = result
            
            beersService.fetchBeers(name: "", page: 1, provider: PunkAPI.networkFailProvider()) { result in
                offlineResult = result
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5) { error in
            XCTAssertNil(error)
            switch onlineResult {
            case .success(let onlineResponse):
                XCTAssertEqual(onlineResponse.count, 10)
                
                switch offlineResult {
                case .success(let offlineResponse):
                    XCTAssertEqual(offlineResponse, onlineResponse)
                default:
                    XCTFail("Expected to get data from offline storage.")
                }
            default: break
            }
        }
    }
}
