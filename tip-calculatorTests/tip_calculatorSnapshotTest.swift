//
//  tip_calculatorSnapshotTest.swift
//  tip-calculatorTests
//
//  Created by Tal Spektor on 06/11/2023.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator
final class tip_calculatorSnapshotTest: XCTestCase {
    
    private var screenWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        // given
        let size = CGSize(width: screenWidth, height: 48)
        // when
        let view = LogoView()
        // then
        assertSnapshot(matching: view, as: .image(size: size), record: true)
    }
}
