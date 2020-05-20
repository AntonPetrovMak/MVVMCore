//
//  MainRouter.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/20/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MainRouter: MVVMRouter {
  
  public enum Context {
    case couter
    case simpleMovies
    case fullMovies
  }
  
  var baseViewController: UIViewController?
  
  func route(with context: Any?, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
    guard let context = context as? Context else { return }
    guard let baseViewController = baseViewController else { return }
    
    switch context {
    case .couter:
      let counterRouter = TestRouter()
      counterRouter.present(on: baseViewController)
    case .simpleMovies:
      let context = MoviesListRouter.Context.setupSimple
      let moviesRouter = MoviesListRouter()
      moviesRouter.present(on: baseViewController, animated: true, context: context)
    case .fullMovies:
      let context = MoviesListRouter.Context.setupFull
      let moviesRouter = MoviesListRouter()
      moviesRouter.present(on: baseViewController, animated: true, context: context)
    }
  }
  
}
