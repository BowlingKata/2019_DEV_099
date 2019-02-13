//
//  BowlingViewModel.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import Foundation
typealias BowlingResultCallback = ((Int) -> Void)

struct BowlingViewModel
{
  var bowlingResultCallback: BowlingResultCallback?
  var bowlingInputNotValidCallback: (() -> Void)?

  func bowlingResultsSubmitted(results: String)
  {
    guard BowlingGameInputValidator.validateBowlingGameInput(results)
    else
    {
      bowlingInputNotValidCallback?()
      return
    }

    let score = BowlingScoreCalculator.calculateGameScoreFromFramesString(results)
    bowlingResultCallback?(score)
  }
}
