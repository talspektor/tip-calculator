//
//  CalculatorScreen.swift
//  tip-calculatorUITests
//
//  Created by Tal Spektor on 06/11/2023.
//

import XCTest

class CalculatorScreen {
    
    private let app: XCUIApplication
    
    init(app: XCUIApplication) {
        self.app = app
    }
    
    // MARK: - LogoVidew
    var logoView: XCUIElement {
        return app.otherElements[ScreenIdentifier.LogoView.logoView.rawValue]
    }
    
    // MARK: - ResultView
    var totalAmountPerPersonValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue]
    }
    
    var totalBillValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalBillValueLabel.rawValue]
    }
    
    var totalTipValueLabel: XCUIElement {
        return app.staticTexts[ScreenIdentifier.ResultView.totalTipValueLabel.rawValue]
    }
    
    // MARK: - BillInputView
    var billInputViewTextView: XCUIElement {
        return app.textFields[ScreenIdentifier.BillInputView.textField.rawValue]
    }
    
    // MARK: - TipInputView
    var tenPrecentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.tenPrecentButton.rawValue]
    }
    
    var fifteenPrecentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.fifteenPrecentButton.rawValue]
    }
    
    var twentyPrecentTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.twentyPrecentButton.rawValue]
    }
    
    var customTipButton: XCUIElement {
        app.buttons[ScreenIdentifier.TipInputView.custonPresentButton.rawValue]
    }
    
    var customTipAlertTextField: XCUIElement {
        app.textFields[ScreenIdentifier.TipInputView.customTipAlertTextView.rawValue]
    }
    
    // MARK: - SplitInputView
    var incrementButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitInputView.incrementButton.rawValue]
    }
    
    var decrementButton: XCUIElement {
        app.buttons[ScreenIdentifier.SplitInputView.decrementButton.rawValue]
    }
    
    var splitValueLabel: XCUIElement {
        app.staticTexts[ScreenIdentifier.SplitInputView.quantityValueLabel.rawValue]
    }
    
    // MARK: - Actions
    func enterBill(amount: Double) {
        billInputViewTextView.tap()
        billInputViewTextView.typeText("\(amount)\n")
    }
    
    func selectTip(tip: Tip) {
        switch tip {
        case .tenPrecent:
            tenPrecentTipButton.tap()
        case .fifteenPrecent:
            fifteenPrecentTipButton.tap()
        case .twentyPrecent:
            twentyPrecentTipButton.tap()
        case .custom(let value):
            customTipButton.tap()
            XCTAssertTrue(customTipAlertTextField.waitForExistence(timeout: 1.0))
            customTipAlertTextField.typeText("\(value)\n")
        }
    }
    
    func selectIncrementButton(numberOfTaps: Int) {
        incrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func selectDecrenetButton(numberOfTaps: Int) {
        decrementButton.tap(withNumberOfTaps: numberOfTaps, numberOfTouches: 1)
    }
    
    func douleTapLogoView() {
        logoView.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    }
    
    enum Tip {
        case tenPrecent
        case fifteenPrecent
        case twentyPrecent
        case custom(value: Int)
    }
}
