//
//  Category.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit


struct Categories: Decodable {
    let subCategories: [subCategories]?
}

struct subCategories: Decodable {
    let id: Int?
    let parent: String?
    let title: String?
    let image: String?
    let child: [subCategories]?
}
