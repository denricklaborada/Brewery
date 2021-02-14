//
//  BeersService.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation
import Unrealm
import Moya

struct BeersService {
    let requestManager = APIRequestManager.shared
    
    func fetchBeers(name: String = "",
                    page: Int = 1,
                    provider: MoyaProvider<PunkAPI> = PunkAPI.provider(),
                    completion: @escaping (Result<([BeerResponse]), APIError>) -> Void) {
        requestManager.request(target: PunkAPI.beers(beerName: name, page: page, perPage: 10),
                               provider: provider,
                               mappedTo: [BeerResponse].self) { result in
            switch result {
            case .success(let response):
                let objects = response
                    .compactMap { $0 }
                    .sorted { $0.id < $1.id }
                
                store(objects)
                completion(.success(objects))
            case .failure(let error):
                switch error {
                case .network:
                    guard let objects = retrieve(name: name, page: page) else {
                        completion(.failure(.network))
                        return
                    }
                    
                    completion(.success(objects))
                default:
                    completion(result)
                }
            }
        }
    }
}

// MARK: - Realm Methods

extension BeersService {
    func store(_ data: [BeerResponse]) {
        guard let realm = try? Realm() else {
            assertionFailure("Expected a non-nil realm instance!")
            return
        }
        
        try? realm.write {
            realm.add(data, update: true)
        }
    }
    
    func retrieve(name: String, page: Int) -> [BeerResponse]? {
        guard let realm = try? Realm() else {
            assertionFailure("Expected a non-nil realm instance!")
            return nil
        }
        
        let objects = realm.objects(BeerResponse.self)
            .compactMap { $0 }
            .filter {
                if !name.isEmpty {
                    return $0.name.lowercased().contains(name.lowercased())
                }
                return true
            }
            .sorted { $0.id < $1.id }
        
        let lowerBound = page * 10 - 10
        let upperBound = min(page * 10 - 1, objects.count - 1)
        
        if objects.isEmpty,
           name.isEmpty || page < 2 {
            return nil
        }
        
        guard upperBound > lowerBound else {
            return nil
        }
        
        return Array(objects[lowerBound...upperBound])
    }
}
