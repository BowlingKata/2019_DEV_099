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

  func testBowlingPerfectScore()
  {
    let s = "X X X X X X X X X X X X" // 300
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 300)
  }

  func testBowlingAllSpareScores()
  {
    let s = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5" // -> 150
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 150)
  }

  func testBowlingNoSpareAndNoStrikes()
  {
    let s = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-" // 90
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 90)
  }

  func testBowlingAllFails()
  {
    let s = "-- -- -- -- -- -- -- -- -- --" // 90
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 0)
  }

  func testBowlingWithLastStrike()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -9 X 53" // 105
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 105)
  }

  func testBowlingWithLastSpareAndNullThrow()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -9 32 5/-" // 105
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 94)
  }

  func testBowlingWithLastStrikeAndNullBonus()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -2 32 X--" // 105
    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(s)
    XCTAssert(score == 87)
  }

  func testViewModel()
  {
    var viewModel: BowlingViewModel = BowlingViewModel()
    let s = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-" // 90

    viewModel.bowlingResultCallback = { score in
      XCTAssert(score == 90)
    }

    viewModel.bowlingResultsSubmitted(results: s)
  }

  func testPositiveCharacterSetInput()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -2 32 X--" // 105
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testPositiveCharacterPerfectInput()
  {
    let s = "X X X X X X X X X X X X" // 300
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testBowlingAllSpareScoresInput()
  {
    let s = "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5" // -> 150
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testNegativeInputValidator()
  {
    let s = "7/ 4/ h5 X 7/ 12 -1 -2 32 X--" // this is not a valid input
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(!isValid)
  }

  func testBowlingNoSpareAndNoStrikesInput()
  {
    let s = "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-" // 90
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testBowlingAllFailsInput()
  {
    let s = "-- -- -- -- -- -- -- -- -- --" // 90
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testBowlingWithLastStrikeInput()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -9 X 53" // 105
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testBowlingWithLastSpareAndNullThrowInput()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -9 32 5/-" // 105
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testBowlingWithLastStrikeAndNullBonusInput()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -2 32 X--" // 105
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(isValid)
  }

  func testBowlingWIthMissingLastThrow()
  {
    let s = "7/ 4/ 35 X 7/ 12 -1 -2 32 9" // 105
    let isValid = BowlingGameInputValidator.validateBowlingGameInput(s)
    XCTAssert(!isValid)
  }
}
