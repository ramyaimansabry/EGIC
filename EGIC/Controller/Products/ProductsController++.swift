
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
        cell.title.text = productsArray[indexPath.row].title
        let stringUrl = productsArray[indexPath.row].image
        let downloadURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: downloadURL!)
        cell.image.kf.indicatorType = .activity
        cell.image.kf.setImage(with: url)
        cell.backgroundColor = UIColor.white
        cell.layer.masksToBounds = true
        cell.makeShadow(cornerRadius: 5)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = min((view.frame.width-60)/2, 300)
        let cellHeight = 1.2*cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rowCategory = productsArray[indexPath.row]
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProductDetailsController") as! ProductDetailsController
        controller.bassedProduct = rowCategory
        present(controller, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if (((indexPaths.last?.row)! + 3) >= self.productsArray.count) && isFinishedPaging == true {
            self.fetchProducts(id: self.bassedCategoryID!, offset: pagesNumber, limit: 15)
            pagesNumber += 1
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y + 700
//        let contentHeight = scrollView.contentSize.height
//
//        if offsetY > contentHeight - scrollView.frame.size.height{
//            if isFinishedPaging == true {
//                self.fetchProducts(id: self.bassedCategoryID!, offset: pagesNumber, limit: 10)
//                pagesNumber += 1
//            }
//        }
    }
    
}
