//
//  UIResponder+Extension.swift
//  tip-calculator
//
//  Created by Tal Spektor on 04/11/2023.
//

import UIKit

extension UIResponder {
    
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
