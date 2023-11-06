//
//  Tip.swift
//  tip-calculator
//
//  Created by Tal Spektor on 04/11/2023.
//

import Foundation

enum Tip {
    case none
    case tenPresent
    case fifteenPrecent
    case twentyPrecent
    case custom(value: Int)
    
    var stringValue: String {
        switch self {
        case .none:
            return ""
        case .tenPresent:
            return "10%"
        case .fifteenPrecent:
            return "15%"
        case .twentyPrecent:
            return "20%"
        case .custom(value: let value):
            return String(value)
        }
    }
}
