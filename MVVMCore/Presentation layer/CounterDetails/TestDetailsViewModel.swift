//
//  TestDetailsViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol TestDetailsViewModelInput {
  var isDismissButtonHidden: Bool { get }
  
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
  
  init(with router: MVVMRouter, count: Observable<Int>, isDismissButtonHidden: Bool) {
    self.router = router
    self.count = count
    self.isDismissButtonHidden = isDismissButtonHidden
  }
  
  // MARK: - TestDetailsViewModelOutput
  
  var count: Observable<Int>
  
  // MARK: - TestViewModelInput
  
  let isDismissButtonHidden: Bool
  
  func increaseCounter() {
    count.value = count.value + 1
  }
  
  func decreaseCounter() {
    count.value = count.value - 1
  }
  
  func didSelectDismissButton() {
    router.dismiss(animated: true, context: nil, completion: nil)
  }
}
