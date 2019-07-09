
import UIKit
import SVProgressHUD

class ProductsController: UIViewController {
    @IBOutlet weak var collectionView1: UICollectionView!
    var isFinishedPaging = true
    var pagesNumber: Int = 0
    var bassedCategoryID: Int?
    var productsArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        SVProgressHUD.show()
        fetchProducts(id: bassedCategoryID!, offset: pagesNumber, limit: 10)
    }
    
    func fetchProducts(id: Int, offset: Int, limit: Int){
        isFinishedPaging = false
        ApiManager.sharedInstance.loadProducts(id: id, offset: offset, limit: limit) { (valid, msg, products) in
            self.dismissRingIndecator()
            self.isFinishedPaging = true
            if valid {
                if products.count > 0 {
                    for product in products {
                        self.productsArray.append(product)
                    }
                }
                self.collectionView1.reloadData()
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK", callback: {
                    
                })
            }
        }
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Products".localized
        SVProgressHUD.setupView()
        
        self.collectionView1.register(UINib(nibName: "ProductsCell", bundle: nil), forCellWithReuseIdentifier: "ProductsCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView1.prefetchDataSource = self
        
        
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
      
    }
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        if ((indexPaths.last?.row)! + 3) > self.productsArray.count && isFinishedPaging == true {
            pagesNumber += 1
            self.fetchProducts(id: self.bassedCategoryID!, offset: pagesNumber, limit: 7)
        }
    }
    
    
    
}
