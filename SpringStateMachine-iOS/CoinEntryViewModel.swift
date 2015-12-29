//
// Created by Deline Neo on 4/11/2015.
// Copyright (c) 2015 Deline Neo. All rights reserved.
//

import Foundation
import ReactiveCocoa

class CoinEntryViewModel: NSObject {

    let coinEnteredValue = MutableProperty<NSDecimalNumber>(0)

    var amountEnteredSoFar = NSDecimalNumber.zero()
    let amountOutstanding = MutableProperty<NSDecimalNumber>(0)
    var enoughFundsEntered = false

    private lazy var coinEnteredCommand: RACCommand = self.initiateCoinEnteredCommand()
    private lazy var coinEnteredSignal: RACSignal = self.initiateCoinEnteredSignal();
    private let coinEntryService: CoinEntryService

    init(coinEntryService: CoinEntryService) {
        self.coinEntryService = coinEntryService;
        super.init()
        initialize();

    }

    private func initialize() {
        self.coinEnteredCommand.executionSignals.switchToLatest().deliverOnMainThread().subscribeNext {
            (next: AnyObject!) -> () in
            let result = next as? CoinEnteredResult
            
            if (result != nil) {
                self.amountEnteredSoFar = result!.amountEnteredSoFar
                self.amountOutstanding.value = result!.amountOutstanding
                self.enoughFundsEntered = result!.enoughFundsEntered
            }

        }

        coinEnteredValue.producer.start {
            coin in
            self.coinEnteredCommand.execute(nil)
        }
    }

    func initiateCoinEnteredCommand() -> RACCommand {
        return RACCommand(signalBlock: {
            (any: AnyObject!) -> RACSignal! in
            return self.coinEnteredSignal
        })
    }

    private func initiateCoinEnteredSignal() -> RACSignal {
        return RACSignal.createSignal {
            (subscriber: RACSubscriber!) -> RACDisposable! in

            self.coinEntryService.coinEntered(self.coinEnteredValue.value) {
                result in
                subscriber.sendNext(result)
                subscriber.sendCompleted()
            }

            return nil
        }
    }

}
