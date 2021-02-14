//
//  XCTest+LoadStub.swift
//  BreweryTests
//
//  Created by Denrick on 2/14/21.
//

import XCTest

extension XCTest {
    func loadStub(name: String, ofType: String) -> Data? {
        let bundle = Bundle(for: type(of: self))
            
        if let url = bundle.url(forResource: name, withExtension: ofType) {
            do {
                return try Data(contentsOf: url)
            } catch {
                return nil
            }
        }
        return nil
    }
}
