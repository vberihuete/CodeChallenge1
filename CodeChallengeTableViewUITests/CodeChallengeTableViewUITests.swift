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
    
    
    /// Goes to the suggested tab and checks if the down bar appears meaning it was selected
    func testFilterTabSuggested(){
        app.staticTexts["Suggested"].tap()
        XCTAssertTrue(app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
    /// Goes to the viewed tab and checks if the down bar appears meaning it was selected
    func testFilterTabViewed(){
        app.staticTexts["Viewed"].tap()
        XCTAssertTrue(app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
    /// Goes to the Favorites tab and checks if the down bar appears meaning it was selected
    func testFilterTabFavorites(){
        app.staticTexts["Favorites"].tap()
        XCTAssertTrue(app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 2).children(matching: .other).element.children(matching: .other).element.exists)
    }
    
   /// Goes into some of the different view controllers through the tab bar ending in the home one
    func testTabInteraction(){
        
        let tabBarsQuery = app.tabBars
        tabBarsQuery.buttons["My Tickets"].tap()
        tabBarsQuery.buttons["Home"].tap()
        XCTAssert(app.staticTexts["Suggested"].exists, "Navigation to home view controller didn't work")
        
    }
    
}
