//
//  Movie.swift
//  MVVMCore
//
//  Created by Petrov Anton on 5/19/20.
//  Copyright © 2020 APM. All rights reserved.
//

import UIKit

class Movie {
  let name: String
  let distributor: String
  let worldwideGross: String
  let albumColor: UIColor
  let description: String
  
  init(name: String, distributor: String, worldwideGross: String, albumColor: UIColor, description: String) {
    self.name = name
    self.distributor = distributor
    self.worldwideGross = worldwideGross
    self.albumColor = albumColor
    self.description = description
  }
}
