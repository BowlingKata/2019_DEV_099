//
//  BowlingViewController.swift
//  BowlingTest
//
//  Created by on 13/02/2019.
//  Copyright © 2019 --. All rights reserved.
//

import UIKit

class BowlingViewController: UIViewController
{
  @IBOutlet weak var inputTextField: UITextField!
  @IBOutlet weak var resultLabel: UILabel!

  override func viewDidLoad()
  {
    super.viewDidLoad()
    inputTextField.delegate = self
  }

  @IBAction func calculateButtonAction(_ sender: UIButton)
  {

  }
}

extension BowlingViewController: UITextFieldDelegate
{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    // TODO: call view model here
    return textField.resignFirstResponder()
  }
}
