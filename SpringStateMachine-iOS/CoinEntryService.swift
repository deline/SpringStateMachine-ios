//
// Created by Deline Neo on 4/11/2015.
// Copyright (c) 2015 Deline Neo. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class CoinEntryService {
    func coinEntered(coinValue: NSDecimalNumber, completion: ((result: CoinEnteredResult?) -> Void)) {
        
        Alamofire.request(.GET, "http://localhost:8080").responseJSON {
            response in

            var coinEnteredResult: CoinEnteredResult?
            if let JSON = response.result.value {
                
                let amountEnteredSoFar = NSDecimalNumber(double: JSON.valueForKey("amountEnteredSoFar") as! Double)
                let enoughFundsEntered = JSON.valueForKey("enoughFundsEntered") as! Bool
                
                coinEnteredResult = CoinEnteredResult(
                    amountEnteredSoFar: amountEnteredSoFar,
                    enoughFundsEntered: enoughFundsEntered)
            }
            completion(result: coinEnteredResult)
        }

    }
}
