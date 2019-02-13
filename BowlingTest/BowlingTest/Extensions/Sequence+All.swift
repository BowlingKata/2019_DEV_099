//
//  Sequence+All.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import Foundation

extension Sequence
{
  public func all(matching predicate: (Element) -> Bool) -> Bool
  {
    // Every element matches a predicate if no element doens't march it
    return !contains { !predicate($0) }
  }
}
