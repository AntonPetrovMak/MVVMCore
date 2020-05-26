//
//  BaseViewModelOutput.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import Foundation

protocol LoadingViewModelOutput {
  var isLoading: Observable<Bool> { get }
}

protocol ErrorViewModelOutput {
  var error: Observable<String?> { get }
}

protocol BaseViewModelOutput: LoadingViewModelOutput, ErrorViewModelOutput { }
