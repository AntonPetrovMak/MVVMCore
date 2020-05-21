//
//  MoviesListRouter.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

import UIKit
class MoviesListRouter: MVVMRouter {
  
  enum Context {
    case setupSimple
    case setupFull
  }
  
  weak var baseViewController: UIViewController?
  
  func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    guard let context = context as? Context else { return }
    
    switch context {
    case .setupSimple:
      let moviesViewController = MoviesListControllerConfigurator.configureSimpleMovies(router: self)
      baseVC.navigationController?.pushViewController(moviesViewController, animated: true)
    case .setupFull:
      let moviesViewController = MoviesListControllerConfigurator.configureFullMovies(router: self)
      baseVC.navigationController?.setSecond(second: moviesViewController)
    }
    baseViewController = baseVC
  }
  
  func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?) {
//    guard let context = context as? Context else { return }
//    guard let baseViewController = baseViewController else { return }
  }
  
  func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?) {
    
  }
  
}


extension UINavigationController {
  
  func setFirst(first: UIViewController, animatedDismiss: Bool = true, animatedPush: Bool = true) {
    let setViewControllersCompletion = { self.setViewControllers([first], animated: animatedPush) }
    
    guard let presentedViewController = presentedViewController else {
      setViewControllersCompletion()
      return
    }
    
    presentedViewController.dismiss(animated: animatedDismiss, completion: setViewControllersCompletion)
  }
  
  func setSecond(second: UIViewController, animatedDismiss: Bool = true, animatedPush: Bool = true) {
    guard let first = viewControllers.first else { return }
    let setViewControllersCompletion = { self.setViewControllers([first, second], animated: animatedPush) }
    
    guard let presentedViewController = presentedViewController else {
      setViewControllersCompletion()
      return
    }
    
    presentedViewController.dismiss(animated: animatedDismiss, completion: setViewControllersCompletion)
  }
}
