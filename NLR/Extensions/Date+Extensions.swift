//
//  Date+Extensions.swift
//  NLR
//
//  Created by Nordy Vlasman on 12/7/20.
//

import Foundation

extension Date {
    func toString(dateFormat format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
