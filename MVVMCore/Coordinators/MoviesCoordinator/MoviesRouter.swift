//
//  MoviesRouter.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 22.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MoviesRouter: BaseRouter {
  weak var coordinator: MoviesCoordinatorProtocol?
  private let factory: MoviesFactoryProtocol
  
  init(factory: MoviesFactoryProtocol) {
    self.factory = factory
  }
}
