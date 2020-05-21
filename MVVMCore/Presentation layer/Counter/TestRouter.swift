//
//  TestRouter.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol TestRouterDataSump {
  var fullMoviesObserver: ObservableEmpty? { get set }
}

class TestRouter: MVVMRouter, TestRouterDataSump {
  
  // MARK: TestRouterDataSump
  
  var fullMoviesObserver: ObservableEmpty?
  
  enum Context {
    case setup(fullMoviesObserver: ObservableEmpty)
    case pushForward(count: Observable<Int>)
    case presentForward(count: Observable<Int>)
  }
  
  weak var baseViewController: UIViewController?
  
  func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    guard let context = context as? Context else { return }
    
    switch context {
    case .setup(let fullMoviesObserver):
      self.fullMoviesObserver = fullMoviesObserver
      let viewModel = TestViewModel(with: self, mainFullMoviesObserver: fullMoviesObserver)
      let counterViewController = UIStoryboard(name: "Main", bundle: nil)
        .instantiateViewController(identifier: "TestViewController") as! TestViewController
      counterViewController.viewModel = viewModel
      baseVC.navigationController?.pushViewController(counterViewController, animated: true)
      baseViewController = baseVC
    default: ()
    }
    
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
      let presentationContext = TestDetailsRouter.Context.setup(count: count, isPresentOption: false, fullMoviesObserver: fullMoviesObserver)
      detailsRouter.present(on: baseViewController, context: presentationContext)
    case .presentForward(let count):
      let detailsRouter = TestDetailsRouter()
      let presentationContext = TestDetailsRouter.Context.setup(count: count, isPresentOption: true, fullMoviesObserver: fullMoviesObserver)
      detailsRouter.present(on: baseViewController, context: presentationContext)
    default: ()
    }
  }
  
  func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    
  }
  
}
