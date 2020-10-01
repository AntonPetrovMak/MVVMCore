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
  func didSelectRootButton()
}

protocol TestDetailsViewModelOutput {
  var count: Observable<Int> { get }
}

protocol TestDetailsViewModelProtocol: TestDetailsViewModelInput, TestDetailsViewModelOutput { }

protocol CounterDetailsRoutingLogic {
  func routeToRoot()
}

class TestDetailsViewModel: TestDetailsViewModelProtocol {
  
  // MARK: - MVVMViewModel
  
  let router: CounterDetailsRoutingLogic
  
  // MARK: - TestDetailsViewModelOutput
  
  let count: Observable<Int>
  
  // MARK: - TestViewModelInput
  
  let isDismissButtonHidden: Bool
  
  init(with router: CounterDetailsRoutingLogic,
        count: Observable<Int>,
        isDismissButtonHidden: Bool) {
     self.router = router
     self.count = count
     self.isDismissButtonHidden = isDismissButtonHidden
   }
  
  func increaseCounter() {
    count.value = count.value + 1
  }
  
  func decreaseCounter() {
    count.value = count.value - 1
  }
  
  func didSelectRootButton() {
    router.routeToRoot()
  }
  
  deinit {
    print(#function + "\(String(describing: self))")
  }
}
