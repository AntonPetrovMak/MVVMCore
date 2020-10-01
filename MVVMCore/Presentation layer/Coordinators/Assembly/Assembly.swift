//
//  Assembly.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 04.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CoordinatorAssembly {
  
  func makeMainCoordinator(with navigation: UINavigationController?) -> Coordinator
  func makeCounterCoordinator(with navigation: UINavigationController?, modalView: Bool) -> Coordinator
  func makeMoviesCoordinator(with navigation: UINavigationController?, moviesModelsFactory: MoviesModelsFactory) -> Coordinator
  
}
