//
//  Coordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol Coordinator: class {
  
  var id: UUID { get }
  
  /// Reference on the parent coordinator
  var parentCoordinator: Coordinator? { get set }
  
  /// References on the child coordinators
  var childCoordinators: [UUID: WeakCoordinator] { get }
  
  /// `navigationController` in which all navigation for the current coordination takes place
  var navigationController: UINavigationController? { get }
  
  /// This method in which describe an implementation of how to present screen
  /// - Parameters:
  ///   - style: determinate how would be presented coordinator
  ///   - animated: animated
  func start(style: CoordinatorPresentationStyle, animated: Bool)
  
  /// Present child coordinator
  /// - Parameters:
  ///   - coordinator: child coordinator
  ///   - style: determinate how would be presented coordinator
  ///   - animated: animated
  func start(coordinator: Coordinator, style: CoordinatorPresentationStyle, animated: Bool)
  
  /// Pop coordinator from stack. Removing the dependency for a parent and child coordinators
  func stop()
  
  /// Remove child coordinator by id
  func removeChild(by id: UUID)
  
}

enum CoordinatorPresentationStyle {
  
  /// `custom` case using for custom presentation coordinator, in this case needs to override `start` method and describe needed presentation
  case custom
  
  /// `custom` case added a ViewController in the root of the navigation stack
  case setRoot
  
  /// `push` case added a ViewController in the end of the navigation stack
  case push
  
  /// `presentSecondarySteck` case presents a ViewController in the new navigation, create new NavigationController with ViewController and present NavigationController
  case presentSecondarySteck
}

// MARK: - WeakCoordinator

class WeakCoordinator {
  weak var coordinator: Coordinator?
  
  init(coordinator: Coordinator) {
    self.coordinator = coordinator
  }
}

// MARK: - Added a precondition value of animated

extension Coordinator {
  
  func start(style: CoordinatorPresentationStyle, animated: Bool = true) {
    start(style: style, animated: animated)
  }
  
  func start(coordinator: Coordinator, style: CoordinatorPresentationStyle, animated: Bool = true) {
    start(coordinator: coordinator, style: style, animated: animated)
  }
  
}
