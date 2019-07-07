
import UIKit
import SideMenu
import MOLH

class HomeController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    let leftMenuController = LeftMenuController()
    var bassedHomeCategories: HomeCategories?
    
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
        
        label1.text = "label1".localized
        label2.text = "label2".localized
        
        leftMenuController.homeController = self
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenuController)
        if "currentLang".localized == "en" {
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController

        }else {
            SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController

        }
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .preserve
        SideMenuManager.defaultManager.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = min(3*(self.view.frame.width/4), 400)
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "AppICON")
        iconImage.contentMode = .scaleAspectFit
        iconImage.backgroundColor = UIColor.clear
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        navigationItem.titleView = iconImage
        
        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "MenuICON777")?.withRenderingMode(.alwaysTemplate), for: .normal)
        leftButton.tintColor = UIColor.black
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 23).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 23).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        if "currentLang".localized == "en" {
            present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
        }else {
            present(SideMenuManager.default.menuRightNavigationController!, animated: true, completion: nil)
        }
    }
    
    func signOut(){
        self.show2buttonAlert(title: "Logout".localized, message: "LogoutAlert".localized, cancelButtonTitle: "Cancel", defaultButtonTitle: "OK") { (yes) in
            if yes {
                UserDefaults.standard.removeObject(forKey: "loggedInClient")
                UserDefaults.standard.synchronize()
                UserDefaults.standard.set(false, forKey: "clientLoggedIn")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func changeLanguage(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.0) {
            self.showLanguageAlert { (language) in
                if language == "en" && "currentLang".localized == "ar" {
                    MOLH.setLanguageTo(language)
                    MOLH.reset()
                }
                else if language == "ar" && "currentLang".localized == "en" {
                    MOLH.setLanguageTo(language)
                    MOLH.reset()
                }
            }
        }
    }
}


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
            print(indexPath.row)
            cell.backgroundColor = UIColor.yellow
            return cell
        }else {
            let cell: CatalogCell = collectionView2.dequeueReusableCell(withReuseIdentifier: "CatalogCustomCell", for: indexPath) as! CatalogCell
            
            cell.tag = indexPath.row
            let stringUrl = bassedHomeCategories?.catalog[indexPath.row].image
            let downloadURL = stringUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: downloadURL!)
           
            cell.image.kf.indicatorType = .activity
            cell.image.kf.setImage(with: url)
            cell.backgroundColor = UIColor.red
            return cell
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == collectionView1 {
            return CGSize(width: collectionView1.frame.width, height: collectionView1.frame.height)
        }else {
            return CGSize(width: (collectionView2.frame.width-30)/3, height: collectionView2.frame.height-30)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == collectionView2 {
            return 15
        }else {
            return 0
        }
    }
    
    
}
