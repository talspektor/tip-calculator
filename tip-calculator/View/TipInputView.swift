//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Tal Spektor on 02/11/2023.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPrecentTipButton: UIButton = {
        let button = buildTipButton(tip: .tenPresent)
        button.tapPublisher.flatMap {
            Just(Tip.tenPresent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancelables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.tenPrecentButton.rawValue
        return button
    }()
    
    private lazy var fiftinPrecentTipButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPrecent)
        button.tapPublisher.flatMap {
            Just(Tip.fifteenPrecent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancelables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.fifteenPrecentButton.rawValue
        return button
    }()
    
    private lazy var twentyPrecentTipButton: UIButton = {
        let button = buildTipButton(tip: .twentyPrecent)
        button.tapPublisher.flatMap {
            Just(Tip.twentyPrecent)
        }.assign(to: \.value, on: tipSubject)
            .store(in: &cancelables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.twentyPrecentButton.rawValue
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancelables)
        button.accessibilityIdentifier = ScreenIdentifier.TipInputView.custonPresentButton.rawValue
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            tenPrecentTipButton,
            fiftinPrecentTipButton,
            twentyPrecentTipButton
        ])
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var buttonVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            buttonHStackView,
            customTipButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let tipSubject: CurrentValueSubject<Tip, Never> = .init(.none)
    var valuePublisher : AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    private var cancelables = Set<AnyCancellable>()
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        tipSubject.send(.none)
    }
    
    private func layout() {
        [headerView, buttonVStackView].forEach(addSubview(_:))
        
        buttonVStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonVStackView.snp.leading).offset(-24)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonVStackView.snp.centerY)
        }
    }
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(
                title: "Enter custom tip",
                message: nil,
                preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocapitalizationType = .none
            }
            let cancelAction = UIAlertAction(
                title: "cancel",
                style: .cancel)
            let okAcion = UIAlertAction(
                title: "OK",
                style: .default) { [weak self] _ in
                    guard let text = controller.textFields?.first?.text,
                          let value = Int(text) else { return }
                    self?.tipSubject.send(.custom(value: value))
                }
            [okAcion, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        parentViewController?.present(alertController, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [unowned self] tip in
            resetView()
            switch tip {
            case .none:
                break
            case .tenPresent:
                tenPrecentTipButton.backgroundColor = ThemeColor.secondary
            case .fifteenPrecent:
                fiftinPrecentTipButton.backgroundColor = ThemeColor.secondary
            case .twentyPrecent:
                twentyPrecentTipButton.backgroundColor = ThemeColor.secondary
            case .custom(let value):
                customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(
                    string: "$\(value)",
                    attributes: [
                        .font:ThemeFont.bold(ofSize: 20)
                    ])
                text.addAttributes([
                    .font: ThemeFont.bold(ofSize: 14)
                ], range: NSMakeRange(0, 1))
                customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancelables)
    }
    
    private func resetView() {
        [tenPrecentTipButton,
         fiftinPrecentTipButton,
         twentyPrecentTipButton,
         customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        let text = NSMutableAttributedString(
            string: "Custom tip",
            attributes: [.font: ThemeFont.bold(ofSize: 20)])
        customTipButton.setAttributedTitle(text, for: .normal)
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(
            string: tip.stringValue,
            attributes: [
                .font: ThemeFont.bold(ofSize: 20),
                .foregroundColor: UIColor.white
            ])
        text.addAttributes([
            .font: ThemeFont.demobold(ofSize: 14)
        ], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
