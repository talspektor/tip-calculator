//
//  ScreenIdentifier.swift
//  tip-calculator
//
//  Created by Tal Spektor on 06/11/2023.
//

import Foundation

enum ScreenIdentifier {
    
    enum LogoView: String {
        case logoView
    }
    
    enum ResultView: String {
        case totalAmountPerPersonValueLabel
        case totalBillValueLabel
        case totalTipValueLabel
    }
    
    enum BillInputView: String {
        case textField
    }
    
    enum TipInputView: String {
        case tenPrecentButton
        case fifteenPrecentButton
        case twentyPrecentButton
        case custonPresentButton
        case customTipAlertTextView
    }
    
    enum SplitInputView: String {
        case decrementButton
        case incrementButton
        case quantityValueLabel
    }
}
