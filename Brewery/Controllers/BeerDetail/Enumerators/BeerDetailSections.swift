//
//  BeerDetailSections.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import UIKit

enum BeerDetailSections: Int {
    case header = 0
    case foodPairs
    case beerDescription
}

extension BeerDetailSections {
    var height: CGFloat {
        switch self {
        case .header:
            return 160
        case .foodPairs,
             .beerDescription:
            return UITableView.automaticDimension
        }
    }
}
