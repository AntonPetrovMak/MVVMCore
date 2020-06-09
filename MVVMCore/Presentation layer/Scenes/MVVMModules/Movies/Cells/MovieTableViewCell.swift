//
//  MovieTableViewCell.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
  
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var distributorLabel: UILabel!
  @IBOutlet var worldwideGrossLabel: UILabel!
  @IBOutlet var descriptionView: UIStackView!
  @IBOutlet var descriptionLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  func setViewModel(_ viewModel: MoviesTableViewModel) {
    nameLabel.text = viewModel.name
    nameLabel.font = viewModel.nameFont
    distributorLabel.text = viewModel.distributor
    worldwideGrossLabel.text = viewModel.worldwideGross
    if let _descriptionText = viewModel.description {
      descriptionView.isHidden = false
      descriptionLabel.text = _descriptionText
      backgroundColor = viewModel.albumColor
    } else {
      descriptionView.isHidden = true
    }
  }
  
}
