//
//  MoviesListWorker.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol MoviesListWorkerProtocol {
  func loadMoviesList(completion: @escaping (Result<[Movie], Error>) -> ())
}

struct MoviesListWorker: MoviesListWorkerProtocol {
  
  let store: MoviesListStoreProtocol
  let serverName = "ServerName"
  
  func loadMoviesList(completion: @escaping (Result<[Movie], Error>) -> ()) {
    store.loadMoviesList(serverName: serverName, completion: completion)
  }
}



