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
  
  weak var navigationController: UINavigationController?
  
  var id = UUID()
  
  var childCoordinators: [UUID: WeakCoordinator] = [:]
  
  init(assembly: CoordinatorAssembly, navigationController: UINavigationController?, factory: FactoryType) {
    self.assembly = assembly
    self.navigationController = navigationController
    self.factory = factory
  }
  
  func createRootViewController() -> UIViewController {
    return UIViewController()
  }
  
  func start(style: CoordinatorPresentationStyle, animated: Bool) {
    let rootViewController = createRootViewController()
    switch style {
    case .push:
      navigationController?.pushViewController(rootViewController, animated: animated)
    case .setRoot:
      navigationController?.setViewControllers([rootViewController], animated: animated)
    case .custom: ()
    }
  }
  
  func start(coordinator: Coordinator, style: CoordinatorPresentationStyle, animated: Bool) {
    childCoordinators[coordinator.id] = WeakCoordinator(coordinator: coordinator)
    coordinator.parentCoordinator = self
    coordinator.start(style: style, animated: animated)
  }
  
  func stop() {
    //TODO: remove ref and pop to root
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
