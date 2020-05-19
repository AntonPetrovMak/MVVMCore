//
//  TestRouter.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit
class TestRouter: MVVMRouter {
  
  enum Context {
    case pushForward(count: Observable<Int>)
    case presentForward(count: Observable<Int>)
  }
  
  var baseViewController: UIViewController?
  
  func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    
  }
  
  func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
    guard let route = context as? Context else { return }
    guard let baseViewController = baseViewController else {
      assertionFailure("baseViewController is not set")
      return
    }

    switch route {
    case .pushForward(let count):
      let detailsRouter = TestDetailsRouter()
      let presentationContext = TestDetailsRouter.Context.setup(count: count, isPresentOption: false)
      detailsRouter.present(on: baseViewController, context: presentationContext)
    case .presentForward(let count):
      let detailsRouter = TestDetailsRouter()
      let presentationContext = TestDetailsRouter.Context.setup(count: count, isPresentOption: true)
      detailsRouter.present(on: baseViewController, context: presentationContext)
    }
  }
  
  func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    
  }
  
}
