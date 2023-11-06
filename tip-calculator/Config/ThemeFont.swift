//
//  ThemeFont.swift
//  tip-calculator
//
//  Created by Tal Spektor on 02/11/2023.
//

import UIKit

struct ThemeFont {
    static func regulat(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Regular", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func bold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-Bold", size: size) ?? .systemFont(ofSize: size)
    }
    
    static func demobold(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "Avenir-DemiBold", size: size) ?? .systemFont(ofSize: size)
    }
}
