//
//  String+ToCleanedDate.swift
//  Brewery
//
//  Created by Denrick on 2/13/21.
//

import Foundation

extension String {
    func toCleanedDate() -> String {
        let dateFormatterIn = DateFormatter()
        dateFormatterIn.dateFormat = "MM/yyyy"

        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateFormat = "MMM. yyyy"

        if let date = dateFormatterIn.date(from: self) {
            return dateFormatterOut.string(from: date)
        }
        
        return ""
    }
}
