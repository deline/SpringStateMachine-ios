//
// Created by Deline Neo on 4/11/2015.
// Copyright (c) 2015 Deline Neo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class CoinEntryService {
    func coinEntered(coinValue: NSDecimalNumber, completion: ((result:CoinEnteredResult?) -> Void)) {

        Alamofire.request(.PUT, "http://localhost:8080/coinEntryService/coinEntered", parameters: ["coinValue": coinValue.doubleValue], encoding: .JSON).responseJSON {
            response in

            var coinEnteredResult: CoinEnteredResult?
            if let JSON = response.result.value {

                let amountEnteredSoFar = NSDecimalNumber(string: JSON.valueForKey("amountEnteredSoFar") as? String)
                let enoughFundsEntered = JSON.valueForKey("enoughFundsEntered") as! Bool

                coinEnteredResult = CoinEnteredResult(
                amountEnteredSoFar: amountEnteredSoFar,
                enoughFundsEntered: enoughFundsEntered)
            }
            completion(result: coinEnteredResult)
        }

    }
}
