
import UIKit
import SVProgressHUD

extension ProductsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout,UICollectionViewDataSourcePrefetching {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ProductsCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "ProductsCell", for: indexPath) as! ProductsCell
        
        cell.tag = indexPath.row
        let rowCategory = productsArray[indexPath.row]
        cell.product = rowCategory
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = true
        cell.makeShadow(cornerRadius: 5)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (view.frame.width-60)/2
        return CGSize(width: cellWidth, height: 1.5*cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rowCategory = productsArray[indexPath.row]
        print(rowCategory)
        if (rowCategory.dimensions.contains(".csv")) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "ProductDetailsController") as! ProductDetailsController
            controller.bassedUrl = rowCategory.dimensions
            let n = UINavigationController(rootViewController: controller)
            present(n, animated: true, completion: nil)
        }else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if ((indexPaths.last?.row)! + 3) > self.productsArray.count && isFinishedPaging == true {
            pagesNumber += 1
            self.fetchProducts(id: self.bassedCategoryID!, offset: pagesNumber, limit: 7)
        }
    }
    
    
    
}