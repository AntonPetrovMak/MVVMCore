//
//  TestViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/18/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class TestViewController: BaseViewController, MVVMViewController {
  
  private lazy var countLabel = UILabel()
  private lazy var pushButton: UIButton = {
    let _button = UIButton()
    _button.setTitle("Push", for: .normal)
    _button.setTitleColor(.black, for: .normal)
    _button.addTarget(self, action: #selector(pushButtonTouched), for: .touchUpInside)
    return _button
  }()
  
  private lazy var presentButton: UIButton = {
    let _button = UIButton()
    _button.setTitle("Present", for: .normal)
    _button.setTitleColor(.black, for: .normal)
    _button.addTarget(self, action: #selector(presentButtonTouched), for: .touchUpInside)
    return _button
  }()
  
  private lazy var clearButton: UIButton = {
    let _button = UIButton()
    _button.setTitle("Clear", for: .normal)
    _button.setTitleColor(.red, for: .normal)
    _button.addTarget(self, action: #selector(clearButtonTouched), for: .touchUpInside)
    return _button
  }()
  
  var viewModel: TestViewModelProtocol!
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    let stackView = UIStackView(arrangedSubviews: [countLabel, pushButton, presentButton])
    stackView.alignment = .fill
    stackView.axis = .horizontal
    stackView.distribution = .fillEqually
    stackView.frame = CGRect(x: 0, y: 200, width: 300, height: 50)
    view.addSubview(stackView)
    
    clearButton.frame = CGRect(x: 0, y: 300, width: 100, height: 50)
    view.addSubview(clearButton)
    
    bind()
    viewModel.viewDidLoad()
  }
  
  func bind() {
    baseBind(to: viewModel)
    viewModel.reload = { [weak self] in self?.clearButtonTouched() }
    viewModel.count.observeWithStartingValue(on: self) { [weak self] in self?.countLabel.text = "\($0)" }
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    viewModel.viewWillAppear()
  }
  
  // MARK: - Private
  
  
  @objc private func pushButtonTouched() {
    viewModel.pushCounter()
  }
  
  @objc private func presentButtonTouched() {
    viewModel.presentCounter()
  }
  
  @objc private func clearButtonTouched() {
    viewModel.clearData()
  }
}
