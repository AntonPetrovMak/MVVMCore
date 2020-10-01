//
//  CounterViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol CounterViewModelInput {
  func viewDidLoad()
  func viewWillAppear()
  func clearData()
  func pushCounter()
  func presentCounter()
}

protocol CounterViewModelOutput: BaseViewModelOutput {
  var isDismissButtonHidden: Bool { get }
  
  var count: Observable<Int> { get }
}

protocol CounterViewModelProtocol: CounterViewModelInput, CounterViewModelOutput { }

class CounterViewModel: CounterViewModelProtocol {
  
  // MARK: - MVVMViewModel
  
  
  var isDismissButtonHidden: Bool
  let router: CounterRoutingLogic
  
  init(with router: CounterRoutingLogic, isDismissButtonHidden: Bool) {
    self.router = router
    self.isDismissButtonHidden = isDismissButtonHidden
  }
  
  // MARK: - CounterViewModelOutput
  
  var count: Observable<Int> = Observable(0)
  var isLoading: Observable<Bool> = Observable(false)
  var error: Observable<String?> = Observable(nil)
  
  // MARK: - CounterViewModelInput
  
  func viewDidLoad() {
    
  }
  
  func viewWillAppear() {
    
  }
  
  func clearData() {
    isLoading.value = true
    DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
      DispatchQueue.main.async {
        self.isLoading.value = false
        self.count.value = 0
      }
    }
  }
  
  func pushCounter() {
    router.routeToDetails(with: .pushForward(count: count.value, didChangeCount: { [weak self] newCount in
      self?.count.value = newCount
    }))
  }
  
  func presentCounter() {
    router.routeToDetails(with: .presentForward(count: count.value, didChangeCount: { [weak self] newCount in
      self?.count.value = newCount
    }))
  }
  
  deinit {
    print(#function + "\(String(describing: self))")
  }
}
