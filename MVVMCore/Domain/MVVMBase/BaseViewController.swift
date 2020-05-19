//
//  BaseViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  func baseBind(to viewModel: BaseViewModelOutput) {
    viewModel.isLoading.observe(on: self) { [weak self] in self?.loader($0) }
    viewModel.error.observe(on: self) { [weak self] in self?.showError($0) }
  }
  
  // MARK: Handlers
  
  func loader(_ isLoading: Bool) {
    isLoading ? print("Show loader") : print("Hide loader")
  }
  
  func showError(_ message: String?) {
    guard let _message = message else { return }
    print("Show error: \(_message)")
  }
  
}
