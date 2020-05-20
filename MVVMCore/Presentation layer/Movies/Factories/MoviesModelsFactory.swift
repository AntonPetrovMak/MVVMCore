//
//  MoviesModelsFactory.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol MoviesModelsFactory {
  var screenTitle: String { get }
  func makeTableViewModel(_ movie: Movie) -> MoviesTableViewModel
}

struct SimpleMoviesModelsFactory: MoviesModelsFactory {
  
  var screenTitle = "Simple View"
  
  func makeTableViewModel(_ movie: Movie) -> MoviesTableViewModel {
    return MoviesTableViewModel(name: movie.name,
                                distributor: movie.distributor,
                                worldwideGross: movie.worldwideGross,
                                nameFont: .boldSystemFont(ofSize: 15),
                                albumColor: nil,
                                description: nil)
  }
}

struct FullMoviesModelsFactory: MoviesModelsFactory {
  
  var screenTitle = "Full View"
  
  func makeTableViewModel(_ movie: Movie) -> MoviesTableViewModel {
    return MoviesTableViewModel(name: movie.name,
                                distributor: movie.distributor,
                                worldwideGross: movie.worldwideGross,
                                nameFont: .boldSystemFont(ofSize: 20),
                                albumColor: movie.albumColor,
                                description: movie.description)
  }
}
