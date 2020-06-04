//
//  CounterCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CounterCoordinatorProtocol: Coordinator {
  var router: (CounterDataPassing & CoordinatorRouting)! { get set }
}

final class CounterCoordinator: BaseCoordinator, CounterCoordinatorProtocol {
  var router: (CounterDataPassing & CoordinatorRouting)!
  
  override func start() {
    router.route(with: window)
  }
}
