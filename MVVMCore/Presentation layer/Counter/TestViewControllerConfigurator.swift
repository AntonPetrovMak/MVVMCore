//
//  TestViewControllerConfigurator.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct TestViewControllerConfigurator {
  static func configureDefault(router: MVVMRouter) -> TestViewController {
    let viewModel = TestViewModel(with: router)
    let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(identifier: "TestViewController") as! TestViewController
    viewController.viewModel = viewModel
    return viewController
  }
}
