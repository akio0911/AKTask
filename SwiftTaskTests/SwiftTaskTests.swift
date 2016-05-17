//
//  SwiftTaskTests.swift
//  SwiftTaskTests
//
//  Created by akio0911 on 2016/05/17.
//  Copyright © 2016年 akio0911. All rights reserved.
//

import XCTest
import SwiftTask
import Async

class SwiftTaskTests: _TestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        typealias Task = SwiftTask.Task<Float, String, ErrorString>
        
        let expect = self.expectationWithDescription(#function)
        
        // define task
        let task = Task { progress, fulfill, reject, configure in
            
            Async.main(after: 0.1) {
                progress(0.0)
                progress(1.0)
                
                if arc4random_uniform(2) == 0 {
                    fulfill("OK")
                }
                else {
                    reject("ERROR")
                }
            }
            return
            
        }
        
        task.progress { oldProgress, newProgress in
            
            print("progress = \(newProgress)")
            
            }.success { value -> String in
                
                XCTAssertEqual(value, "OK")
                return "Now OK"
                
            }.failure { error, isCancelled -> String in
                
                XCTAssertEqual(error!, "ERROR")
                return "Now RECOVERED"
                
            }.then { value, errorInfo -> Task in
                
                print("value = \(value)")
                
                XCTAssertTrue(value!.hasPrefix("Now"))
                XCTAssertTrue(errorInfo == nil)
                
                return Task(error: "ABORT")
                
            }.then { value, errorInfo -> Void in
                
                print("errorInfo = \(errorInfo)")
                
                XCTAssertTrue(value == nil)
                XCTAssertEqual(errorInfo!.error!, "ABORT")
                expect.fulfill()
        }
        
        self.wait()
    }
}
