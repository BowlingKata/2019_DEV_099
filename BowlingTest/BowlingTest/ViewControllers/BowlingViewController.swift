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

  private var viewModel: BowlingViewModel = BowlingViewModel()

  override func viewDidLoad()
  {
    super.viewDidLoad()
    inputTextField.delegate = self

    setViewModelCallbacks()
  }

  private func setViewModelCallbacks()
  {
    viewModel.bowlingResultCallback = { [weak self] score in
      guard let strongSelf = self else { return }
      strongSelf.resultLabel.text = String(score)
    }

    viewModel.bowlingInputNotValidCallback = { [weak self] in
      guard let strongSelf = self else { return }
      strongSelf.forecastCallFailed()
    }
  }

  @IBAction func calculateButtonAction(_ sender: UIButton)
  {
    if let input = inputTextField.text
    {
      viewModel.bowlingResultsSubmitted(results: input)
    }
  }

  func forecastCallFailed()
  {
    let alertController = UIAlertController(title: "Error", message:
      "Input provided was not valid", preferredStyle: UIAlertController.Style.alert)
    alertController.addAction(UIAlertAction(title: "Close", style: UIAlertAction.Style.default,handler: nil))

    self.present(alertController, animated: true, completion: nil)
  }
}

extension BowlingViewController: UITextFieldDelegate
{
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    if let input = textField.text
    {
      viewModel.bowlingResultsSubmitted(results: input)
    }
    return textField.resignFirstResponder()
  }
}
