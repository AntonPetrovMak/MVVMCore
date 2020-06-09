//
//  MoviesCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesCoordinatorProtocol: Coordinator {
  var router: (MoviesDataPassing & CoordinatorRouting)! { get set }
}

final class MoviesCoordinator: BaseCoordinator, MoviesCoordinatorProtocol {
  var router: (MoviesDataPassing & CoordinatorRouting)!
  
  override func start() {
    router.route(with: window)
  }
}
