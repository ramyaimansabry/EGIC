

import UIKit
import SVProgressHUD

class SocialController: UIViewController {
    @IBOutlet weak var collectionView1: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    
    }
    
    let array: [Contact] = {
        let contact1 = Contact(title: "Facebook", color: UIColor(hexString: "EEEBE4"), number: "https://m.facebook.com/EGIC.Egypt", image: "SocialImage1")
        
        let contact2 = Contact(title: "Twitter", color: UIColor(hexString: "EEEBE4"), number: "https://twitter.com/EGIC_EGYPT", image: "SocialImage2")
        
        let contact3 = Contact(title: "Youtube", color: UIColor(hexString: "EEEBE4"), number: "https://www.youtube.com/channel/UCueKQHphJrtt0_r6IUV_YIg?view_as=subscriber", image: "SocialImage3")
        
        let contact4 = Contact(title: "Instagram", color: UIColor(hexString: "EEEBE4"), number: "https://www.instagram.com/egic_egypt", image: "SocialImage4")
        
        let contact5 = Contact(title: "Linkedin", color: UIColor(hexString: "EEEBE4"), number: "https://www.linkedin.com/company/egic", image: "SocialImage5")
        
        let contact6 = Contact(title: "EGIC Website", color: UIColor(hexString: "EEEBE4"), number: "https://www.egic.com.eg", image: "AppICON")
        
        return [contact1, contact2, contact3, contact4, contact5, contact6]
    }()
    
    func openLink(link: String){
        let linkURL = URL(string: "\(link)")
        UIApplication.shared.open(linkURL!)
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Social".localized
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        SVProgressHUD.setupView()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON")?.withRenderingMode(.alwaysTemplate).imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        leftButton.tintColor = UIColor.mainAppColor()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }

}



extension SocialController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: SocialCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "SocialCell", for: indexPath) as! SocialCell
        
        cell.image.image = UIImage(named: array[indexPath.row].image)
        cell.label.text = array[indexPath.row].title
        cell.backgroundColor = array[indexPath.row].color
        cell.makeShadow(cornerRadius: 10)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let x = (collectionView1.frame.width-90)/2
        let cellSize = min(x, 300)
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       self.openLink(link: array[indexPath.row].number)
    }
    
    
}


