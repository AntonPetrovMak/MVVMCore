//
//  BaseCoordinatorRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class BaseCoordinatorRouter: NSObject, CoordinatorRouting {
  weak var window: UIWindow?
  weak var navigationController: UINavigationController?
  weak var baseViewController: UIViewController?
  
  func route(with window: UIWindow) {
    self.window = window
    (window.rootViewController as? UINavigationController).map {
      navigationController = $0
      baseViewController = $0.viewControllers.first
    }
  }
}
