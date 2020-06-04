//
//  Assembly.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 04.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

protocol CoordinatorAssembly {
  func makeCoordinator<T>(of type: T.Type, with window: UIWindow) -> T
}
