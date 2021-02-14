//
//  TargetType+Provider.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation
import Moya

extension TargetType {
    static func provider(stubData: Data? = nil) -> MoyaProvider<Self> {
        if let stubData = stubData {
            let customEndpointClosure = { (target: Self) -> Endpoint in
                return Endpoint(url: URL(target: target).absoluteString,
                                sampleResponseClosure: { .networkResponse(200, stubData) },
                                method: target.method,
                                task: target.task,
                                httpHeaderFields: target.headers)
            }
            return MoyaProvider<Self>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))])
        }
        return MoyaProvider<Self>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))])
    }
    
    static func networkFailProvider() -> MoyaProvider<Self> {
        let customEndpointClosure = { (target: Self) -> Endpoint in
            return Endpoint(url: URL(target: target).absoluteString,
                            sampleResponseClosure: { .networkError(NSError(domain: "", code: 0, userInfo: nil)) },
                            method: target.method,
                            task: target.task,
                            httpHeaderFields: target.headers)
        }
        
        return MoyaProvider<Self>(endpointClosure: customEndpointClosure, stubClosure: MoyaProvider.immediatelyStub, plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: [.verbose]))])
    }
}
