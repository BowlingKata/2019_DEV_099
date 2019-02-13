//
//  String+Regex.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import Foundation

extension String
{
  public func matchRegex(regex: String) -> Bool
  {
   return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
  }
}
