//
//  PunkAPI.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation
import Moya

enum PunkAPI {
    case beers(beerName: String, page: Int, perPage: Int)
}

extension PunkAPI: TargetType {
    var baseURL: URL {
        return APIConstants.baseURL
    }
    
    var path: String {
        switch self {
        case .beers: return "beers"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .beers: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var parameters = [String: Any]()
        
        switch self {
        case let .beers(beerName, page, perPage):
            parameters = ["page": page, "per_page": perPage]
            if !beerName.isEmpty {
                parameters["beer_name"] = beerName
            }
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
