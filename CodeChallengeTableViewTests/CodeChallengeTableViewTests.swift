//
//  CodeChallengeTableViewTests.swift
//  CodeChallengeTableViewTests
//
//  Created by Vincent Berihuete on 9/1/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import XCTest
@testable import CodeChallengeTableView

class CodeChallengeTableViewTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    
    /// This test runs the events load and see if a statusCode of 200 is given
    func testEventLoad(){
        let promise = expectation(description: "Status code: 200")
        EventConfigurator.shared.loadEvents{ events, statusCode in
            guard let code = statusCode, code == 200 else{
                XCTFail("Error while doing the request statusCode \(statusCode ?? 0)")
                promise.fulfill()
                return
            }
            promise.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}
