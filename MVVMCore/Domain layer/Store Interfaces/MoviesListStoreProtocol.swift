//
//  MoviesListStoreProtocol.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol MoviesListStoreProtocol {
  func loadMoviesList(serverName: String, completion: @escaping (Result<[Movie], Error>) -> ())
}
