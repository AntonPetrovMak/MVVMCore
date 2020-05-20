//
//  MoviesListTableViewController.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MoviesListTableViewController: BaseViewController, MVVMViewController {
  
  var viewModel: MoviesListViewModelProtocol!
  
  @IBOutlet var tableView: UITableView!
  private let refreshControl = UIRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    bind()
    viewModel.viewDidLoad()
    title = viewModel.screenTitle
  }
  
  private func setupTableView() {
    tableView.dataSource = self
    tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")
    refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    tableView.refreshControl = refreshControl
  }
  
  private func bind() {
    viewModel.moviesViewModels.observe(on: self) { [weak self] _ in self?.tableView.reloadData() }
    viewModel.isLoading.observe(on: self) { [weak self] in
      $0 ? self?.refreshControl.beginRefreshing() : self?.refreshControl.endRefreshing()
    }
  }
  
  @objc private func refresh() {
    viewModel.pullToRefresh()
  }
  
}

// MARK: - UITableViewDataSource

extension MoviesListTableViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.moviesViewModels.value.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
    let cellViewModel = viewModel.moviesViewModels.value[indexPath.row]
    cell.setViewModel(cellViewModel)
    return cell
  }
    
}
