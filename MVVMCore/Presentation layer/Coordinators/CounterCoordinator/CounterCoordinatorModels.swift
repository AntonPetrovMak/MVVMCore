//
//  CounterCoordinatorModels.swift
//  MVVMCore
//
//  Created by Serhii Petrishenko on 04.06.2020.
//  Copyright © 2020 APM. All rights reserved.
//

enum CounterCoordinatorModels {
  enum Context {
    case pushForward(count: Int, didChangeCount: (Int) -> Void)
    case presentForward(count: Int, didChangeCount: (Int) -> Void)
  }
}
