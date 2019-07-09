
import UIKit
import SVProgressHUD

class CategoriesController: UIViewController {
    @IBOutlet weak var collectionView1: UICollectionView!
    var categoriesArray = [Categories]()
    var currentCategoriesArray = [Categories]()
    var previousCategoriesArray = [[Categories]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchCategories()
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
        }else {
            self.goProducts(id: rowCategory.id)
        }
        
    }
    
    
    
}
