//
//  TestDetailsViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class TestDetailsViewController: BaseViewController, MVVMViewController {
  
  @IBOutlet var countLabel: UILabel!
  @IBOutlet var dismissButton: UIButton!
  
  var viewModel: TestDetailsViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    dismissButton.isHidden = viewModel.isDismissButtonHidden
  }
  
  private func bind() {
    viewModel.count.observeWithStartingValue(on: self) { [weak self] in self?.countLabel.text = "\($0)" }
  }
  
  // MARK: - Actions
  
  @IBAction func increaseButton() {
    viewModel.increaseCounter()
  }
  
  @IBAction func decreaseButton() {
    viewModel.decreaseCounter()
  }
  
  @IBAction func disnissButton() {
    viewModel.didSelectDismissButton()
  }
}
