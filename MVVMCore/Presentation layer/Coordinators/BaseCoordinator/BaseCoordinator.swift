//
//  BaseCoordinator.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 21.05.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class BaseCoordinator<FactoryType>: NSObject, Coordinator {
  
  let assembly: CoordinatorAssembly
  
  let factory: FactoryType
  
  weak var parentCoordinator: Coordinator?
  
  var navigationController: UINavigationController
  
  var id = UUID()
  
  var childCoordinators: [UUID: WeakCoordinator] = [:]
  
  init(assembly: CoordinatorAssembly, navigationController: UINavigationController, factory: FactoryType) {
    self.assembly = assembly
    self.navigationController = navigationController
    self.factory = factory
  }
  
  func start() {
    // Must be implemented
  }
  
  func start(coordinator: Coordinator) {
    childCoordinators[coordinator.id] = WeakCoordinator(coordinator: coordinator)
    coordinator.parentCoordinator = self
    coordinator.start()
  }
  
  func stop() {
    childCoordinators.values.forEach { $0.coordinator?.stop() }
    childCoordinators.removeAll()
    parentCoordinator?.removeChild(by: id)
    parentCoordinator = nil
  }
  
  func removeChild(by id: UUID) {
    childCoordinators.removeValue(forKey: id)
  }
  
  deinit {
    stop()
    print(#function + "\(String(describing: self))")
  }
}

// MARK: - Equatable

extension BaseCoordinator {
  static func == (lhs: BaseCoordinator, rhs: BaseCoordinator) -> Bool {
    return lhs.id == rhs.id
  }
}
