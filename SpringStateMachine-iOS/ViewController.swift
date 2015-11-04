//
//  ViewController.swift
//  SpringStateMachine-iOS
//
//  Created by Deline Neo on 3/11/2015.
//  Copyright © 2015 Deline Neo. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ViewController: UIViewController {

    @IBOutlet weak var fiftyCentButton: UIButton!
    @IBOutlet weak var oneDollarButton: UIButton!

    private let viewModel: CoinEntryViewModel;

    
    required init?(coder aDecoder: NSCoder) {
        viewModel = CoinEntryViewModel()

        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()



        fiftyCentButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext {
            _ in
            print("******* HEY ******")
        }

        oneDollarButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext {
            _ in
            self.executeCoinEnteredCommand().execute(nil).subscribeNext({
                print("KICK ME \($0)")
            })
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    private func executeCoinEnteredCommand() -> RACCommand {
        return RACCommand(signalBlock: {
            _ -> RACSignal! in
            return self.coinEnteredSignal()
        })
    }


    private func coinEnteredSignal() -> RACSignal {
        return RACSignal.createSignal({
            (subscriber: RACSubscriber!) -> RACDisposable! in
            print("*** Go and perform coin entry business ***")

            subscriber.sendNext("BOB was here")
            subscriber.sendCompleted()
            return nil
        })
    }


}

