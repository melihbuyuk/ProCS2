//
//  ProCS2UITests.swift
//  ProCS2UITests
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import XCTest
@testable import ProCS2

class ProCS2UITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }

    override func tearDown() {
        
    }

    func testLike() {
        let collView = app.collectionViews["coll--main"]
        XCTAssertTrue(collView.exists)
        sleep(2)
        
        app.swipeUp()
        sleep(2)
        
        let cellFirst = collView.cells.element(boundBy: 3)
        XCTAssertTrue(cellFirst.exists)
        cellFirst.tap()
        sleep(2)
        
        let btnLike = app.buttons["btn--like"]
        XCTAssertTrue(btnLike.exists)
        btnLike.tap()
        sleep(2)
        
        let btnClose = app.buttons["btn--close"]
        XCTAssertTrue(btnClose.exists)
        btnClose.tap()
        sleep(2)
    }
}
