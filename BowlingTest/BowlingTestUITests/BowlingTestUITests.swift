//
//  BowlingTestUITests.swift
//  BowlingTestUITests
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import XCTest

class BowlingTestUITests: XCTestCase
{
  var app: XCUIApplication!

  override func setUp()
  {
    // Put setup code here. This method is called before the invocation of each test method in the class.

    // In UI tests it is usually best to stop immediately when a failure occurs.
    continueAfterFailure = false

    app = XCUIApplication()
    app.launch()
  }

  override func tearDown() {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testValidInput()
  {
    // Use recording to get started writing UI tests.
    // Use XCTAssert and related functions to verify your tests produce the correct results.

    let nameTextField = app.textFields["inputField"]
    nameTextField.tap()
    nameTextField.typeText("X X X X X X X X X X X X")

    app.buttons["Calculate"]/*@START_MENU_TOKEN@*/.tap()/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/

    XCTAssert(XCUIApplication().staticTexts["300"].exists)
  }

  func testNotValidInput()
  {
    let nameTextField = app.textFields["inputField"]
    nameTextField.tap()
    nameTextField.typeText("X X X X X X X X X")

    app.buttons["Calculate"]/*@START_MENU_TOKEN@*/.tap()/*[[".tap()",".press(forDuration: 0.5);"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/

    XCTAssert(app.alerts["Error"].buttons["Close"].exists)
  }
}
