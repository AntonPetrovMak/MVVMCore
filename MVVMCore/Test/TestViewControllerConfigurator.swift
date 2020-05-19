//
//  TestViewControllerConfigurator.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

struct TestViewControllerConfigurator {
  static func configureDefault() -> TestViewController {
    let router = TestRouter()
    let worker: Any? = nil
    let factory: Any? = nil
    let viewModel = TestViewModel(with: router, worker: worker, factory: factory)
    let viewController = TestViewController()
    router.baseViewController = viewController
    viewController.viewModel = viewModel
    return viewController
  }
}
