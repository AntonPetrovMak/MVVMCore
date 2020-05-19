//
//  MVVMViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol MVVMViewController: class {
  associatedtype ViewModelType
  var viewModel: ViewModelType! { get set }
}
