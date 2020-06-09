//
//  MoviesCoordinatorModels.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 04.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

enum MoviesCoordinatorModels {
  enum ViewType {
    case setupSimple
    case setupFull
    
    var modelsFactory: MoviesModelsFactory {
      switch self {
      case .setupSimple: return SimpleMoviesModelsFactory()
      case .setupFull: return FullMoviesModelsFactory()
      }
    }
  }
}
