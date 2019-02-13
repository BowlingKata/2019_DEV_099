//
//  BowlingScoreCalculator.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import Foundation

class BowlingScoreCalculator
{
  /// As Kata said input is supposed to be valid and complete
  /// 10 frames plus bonus throws, each frame must have valid input, frames must be separated by space
  /// Examplex of valid inputs
  /// "X X X X X X X X X X X X" -> 300
  /// 7/ 4/ 35 X 7/ 12 -1 -9 X 53" -> 105
  /// "9- 9- 9- 9- 9- 9- 9- 9- 9- 9-" -> 90
  /// "5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/ 5/5" // -> 150
  /// "X X X X X X X X X X33" -> 279
  static func calculateGameScoreFromFramesString(_ framesString: String) -> Int
  {
    let splittedWithBonusFrameSeparated = spliStringInFrames(frames: framesString)
    let frames = createBowlingFrameArray(splittedStringArray: splittedWithBonusFrameSeparated)

    // I want an array of 10 BowlingFrames plus Bonus throws if presents
    return calculateScore(frames: frames)
  }

  private static func spliStringInFrames(frames: String) -> [String]
  {
    let splittedFrames = frames.split(separator: " ").map{String($0)}
    let splittedWithBonusFramesSeparated = splitBonusThrowsFromTenthFrame(frames: splittedFrames)

    return splittedWithBonusFramesSeparated
  }

  /// if the 10th frame is united I want to split it with the strike or spare as the tenth element and the last
  /// two (or one) throws as the last element
  private static func splitBonusThrowsFromTenthFrame(frames: [String]) -> [String]
  {
    // If I have more than ten frames I don't need to check to split the tenth!
    if (frames.count == 10)
    {
      if (frames[9].first == BowlingFrame.strikeSymbol && frames[9].count == 3)
      {
        let tenthFrame = String(BowlingFrame.strikeSymbol)
        let bonusFrame = String(frames[9].dropFirst())

        var framesWithBonusSeparated = Array(frames.dropLast())
        framesWithBonusSeparated.append(tenthFrame)
        framesWithBonusSeparated.append(bonusFrame)
        return framesWithBonusSeparated
      }
      if (frames[9].contains(BowlingFrame.spareSymbol) && frames[9].count == 3)
      {
        let tenthFrame = String(frames[9].dropLast())
        let bonusFrame = String(frames[9].last!)

        var framesWithBonusSeparated = Array(frames.dropLast())
        framesWithBonusSeparated.append(tenthFrame)
        framesWithBonusSeparated.append(bonusFrame)
        return framesWithBonusSeparated
      }
    }
    return frames
  }

  private static func createBowlingFrameArray(splittedStringArray: [String]) -> [BowlingFrame]
  {
    let firstTen = splittedStringArray[...9]
    var frames = firstTen.map { BowlingFrame(bowlingFrame: String($0)) }
    // Depenging on the input I may have the bonus throws
    if splittedStringArray.count > 10
    {
      // If the throws after the tenth are separated I want to join them in a single frame
      let bonusThorws = String(splittedStringArray[10...].joined(separator: "")).replacingOccurrences(of: " ", with: "")
      let lastFrames = createLastFrames(lastThrows: String(bonusThorws))
      frames.append(contentsOf: lastFrames)
    }

    return frames
  }

  private static func createLastFrames(lastThrows: String) -> [BowlingFrame]
  {
    var lastFrames: [BowlingFrame] = []
    if let strikeIndex = lastThrows.firstIndex(of: BowlingFrame.strikeSymbol) // i.e last frame with bonuses is: X53
    {
      lastFrames.append(BowlingFrame(bowlingFrame: String(lastThrows[strikeIndex])))
      lastFrames.append(BowlingFrame(bowlingFrame: String(lastThrows.dropFirst())))
    }
    else if let spareIndex = lastThrows.firstIndex(of: BowlingFrame.spareSymbol) // i.e last frame with bonuses is: 4/6
    {
      lastFrames.append(BowlingFrame(bowlingFrame: String(lastThrows[...spareIndex])))
      lastFrames.append(BowlingFrame(bowlingFrame: String(lastThrows.dropFirst(2))))
    }
    else // no bonuses
    {
      lastFrames.append(BowlingFrame(bowlingFrame: lastThrows))
    }

    return lastFrames
  }

  private static func calculateScore(frames: [BowlingFrame]) -> Int
  {
    assert(frames.count >= 10)

    let roundsBeforeBonusBalls = 10
    var score: Int = 0
    // I need this for for the first tenth elements
    for (bowlingFrame, index) in zip(frames, Array(0...9))
    {
      score += bowlingFrame.pinsKnockedDownAtThrow.reduce(0, +)

      // I sum bonuses for strike or spare only until the 10th frame
      if bowlingFrame.bonus != .none && index < roundsBeforeBonusBalls
      {
        var nextThrowsToTake = 0
        if bowlingFrame.bonus == .strike
        {
          nextThrowsToTake = 2
        }
        else if bowlingFrame.bonus == .spare
        {
          nextThrowsToTake = 1
        }
        let nextFrames = frames[(index + 1)...]
        // I cast it to Array but since it won't be modified it's passed by reference
        score += takeNextThrowsFromNextFrames(Array(nextFrames), throwsToTake: nextThrowsToTake)
      }
    }

    assert(score >= 0 && score <= 300)

    return score
  }

  private static func takeNextThrowsFromNextFrames(_ frames: [BowlingFrame], throwsToTake: Int) -> Int
  {
    var throwsTaken = 0
    var score = 0
    for frame in frames
    {
      for pinsKnockedDown in frame.pinsKnockedDownAtThrow
      {
        score += pinsKnockedDown
        throwsTaken += 1
        if throwsTaken == throwsToTake
        {
          return score
        }
      }
    }
    fatalError("There should always be a throw to take")
  }
}
