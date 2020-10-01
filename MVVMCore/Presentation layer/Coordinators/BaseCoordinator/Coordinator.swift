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
  
  var parentCoordinator: Coordinator? { get set }
  
  var childCoordinators: [UUID: WeakCoordinator] { get }
  
  /// NavigationController for coordinator, navigation which used for navigation
  var navigationController: UINavigationController { get }
  
  /// Present coordinator
  func start()
  
  /// Present child coordinator
  /// - Parameters:
  ///   - coordinator: child coordinator
  func start(coordinator: Coordinator)
  
  /// Remove coordinator from stack
  func stop()
  
  /// Remove child coordinator by id
  func removeChild(by id: UUID)
  
}

class WeakCoordinator {
  weak var coordinator: Coordinator?
  
  init(coordinator: Coordinator) {
    self.coordinator = coordinator
  }
}
