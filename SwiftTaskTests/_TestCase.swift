//
//  _TestCase.swift
//  AKTaskApp
//
//  Created by akio0911 on 2016/05/17.
//  Copyright © 2016年 akio0911. All rights reserved.
//

import SwiftTask
import Async
import XCTest

typealias ErrorString = String

class _TestCase: XCTestCase
{
    override func setUp()
    {
        super.setUp()
        print("\n\n\n")
    }
    
    override func tearDown()
    {
        print("\n\n\n")
        super.tearDown()
    }
    
    func wait(timeout: NSTimeInterval = 3)
    {
        self.waitForExpectationsWithTimeout(timeout) { error in
            print("wait error = \(error)")
        }
    }
    
    var isAsync: Bool { return false }
    
    func perform(closure: Void -> Void)
    {
        if self.isAsync {
            Async.main(after: 0.01, block: closure)
        }
        else {
            closure()
        }
    }
}
