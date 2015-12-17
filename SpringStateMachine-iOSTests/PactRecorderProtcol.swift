//
//  PactRecorderProtcol.swift
//  SpringStateMachine-iOS
//
//  Created by Deline Neo on 17/12/2015.
//  Copyright © 2015 Deline Neo. All rights reserved.
//

import Foundation

class PactRecorderProtcol: NSURLProtocol {
    override class func canInitWithRequest(request: NSURLRequest) -> Bool {
        print("HELLO")
        return false
    }
}