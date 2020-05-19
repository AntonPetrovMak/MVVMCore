//
//  TestDetailsViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol TestDetailsViewModelDelegate: class {
  func countedDidChanged(_ count: Int)
}

protocol TestDetailsViewModelInput {
  func increaseCounter()
  func decreaseCounter()
  func didSelectDismissButton()
}

protocol TestDetailsViewModelOutput {
  var count: Observable<Int> { get }
}

protocol TestDetailsViewModelProtocol: TestDetailsViewModelInput, TestDetailsViewModelOutput, MVVMViewModel { }

class TestDetailsViewModel: TestDetailsViewModelProtocol {
  
  // MARK: - MVVMViewModel
  
  var router: MVVMRouter
  weak var delegate: TestDetailsViewModelDelegate?
  
  init(with router: MVVMRouter, count: Int, delegate: TestDetailsViewModelDelegate? = nil) {
    self.router = router
    self.count = Observable(count)
    self.delegate = delegate
  }
  
  // MARK: - TestDetailsViewModelOutput
  
  var count: Observable<Int>
  
  // MARK: - TestViewModelInput
  
  func increaseCounter() {
    count.value = count.value + 1
    delegate?.countedDidChanged(count.value)
  }
  
  func decreaseCounter() {
    count.value = count.value - 1
    delegate?.countedDidChanged(count.value)
  }
  
  func didSelectDismissButton() {
    router.dismiss(animated: true, context: nil, completion: nil)
  }
}
