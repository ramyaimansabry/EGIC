
import UIKit
import SVProgressHUD


extension CategoriesController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentCategoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CategoriesCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "CategoriesCell", for: indexPath) as! CategoriesCell
        
        cell.tag = indexPath.row
        let rowCategory = currentCategoriesArray[indexPath.row]
        cell.category = rowCategory
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = true
        cell.makeShadow(cornerRadius: 5)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width-20, height: 130)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rowCategory = currentCategoriesArray[indexPath.row]
        if rowCategory.child.count > 0 {
            self.previousCategoriesArray.append(self.currentCategoriesArray)
            self.currentCategoriesArray = rowCategory.child
            self.collectionView1.reloadData()
            self.collectionView1.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }else {
            self.goProducts(id: rowCategory.id)
        }
        
    }
    
    
    
}
