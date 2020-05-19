//
//  TestViewModel.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol TestViewModelInput {
  func viewDidLoad()
  func viewWillAppear()
  func clearData()
  func pushCounter()
  func presentCounter()
}

protocol TestViewModelOutput: BaseViewModelOutput {
  var count: Observable<Int> { get }
}

protocol TestViewModelProtocol: TestViewModelInput, TestViewModelOutput, MVVMViewModel { }

class TestViewModel: TestViewModelProtocol {
  
  // MARK: - MVVMViewModel
  
  var router: MVVMRouter
  
  init(with router: MVVMRouter, worker: Any?, factory: Any?) {
    self.router = router
    self.worker = worker
    self.factory = factory
  }
  
  // MARK: - Private
  
  private var worker: Any?
  private var factory: Any?
  
  // MARK: - TestViewModelOutput
  
  var count: Observable<Int> = Observable(0)
  var isLoading: Observable<Bool> = Observable(false)
  var error: Observable<String?> = Observable(nil)
  
  // MARK: - TestViewModelInput
  
  func viewDidLoad() {
    print("TestViewModel: viewDidLoad")
  }
  
  func viewWillAppear() {
    print("TestViewModel: viewWillAppear")
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
    let context = TestRouter.Context.pushForward(count: count)
    router.route(with: context)
  }
  
  func presentCounter() {
    let context = TestRouter.Context.presentForward(count: count)
    router.route(with: context)
  }
}
