
import UIKit
import SVProgressHUD

class CategoriesController: UIViewController {
    @IBOutlet weak var collectionView1: UICollectionView!
    var categoriesArray = [Categories]()
    var currentCategoriesArray = [Categories]()
    var previousCategoriesArray = [[Categories]]()
    var bassedCategoryId: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        if bassedCategoryId == nil{
            fetchCategories()
        }else {
            fetchCategoriesWithId()
        }
    }
    
    func fetchCategories(){
        SVProgressHUD.show()
        ApiManager.sharedInstance.loadCategories { (valid, msg, categories) in
            self.dismissRingIndecator()
            if valid {
                self.categoriesArray = categories
                self.currentCategoriesArray = categories
                self.collectionView1.reloadData()
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK", callback: {
                    
                })
            }
        }
    }
    func fetchCategoriesWithId(){
        SVProgressHUD.show()
        ApiManager.sharedInstance.loadCategories(id: bassedCategoryId!) { (valid, msg, categories) in
            self.dismissRingIndecator()
            if valid {
                self.categoriesArray = categories
                self.currentCategoriesArray = categories
                self.collectionView1.reloadData()
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK", callback: {
                    
                })
            }
        }
    }
    
    func goProducts(id: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ProductsController") as! ProductsController
        controller.bassedCategoryID = id
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Products".localized
        SVProgressHUD.setupView()
        
        self.collectionView1.register(UINib(nibName: "CategoriesCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCell")
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
        if self.previousCategoriesArray.count > 0 {
            self.currentCategoriesArray = self.previousCategoriesArray.last!
            self.previousCategoriesArray.removeLast()
            self.collectionView1.reloadData()
        }else {
            navigationController?.popViewController(animated: true)
        }
    }

}
