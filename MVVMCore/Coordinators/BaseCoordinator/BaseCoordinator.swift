//
//  BaseCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class BaseCoordinator: Coordinator {
  weak private(set) var parentCoordinator: BaseCoordinator?
  let window: UIWindow
  
  private let id = UUID().uuidString
  private lazy var childCoordinators: Set<BaseCoordinator> = []
  
  init(window: UIWindow) {
    self.window = window
  }
  
  func start() {
    // Must be implemented
  }
  
  func start(coordinator: Coordinator) {
    guard let coordinator = coordinator as? BaseCoordinator else { return }
    childCoordinators.insert(coordinator)
    coordinator.parentCoordinator = self
    coordinator.start()
  }
  
  func stop() {
    childCoordinators.forEach { $0.stop(); $0.parentCoordinator = nil }
    childCoordinators.removeAll()
    parentCoordinator?.childCoordinators.remove(self)
    parentCoordinator = nil
  }
  
  func child<T>(of type: T.Type) -> T? {
    return childCoordinators.first { $0 is T } as? T
  }
}

extension BaseCoordinator: Equatable {
  static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
    return lhs.id == rhs.id
  }
}

extension BaseCoordinator: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(id)
  }
}
