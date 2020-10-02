//
//  Assembly.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 04.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

final class BaseCoordinatorAssembly: CoordinatorAssembly {
    
  func makeMainCoordinator(with navigation: UINavigationController?) -> Coordinator {
    let factory = MainCoordinatorFactory()
    let coordinator = MainCoordinator(assembly: self, navigationController: navigation, factory: factory)
    return coordinator
  }
  
  func makeCounterCoordinator(with navigation: UINavigationController?, isDismissButtonHidden: Bool) -> Coordinator {
    let factory = CounterCoordinatorFactory()
    let coordinator = CounterCoordinator(assembly: self,
                                         navigationController: navigation,
                                         factory: factory,
                                         isDismissButtonHidden: isDismissButtonHidden)
    return coordinator
  }
  
  func makeMoviesCoordinator(with navigation: UINavigationController?, moviesModelsFactory: MoviesModelsFactory) -> Coordinator {
    let factory = MoviesCoordinatorFactory()
    let coordinator = MoviesCoordinator(assembly: self,
                                        navigationController: navigation,
                                        factory: factory,
                                        moviesModelsFactory: moviesModelsFactory)
    return coordinator
  }
  
}
