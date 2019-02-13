//
//  BowlingGameInputValidator.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import Foundation

struct BowlingGameInputValidator
{
  static let validSetForInputString = "123456789-/X "
  static let validSetForFrame = "123456789-/X"

  static let firstNineRegex = ["^X$", "^[0-9]\\/$", "^-\\/$", "^[0-9]{2}$", "^[0-9]-$", "^-[0-9]$", "^--$"]
  static let regexForLastFrame = ["^X{3}$", "^X[0-9]{2}", "X--$", "^X[0-9]-$", "^X-[0-9]$", "^[0-9]\\/-$",
                                  "^[0-9]\\/[0-9]$", "^[0-9]-$", "^[0-9]{2}", "^-[0-9]$", "^--$"]

  static func validateBowlingGameInput(_ input: String) -> Bool
  {
    return inputContainsValidCharsacters(input, validSet: BowlingGameInputValidator.validSetForInputString) &&
      splittedStringIsInValidFormat(input)
  }

  private static func splittedStringIsInValidFormat(_ input: String) -> Bool
  {
    let splittedString = BowlingScoreCalculator.spliStringInFrames(frames: input)

    guard (10...13).contains(splittedString.count) else
    {
      return false
    }

    guard splittedString.all(matching: {
      inputContainsValidCharsacters($0, validSet: BowlingGameInputValidator.validSetForFrame)
    })
      else
    {
      return false
    }

    let firstNineFrames = Array(splittedString[...8])
    let lastAndBonusFrames = Array(splittedString[9...])

    guard formatOfEachFrameIsValid(firstNineFrames: firstNineFrames, lastAndBonusFrames: lastAndBonusFrames)
      else
    {
      return false
    }

    return true
  }

  private static func formatOfEachFrameIsValid(firstNineFrames: [String], lastAndBonusFrames: [String]) -> Bool
  {
    guard firstNineFramesHasValidFormat(firstNineFrames)
      else
    {
      return false
    }

    guard lastFrameAndBonusesIsInValidFormat(lastAndBonusFrames)
      else
    {
      return false
    }

    return true
  }

  private static func inputContainsValidCharsacters(_ input: String, validSet: String) -> Bool
  {
    let charset = CharacterSet(charactersIn: validSet)
    return input.all(matching: {
      String($0).rangeOfCharacter(from: charset) != nil
    })
  }

  private static func firstNineFramesHasValidFormat(_ frames: [String]) -> Bool
  {
    return allFramesMatchRegexes(frames: frames,
                                 regexes: BowlingGameInputValidator.firstNineRegex,
                                 matcAnyRegex: framesMatchRegex(frame:regexs:))
  }

  private static func lastFrameAndBonusesIsInValidFormat(_ frames: [String]) -> Bool
  {
    let frameUnited = frames.joined().replacingOccurrences(of: " ", with: "")
    return framesMatchRegex(frame: frameUnited, regexs: BowlingGameInputValidator.regexForLastFrame)
  }

  private static func framesMatchRegex(frame: String, regexs: [String]) -> Bool
  {
    return regexs.filter{ frame.matchRegex(regex: $0) }.count > 0
  }

  private static func allFramesMatchRegexes(frames: [String],
                                            regexes: [String],
                                            matcAnyRegex: ((String, [String]) -> Bool)) -> Bool
  {
    return frames.all(matching:{ matcAnyRegex($0, regexes) })
  }
}
