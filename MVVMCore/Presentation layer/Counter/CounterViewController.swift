//
//  CounterViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class CounterViewController: BaseViewController {
  
  @IBOutlet var countLabel: UILabel!
  @IBOutlet var pushButton: UIButton!
  @IBOutlet var presentButton: UIButton!
  @IBOutlet var clearButton: UIButton!
  @IBOutlet var activityIndicator: UIActivityIndicatorView!
  @IBOutlet var dismissButton: UIButton!
  
  var viewModel: CounterViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bind()
    viewModel.viewDidLoad()
    dismissButton.isHidden = viewModel.isDismissButtonHidden
  }
  
  func bind() {
    viewModel.isLoading.observeWithStartingValue(on: self) { [weak self] in self?.setActivityIndicator($0) }
    viewModel.count.observeWithStartingValue(on: self) { [weak self] in self?.countLabel.text = "\($0)" }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
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
  
  @IBAction func dismissButtonTapped() {
    dismiss(animated: true, completion: nil)
    //viewModel.didSelectDismissButton()
  }
  
  deinit {
    print(#function + "\(String(describing: self))")
  }
}
