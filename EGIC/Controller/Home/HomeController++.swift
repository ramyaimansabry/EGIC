import UIKit
import SideMenu
import MOLH
import SVProgressHUD

extension HomeController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 { return bassedHomeCategories?.slider.count ?? 0 }
        else { return bassedHomeCategories?.catalog.count ?? 0 }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionView1 {
            let cell: SliderCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "SliderCustomCell", for: indexPath) as! SliderCell
            
            cell.tag = indexPath.row
            cell.title.text = bassedHomeCategories?.slider[indexPath.row].title
            let stringUrl = bassedHomeCategories?.slider[indexPath.row].image
            let downloadURL = stringUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: downloadURL!)
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: url)
            cell.backgroundColor = UIColor.white
            return cell
        }else {
            let cell: CatalogCell = collectionView2.dequeueReusableCell(withReuseIdentifier: "CatalogCustomCell", for: indexPath) as! CatalogCell
            
            cell.tag = indexPath.row
            let stringUrl = bassedHomeCategories?.catalog[indexPath.row].image
            let downloadURL = stringUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: downloadURL!)
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: url)
            cell.backgroundColor = UIColor.white
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView1 {
            return CGSize(width: collectionView1.frame.width, height: collectionView1.frame.height)
        }else {
            return CGSize(width: (collectionView2.frame.width-50)/3, height: collectionView2.frame.height-30)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionView2 {
            return 15
        }else {
            return 0
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = pageNumber
        pageControl.updateCurrentPageDisplay()
        self.index = pageNumber
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.isTracking {
            timer?.invalidate()
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }
    
    
    
    
    // MARK-: Slide timer
/************************************************************************************/
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(scrollToNextCell), userInfo: nil, repeats: true)
    }
    
    @objc func scrollToNextCell() {
        let items = collectionView1.numberOfItems(inSection: 0)
        if (items - 1) == index {
            collectionView1.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.right, animated: true)
        } else if index == 0 {
            collectionView1.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.left, animated: true)
        } else {
            collectionView1.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
        print(index)
        pageControl.currentPage = index
        
        if inForwardDirection {
            if index == (items - 1) {
                index -= 1
                inForwardDirection = false
            } else {
                index += 1
            }
        } else {
            if index == 0 {
                index += 1
                inForwardDirection = true
            } else {
                index -= 1
            }
        }
        
    }
    
    
    
    
}
