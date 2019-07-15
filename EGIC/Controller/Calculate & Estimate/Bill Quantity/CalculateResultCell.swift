//
//  CalculateCell.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/15/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class CalculateResultCell: UICollectionViewCell {
    @IBOutlet weak var collectionViewRow: UICollectionView!
    var item: Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewRow.delegate = self
        collectionViewRow.dataSource = self
         self.collectionViewRow.register(UINib(nibName: "CalculateItemCell", bundle: nil), forCellWithReuseIdentifier: "CalculateItemCell")
    }

}


extension CalculateResultCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalculateItemCell = collectionViewRow.dequeueReusableCell(withReuseIdentifier: "CalculateItemCell", for: indexPath) as! CalculateItemCell
        
        if indexPath.row == 0 {
            cell.label.text = item!.name
        }else if indexPath.row == 1 {
            cell.label.text = item!.measure
        }else if indexPath.row == 2 {
            cell.label.text = "\(item!.quantity)"
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row == 2 {
             return CGSize(width: frame.width/6, height: frame.height)
        }else {
             let firstRowWidth = frame.width/5
             return CGSize(width: (frame.width-firstRowWidth)/2, height: frame.height)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
}

