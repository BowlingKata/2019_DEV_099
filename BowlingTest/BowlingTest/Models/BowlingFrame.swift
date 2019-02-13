//
//  BowlingFrame.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import Foundation

enum BowlingBonus
{
  case strike
  case spare
  case none
}

struct BowlingFrame
{
  static let maxPinsKnockedInFrame = 10
  static let spareSymbol: Character = "/"
  static let strikeSymbol: Character = "X"
  static let missSymbol: Character = "-"

  let pinsKnockedDownAtThrow: [Int]
  let bonus: BowlingBonus

  init(bowlingFrame: String)
  {
    if bowlingFrame.contains(BowlingFrame.strikeSymbol)
    {
      bonus = .strike
      pinsKnockedDownAtThrow = [10]
    }
    else if bowlingFrame.contains(BowlingFrame.spareSymbol)
    {
      bonus = .spare
      pinsKnockedDownAtThrow = createPinsTakenInFrame(bowlingFrame)
    }
    else
    {
      bonus = .none
      pinsKnockedDownAtThrow = createPinsTakenInFrame(bowlingFrame)
    }
  }
}

fileprivate func createPinsTakenInFrame(_ bowlingFrame: String) -> [Int]
{
  var pinsKnockedDown: [Int] = []
  for c in bowlingFrame
  {
    if let number = Int(String(c))
    {
      pinsKnockedDown.append(number)
    }
    else if c == BowlingFrame.spareSymbol
    {
      // If I have a spare I must have a number before it, this is whty I use the !
      let pinsKnockedToSpare = BowlingFrame.maxPinsKnockedInFrame - pinsKnockedDown.last!
      pinsKnockedDown.append(pinsKnockedToSpare)
    }
    else if c == BowlingFrame.missSymbol
    {
      pinsKnockedDown.append(0)
    }
  }

  return pinsKnockedDown
}
