//
//  APIError.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation

enum APIError: Error {
    case jsonParse
    case network
    case api(code: Int)
}

extension APIError {
    var errorTitle: String {
        return L10n.Error.title
    }
    
    var errorMessage: String {
        switch self {
        case .network: return L10n.Error.Network.message
        case .jsonParse: return L10n.Error.Json.message
        case .api(let code): return L10n.Error.Api.message(code)
        }
    }
}
