//
//  MVVMRouter.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation
import UIKit

/// The protocol for the router in MVVM+Router architecture
protocol MVVMRouter {
  
  /// The view controller which is used to present the current one
  var baseViewController: UIViewController? { get set }
  
  
  /// This method should be used as an entry point for presenting the VC for particular router
  ///
  /// - Parameters:
  ///   - baseVC: the base VC
  ///   - animated: animated presenting or not
  ///   - context: optional context
  ///   - completion: the closure to be invoked in the end of presentation with result (was presented or not)
  func present(on baseVC: UIViewController, animated: Bool, context: Any?, completion: ((Bool) -> Void)?)
  
  /// This method should be used to present next view controller as a result some action
  ///
  /// - Parameters:
  ///   - context: the optional context which may be passed over
  ///   - animated: animated presenting or not
  ///   - completion: the closure to be invoked in the end of presentation with result (was presented or not)
  func route(with context: Any?, animated: Bool, completion: ((Bool) -> Void)?)
  
  /// This method should be used to dismiss from base view controller
  ///
  /// - Parameters:
  ///   - animated: animated presenting or not
  ///   - context: the optional context which may be passed over
  ///   - completion: the closure to be invoked in the end of dismissing with result (was presented or not)
  func dismiss(animated: Bool, context: Any?, completion: ((Bool) -> Void)?)
}

extension MVVMRouter {
  
  /// Convenience method to use default values for parameters, which rarely used
  func present(on baseVC: UIViewController, animated: Bool = true, context: Any? = nil, completion: ((Bool) -> Void)? = nil) {
    self.present(on: baseVC, animated: animated, context: context, completion: completion)
  }
  
  /// Convenience method to use default values for parameters, which rarely used
  func route(with context: Any?, animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
    self.route(with: context, animated: animated, completion: completion)
  }
  
  func dismiss(animated: Bool = true, context: Any? = nil, completion: ((Bool) -> Void)? = nil) {
    self.dismiss(animated: animated, context: context, completion: completion)
  }
}
