//
//  MainViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/20/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController, MVVMViewController {
  
  var viewModel: MainViewModelProtocol!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  // MARK: Object lifecycle
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    setup()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  // MARK: Setup
  
  private func setup() {
    let viewController = self
    let router = MainRouter()
    router.baseViewController = viewController
    let viewModel = MainViewModel(router: router)
    viewController.viewModel = viewModel
  }
  
  // MARK: - @IBAction
  
  @IBAction func showCounter() {
    viewModel.showCounter()
  }
  
  @IBAction func showSimpleMovies() {
    viewModel.showSimpleMovies()
  }
  
  @IBAction func showFullMovies() {
    viewModel.showFullMovies()
  }
  
}
