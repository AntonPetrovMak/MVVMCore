//
//  CoordinatorRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CoordinatorRouting {
  
  /// Navigation controller for Coordinator module
  var navigationController: UINavigationController? { get }
  
  /// Base controller for Coordinator module
  var baseViewController: UIViewController? { get }
  
  /// Present root controller for Coordinator module
  /// - Parameters:
  ///   - window: root window for Coordinator module
  func route(with window: UIWindow)
}
