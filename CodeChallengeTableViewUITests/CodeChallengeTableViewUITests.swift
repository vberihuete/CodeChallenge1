//
//  CodeChallengeTableViewUITests.swift
//  CodeChallengeTableViewUITests
//
//  Created by Vincent Berihuete on 9/1/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import XCTest

class CodeChallengeTableViewUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        app = XCUIApplication()
//        continueAfterFailure = false
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTabSuggested(){
        app.staticTexts["Suggested"].tap()
        XCTAssertTrue(app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
    func testTabViewed(){
        app.staticTexts["Viewed"].tap()
        XCTAssertTrue(app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
    func testTabFavorites(){
        app.staticTexts["Favorites"].tap()
        XCTAssertTrue(app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
   
    
//    func testFilterTab(){
//
//        executeTestTabViewed()
//        executeTestTabFavorites()
//        executeTestTabSuggested()
//
//
//
//    }
    
}
