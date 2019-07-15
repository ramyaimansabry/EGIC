
import UIKit
import SVProgressHUD

class BillController: UIViewController {
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    @IBOutlet weak var waterSupplyLabel: UILabel!
    @IBOutlet weak var drainageLabel: UILabel!
    var bassedResult: Calculate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    
    
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Bill".localized
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        SVProgressHUD.setupView()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.register(UINib(nibName: "CalculateResultCell", bundle: nil), forCellWithReuseIdentifier: "CalculateResultCell")
        
        collectionView2.delegate = self
        collectionView2.dataSource = self
        collectionView2.register(UINib(nibName: "CalculateResultCell", bundle: nil), forCellWithReuseIdentifier: "CalculateResultCell")
        
        waterSupplyLabel.text = "WaterSupply".localized
        drainageLabel.text = "Drainage".localized
        
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




extension BillController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionView1 {
            return bassedResult?.feedItems.count ?? 0
        }else {
            return bassedResult?.drainItems.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalculateResultCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalculateResultCell", for: indexPath) as! CalculateResultCell
        
        if collectionView == collectionView1 {
            cell.item = bassedResult?.feedItems[indexPath.row]
        }else {
            cell.item = bassedResult?.drainItems[indexPath.row]
        }
        
        cell.makeShadow(cornerRadius: 5)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
      // let cellHeight = max(130, view.frame.height/6)
        return CGSize(width: view.frame.width-20, height: 50)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }
    
}
