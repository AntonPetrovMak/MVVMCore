//
//  MainCoordinatorFactory.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MainCoordinatorFactoryProtocol {
  func makeMainController(with router: MainRoutingLogic) -> UINavigationController
}

final class MainCoordinatorFactory: MainCoordinatorFactoryProtocol {
  func makeMainController(with router: MainRoutingLogic) -> UINavigationController {
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController") as! MainViewController
    let viewModel = MainViewModel(router: router)
    viewController.viewModel = viewModel
    return UINavigationController(rootViewController: viewController)
  }
}
