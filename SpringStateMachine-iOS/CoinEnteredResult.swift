//
// Created by Deline Neo on 5/11/2015.
// Copyright (c) 2015 Deline Neo. All rights reserved.
//

import Foundation

class CoinEnteredResult {
    let amountEnteredSoFar: NSDecimalNumber
    let enoughFundsEntered: Bool

    init(amountEnteredSoFar: NSDecimalNumber, enoughFundsEntered: Bool) {
        self.amountEnteredSoFar = amountEnteredSoFar;
        self.enoughFundsEntered = enoughFundsEntered;
    }
}
