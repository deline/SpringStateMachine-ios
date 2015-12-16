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

    static private let fiftyCents = NSDecimalNumber(double: 0.5)
    static private let oneDollar = NSDecimalNumber.one()

    private let viewModel: CoinEntryViewModel

    required init?(coder aDecoder: NSCoder) {
        viewModel = CoinEntryViewModel(coinEntryService: CoinEntryService());
        super.init(coder: aDecoder)
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        fiftyCentButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext {
            _ in
            self.viewModel.coinEnteredValue.value = ViewController.fiftyCents
        }

        oneDollarButton.rac_signalForControlEvents(UIControlEvents.TouchUpInside).subscribeNext {
            _ in
            self.viewModel.coinEnteredValue.value = ViewController.oneDollar
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

