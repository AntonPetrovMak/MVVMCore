//
//  TestDetailsConfigurator.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

struct TestDetailsConfigurator {
  
  static func configurePresentStyle(router: MVVMRouter, count: Observable<Int>, mainFullMoviesObserver: ObservableEmpty?) -> TestDetailsViewController {
    return configureFromStoryboard(router: router, count: count, isDismissButtonHidden: false, mainFullMoviesObserver: mainFullMoviesObserver)
  }
  
  static func configurePushStyle(router: MVVMRouter, count: Observable<Int>, mainFullMoviesObserver: ObservableEmpty?) -> TestDetailsViewController {
    return configureFromStoryboard(router: router, count: count, isDismissButtonHidden: true, mainFullMoviesObserver: mainFullMoviesObserver)
  }
  
  // MARK: - Private
  
  private static func configureFromStoryboard(router: MVVMRouter,
                                              count: Observable<Int>,
                                              isDismissButtonHidden: Bool,
                                              mainFullMoviesObserver: ObservableEmpty?) -> TestDetailsViewController {
    let viewController = UIStoryboard(name: "Main", bundle: nil)
      .instantiateViewController(identifier: "TestDetailsViewController") as! TestDetailsViewController
    let viewModel = TestDetailsViewModel(with: router, count: count, isDismissButtonHidden: isDismissButtonHidden, mainFullMoviesObserver: mainFullMoviesObserver)
    viewController.viewModel = viewModel
    return viewController
  }
}
