//
// Created by Deline Neo on 4/11/2015.
// Copyright (c) 2015 Deline Neo. All rights reserved.
//

import Foundation
import ReactiveCocoa

class CoinEntryViewModel {

    var amountEntered = NSDecimalNumber.zero()
    private lazy var coinEnteredSignal: RACSignal = self.initiateCoinEnteredSignal();
    lazy var coinEnteredCommand: RACCommand = self.initiateCoinEnteredCommand()


    init() {
        coinEnteredCommand.executionSignals.switchToLatest().deliverOnMainThread().subscribeNext {
            (next: AnyObject!) -> () in
            let amount = next as! NSDecimalNumber
            self.amountEntered = self.amountEntered.decimalNumberByAdding(amount)
        }
    }

    func initiateCoinEnteredCommand() -> RACCommand {
        return RACCommand(signalBlock: {
            _ -> RACSignal! in
            return self.coinEnteredSignal
        })
    }

    private func initiateCoinEnteredSignal() -> RACSignal {
        return RACSignal.createSignal({
            (subscriber: RACSubscriber!) -> RACDisposable! in
            subscriber.sendNext(NSDecimalNumber.one())
            subscriber.sendCompleted()
            return nil
        })
    }

}
