//
//  APIRequestManager.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation
import Moya
import Alamofire

class APIRequestManager {
    static let shared = APIRequestManager()
    
    func request<T: TargetType, U: Decodable>(
        target: T,
        provider: MoyaProvider<T> = T.provider(),
        mappedTo decodableModelType: U.Type,
        at keyPath: String? = nil,
        completion: @escaping (Result<U, APIError>) -> Void
    ) {
        provider.request(target) { result in
            switch result {
            case .success(let response):
                do {
                    let moyaResponse = try response.filterSuccessfulStatusCodes()
                    do {
                        let mappedResponse = try moyaResponse.map(decodableModelType, atKeyPath: keyPath, failsOnEmptyData: false)
                        completion(.success(mappedResponse))
                    } catch {
                        completion(.failure(.jsonParse))
                    }
                } catch {
                    completion(.failure(.api(code: response.statusCode)))
                }
            case .failure(let error):
                switch error {
                case .underlying(Alamofire.AFError.explicitlyCancelled, _): break
                default: completion(.failure(.network))
                }
            }
        }
    }
}

struct NoResponse: Decodable {}
