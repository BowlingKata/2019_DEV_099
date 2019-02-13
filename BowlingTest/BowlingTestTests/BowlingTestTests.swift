//
//  BowlingTestTests.swift
//  BowlingTestTests
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import XCTest
@testable import BowlingTest

class BowlingTestTests: XCTestCase
{

  override func setUp()
  {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }

  override func tearDown()
  {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }

  func testBowlingFrame()
  {
    let frame = BowlingFrame(bowlingFrame: "9-")
    XCTAssert(frame.bonus == .none)
    XCTAssert(frame.pinsKnockedDownAtThrow.reduce(0, +) == 9)
  }

  func testBowlingFrameSpare()
  {
    let frame = BowlingFrame(bowlingFrame: "9/")
    XCTAssert(frame.bonus == .spare)
    XCTAssert(frame.pinsKnockedDownAtThrow.reduce(0, +) == 10)
  }

  func testBowlingFrameStrike()
  {
    let frame = BowlingFrame(bowlingFrame: "X")
    XCTAssert(frame.bonus == .strike)
    XCTAssert(frame.pinsKnockedDownAtThrow.reduce(0, +) == 10)
  }
}
