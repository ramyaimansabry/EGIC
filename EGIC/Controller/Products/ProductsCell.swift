//
//  ProductsCell.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/9/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class ProductsCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
//    var product: Product?{
//        didSet{
//            guard let bassedProduct = product else { return }
//            
//            self.title.text = bassedProduct.title
//            let stringUrl = bassedProduct.image
//            let downloadURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
//            let url = URL(string: downloadURL!)
//            image.kf.indicatorType = .activity
//            image.kf.setImage(with: url)
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
