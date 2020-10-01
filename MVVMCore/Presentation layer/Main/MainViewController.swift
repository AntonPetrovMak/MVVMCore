//
//  MainViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/20/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
  
  var viewModel: MainViewModelProtocol!
  
  // MARK: - @IBAction
  
  @IBAction func showCounter() {
    viewModel.showCounter(modalView: false)
  }
  
  @IBAction func presentCounter() {
    viewModel.showCounter(modalView: true)
  }
  
  @IBAction func showSimpleMovies() {
    viewModel.showSimpleMovies()
  }
  
  @IBAction func showFullMovies() {
    viewModel.showFullMovies()
  }
  
}
