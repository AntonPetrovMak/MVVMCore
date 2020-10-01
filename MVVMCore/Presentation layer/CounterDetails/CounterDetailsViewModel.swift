//
//  CounterDetailsViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol CounterDetailsViewModelInput {
  var isDismissButtonHidden: Bool { get }
  
  func increaseCounter()
  func decreaseCounter()
  func didSelectRootButton()
}

protocol CounterDetailsViewModelOutput {
  var count: Observable<Int> { get }
}

protocol CounterDetailsViewModelProtocol: CounterDetailsViewModelInput, CounterDetailsViewModelOutput { }

protocol CounterDetailsRoutingLogic {
  func routeToRoot()
}

class CounterDetailsViewModel: CounterDetailsViewModelProtocol {
  
  // MARK: - MVVMViewModel
  
  let router: CounterDetailsRoutingLogic
  
  // MARK: - CounterDetailsViewModelOutput
  
  let count: Observable<Int>
  
  // MARK: - CounterViewModelInput
  
  let isDismissButtonHidden: Bool
  
  private var didChangeCount: ((Int) -> Void)?
  
  init(with router: CounterDetailsRoutingLogic,
       count: Int,
       isDismissButtonHidden: Bool,
       didChangeCount: ((Int) -> Void)?) {
    self.router = router
    self.count = Observable(count)
    self.isDismissButtonHidden = isDismissButtonHidden
    self.didChangeCount = didChangeCount
  }
  
  func increaseCounter() {
    count.value = count.value + 1
    didChangeCount?(count.value)
  }
  
  func decreaseCounter() {
    count.value = count.value - 1
    didChangeCount?(count.value)
  }
  
  func didSelectRootButton() {
    router.routeToRoot()
  }
  
  deinit {
    print(#function + "\(String(describing: self))")
  }
}
