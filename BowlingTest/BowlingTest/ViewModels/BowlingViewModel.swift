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

  func bowlingResultsSubmitted(results: String)
  {
    // TODO Add here call to the logic to display something later
  }
}
