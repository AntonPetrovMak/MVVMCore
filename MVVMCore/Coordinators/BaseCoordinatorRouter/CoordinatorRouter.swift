//
//  CoordinatorRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CoordinatorRouting {
  var navigationController: UINavigationController? { get }
  var baseViewController: UIViewController? { get }
  
  func route(with window: UIWindow)
}
