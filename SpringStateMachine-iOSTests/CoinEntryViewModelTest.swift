//
//  CoinEntryViewModelTest.swift
//  SpringStateMachine-iOS
//
//  Created by Deline Neo on 4/11/2015.
//  Copyright © 2015 Deline Neo. All rights reserved.
//

import XCTest
import Nimble

@testable import SpringStateMachine_iOS

class CoinEntryViewModelTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testViewModelShouldKeepTrackOfAmountEntered() {
        let viewModel = CoinEntryViewModel()
        expect(viewModel.amountEntered).to(equal(NSDecimalNumber.zero()))
        
        viewModel.coinEnteredCommand.execute(nil);
        expect(viewModel.amountEntered).toEventually(equal(NSDecimalNumber.one()))

        viewModel.coinEnteredCommand.execute(nil);
        expect(viewModel.amountEntered).toEventually(equal(NSDecimalNumber(double: 2.0)))
    }
    
}
