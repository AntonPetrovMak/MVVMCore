//
//  MoviesCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesCoordinatorProtocol: Coordinator { }

class MoviesCoordinator: BaseCoordinator, MoviesCoordinatorProtocol {
  var router: BaseRouter!
  
  override func start() {
    router.route(with: window)
  }
}
