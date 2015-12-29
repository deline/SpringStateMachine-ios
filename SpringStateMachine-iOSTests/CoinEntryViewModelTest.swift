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

    private var viewModel: CoinEntryViewModel!
    private let coinEntryService = MockCoinEntryService()

    override func setUp() {
        super.setUp()

        viewModel = CoinEntryViewModel(coinEntryService: coinEntryService)
        
    }

    override func tearDown() {
        super.tearDown()
    }

    func testViewModelShouldKeepTrackOfAmountEntered() {
        expect(self.viewModel.amountEnteredSoFar).to(equal(NSDecimalNumber.zero()))

        self.viewModel.coinEnteredValue.value = NSDecimalNumber(double: 0.5)
        expect(self.viewModel.amountEnteredSoFar).toEventually(equal(NSDecimalNumber(double:0.5)))
        
        self.viewModel.coinEnteredValue.value = NSDecimalNumber(double: 1.0)
        expect(self.viewModel.amountEnteredSoFar).toEventually(equal(NSDecimalNumber(double:1.5)))
        
        self.viewModel.coinEnteredValue.value = NSDecimalNumber(double: 0.5)
        expect(self.viewModel.amountEnteredSoFar).toEventually(equal(NSDecimalNumber(double:2.0)))
    }

    class MockCoinEntryService: CoinEntryService {

        private let amountRequired = NSDecimalNumber(double: 2.0)
        private var amountEnteredSoFar = NSDecimalNumber.zero()

        override func coinEntered(coinValue: NSDecimalNumber, completion: ((result: CoinEnteredResult) -> Void)) {
            self.amountEnteredSoFar = self.amountEnteredSoFar.decimalNumberByAdding(coinValue)
            completion(result: CoinEnteredResult(
                amountEnteredSoFar: self.amountEnteredSoFar,
                amountOutstanding: self.amountRequired.decimalNumberBySubtracting(self.amountEnteredSoFar),
                enoughFundsEntered: self.enoughFundsEntered()))
        }

        func enoughFundsEntered() -> Bool {
            let result = self.amountEnteredSoFar.compare(amountRequired)
            return (result == NSComparisonResult.OrderedAscending || result == NSComparisonResult.OrderedSame)
        }
    }

}
