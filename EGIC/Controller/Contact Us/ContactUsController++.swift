import UIKit
import MapKit



extension ContactUsController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContactUsCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "ContactUsCell", for: indexPath) as! ContactUsCell
        
        cell.image.image = UIImage(named: array[indexPath.row].image)
        cell.label.text = array[indexPath.row].title
        cell.backgroundColor = array[indexPath.row].color
        cell.makeShadow(cornerRadius: 10)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView1.frame.width-80)/3, height: collectionView1.frame.height-40)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 20
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            self.email(email: array[indexPath.row].number)
        }else {
            self.call(number: array[indexPath.row].number)
        }
    }
    
    
}
