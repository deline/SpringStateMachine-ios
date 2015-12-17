//
//  CoinEntryServiceTest.swift
//  SpringStateMachine-iOS
//
//  Created by Deline Neo on 5/11/2015.
//  Copyright © 2015 Deline Neo. All rights reserved.
//

import XCTest
import OHHTTPStubs
import OHHTTPStubs.Swift
import Nimble
import SwiftyJSON

@testable import SpringStateMachine_iOS
class CoinEntryServiceTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        OHHTTPStubs.removeAllStubs()
    }
    
    func testSubmitsAndProcessesResultFromRemoteService() {
        let service = CoinEntryService()
        let expectedResponse: JSON =  ["amountEnteredSoFar":"2.50", "enoughFundsEntered":false]

        stub(isHost("localhost")) {
            _ in
            return OHHTTPStubsResponse(JSONObject: expectedResponse.rawValue, statusCode: 200, headers: nil)
        }

        var coinEnteredResult: CoinEnteredResult?
        service.coinEntered(NSDecimalNumber.one()) {
            result in
            coinEnteredResult = result
            print("********\(coinEnteredResult?.amountEnteredSoFar)")
            print("********\(coinEnteredResult?.enoughFundsEntered)")
        }
        
        expect(coinEnteredResult).toEventuallyNot(beNil())
        expect(coinEnteredResult?.amountEnteredSoFar).to(equal(NSDecimalNumber(double: 2.5)))
     
    }

}
