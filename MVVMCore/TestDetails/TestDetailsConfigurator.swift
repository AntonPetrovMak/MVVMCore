//
//  TestDetailsConfigurator.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit


struct TestDetailsConfigurator {
  static func configureFromStoryboard(with count: Observable<Int>) -> TestDetailsViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(identifier: "TestDetailsViewController") as! TestDetailsViewController
    
    let router = TestDetailsRouter()
    let viewModel = TestDetailsViewModel(with: router, count: count)
    viewController.viewModel = viewModel
    return viewController
  }
}
