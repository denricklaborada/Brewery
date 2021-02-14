//
//  BeersResponse.swift
//  Brewery
//
//  Created by Denrick on 2/11/21.
//

import Foundation
import Unrealm

struct BeerResponse: Decodable, Realmable, Equatable {
    var id: Int = 0
    var name: String = ""
    var tagline: String = ""
    var firstBrewed: String = ""
    var beerDescription: String = ""
    var imageURL: String = ""
    var alcohol: Double = 0
    var foodPairing: [String] = []
    
    static func primaryKey() -> String? {
        return "id"
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case tagline
        case firstBrewed = "first_brewed"
        case beerDescription = "description"
        case imageURL = "image_url"
        case alcohol = "abv"
        case foodPairing = "food_pairing"
    }
    
    init() {}
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline) ?? ""
        firstBrewed = try container.decodeIfPresent(String.self, forKey: .firstBrewed) ?? ""
        beerDescription = try container.decodeIfPresent(String.self, forKey: .beerDescription) ?? ""
        imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL) ?? ""
        alcohol = try container.decodeIfPresent(Double.self, forKey: .alcohol) ?? 0
        foodPairing = try container.decodeIfPresent([String].self, forKey: .foodPairing) ?? []
    }
}
