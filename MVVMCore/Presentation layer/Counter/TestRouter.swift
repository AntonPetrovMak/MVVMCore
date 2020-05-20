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
    let viewModel = TestViewModel(with: self)
    let counterViewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(identifier: "TestViewController") as! TestViewController
    counterViewController.viewModel = viewModel
    baseVC.navigationController?.pushViewController(counterViewController, animated: true)
    baseViewController = baseVC
  }
  
  func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
    guard let context = context as? Context else { return }
    guard let baseViewController = baseViewController else {
      assertionFailure("baseViewController is not set")
      return
    }

    switch context {
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
