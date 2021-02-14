//
//  APIConstants.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation

enum APIConstants {
    static let apiVersion: Int = 2
    static let baseURL: URL = URL(string: "https://api.punkapi.com/v\(APIConstants.apiVersion)/")!
}
