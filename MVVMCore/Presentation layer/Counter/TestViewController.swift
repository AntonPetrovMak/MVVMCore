//
//  TestViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class TestViewController: BaseViewController, MVVMViewController {
  
  @IBOutlet var countLabel: UILabel!
  @IBOutlet var pushButton: UIButton!
  @IBOutlet var presentButton: UIButton!
  @IBOutlet var clearButton: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  
  var viewModel: TestViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    viewModel.viewDidLoad()
  }
  
  func bind() {
    viewModel.isLoading.observeWithStartingValue(on: self) { [weak self] in self?.setActivityIndicator($0) }
    viewModel.count.observeWithStartingValue(on: self) { [weak self] in self?.countLabel.text = "\($0)" }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  
  // MARK: - Private
  
  private func setActivityIndicator(_ isLoading: Bool) {
    isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
  }
  
  @IBAction func pushButtonTouched() {
    viewModel.pushCounter()
  }
  
  @IBAction func presentButtonTouched() {
    viewModel.presentCounter()
  }
  
  @IBAction func clearButtonTouched() {
    viewModel.clearData()
  }
}
