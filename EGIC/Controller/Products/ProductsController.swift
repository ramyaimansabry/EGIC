
import UIKit
import SVProgressHUD

class ProductsController: UIViewController {
    @IBOutlet weak var collectionView1: UICollectionView!
    var isFinishedPaging = true
    var firstOpen: Bool = true
    var pagesNumber: Int = 1
    var bassedCategoryID: Int?
    var productsArray = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        SVProgressHUD.show()
        fetchProducts(id: bassedCategoryID!, offset: 0, limit: 10)
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
                    self.collectionView1.reloadData()
                }else {
                    if self.firstOpen {
                        self.show1buttonAlert(title: "Error".localized, message: "LoadingDataError".localized, buttonTitle: "OK", callback: {
                            self.navigationController?.popViewController(animated: true)
                        })
                    }
                }
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK", callback: {
                })
            }
            
            self.firstOpen = false
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
