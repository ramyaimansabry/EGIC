//
//  CalculateCell.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/13/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class CalculateCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
   override var isSelected: Bool {
        didSet{
            if isSelected {
                image.tintColor = UIColor.white
                label.textColor = UIColor.white
                backgroundColor = UIColor.mainAppColor()
            }else {
                image.tintColor = UIColor.mainAppColor()
                label.textColor = UIColor.mainAppColor()
                backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
