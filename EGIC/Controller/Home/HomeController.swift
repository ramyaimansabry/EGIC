
import UIKit
import SideMenu
import MOLH
import SVProgressHUD

class HomeController: UIViewController {
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var collectionView2: UICollectionView!
    let leftMenuController = LeftMenuController()
    var bassedHomeCategories: HomeCategories?
    var index = 0
    var inForwardDirection = true
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        timer?.invalidate()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        startTimer()
    }
    
    func goCategoriesWithId(id: Int){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CategoriesController") as! CategoriesController
        controller.bassedCategoryId = "\(id)"
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func goProductsWithId(id: Int){
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
        SVProgressHUD.setupView()

        leftMenuController.homeController = self
        let menuLeftNavigationController = UISideMenuNavigationController(rootViewController: leftMenuController)
        if "currentLang".localized == "en" {
            SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        }else {
            SideMenuManager.default.menuRightNavigationController = menuLeftNavigationController
        }
        SideMenuManager.default.menuFadeStatusBar = false
        SideMenuManager.default.menuPushStyle = .replace
        SideMenuManager.default.menuAllowPushOfSameClassTwice = false
        SideMenuManager.defaultManager.menuPresentMode = .viewSlideInOut
        SideMenuManager.default.menuWidth = min(4*(self.view.frame.width/5), 500)
//        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
//        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
        collectionView2.delegate = self
        collectionView2.dataSource = self
        
        pageControl.numberOfPages = bassedHomeCategories?.slider.count ?? 0
        
        let iconImage = UIImageView()
        iconImage.image = UIImage(named: "AppICON")
        iconImage.contentMode = .scaleAspectFit
        iconImage.backgroundColor = UIColor.clear
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.widthAnchor.constraint(equalToConstant: 38).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 38).isActive = true
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
    
    
    // MARK-: Side menu functions
/************************************************************************************/
    func goHome(){
        navigationController?.popToRootViewController(animated: true)
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
            self.showLanguageAlert(callback: { (valid, language) in
                if valid {
                    if language == "en" && "currentLang".localized == "ar" {
                        MOLH.setLanguageTo(language)
                        MOLH.reset()
                    }
                    else if language == "ar" && "currentLang".localized == "en" {
                        MOLH.setLanguageTo(language)
                        MOLH.reset()
                    }
                }
            })
        }
    }
    
    func goCategories(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CategoriesController") as! CategoriesController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func goCalculate(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "CalculateController") as! CalculateController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func goContactUs(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ContactUsController") as! ContactUsController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    func goAboutUs(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "AboutController") as! AboutController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goSocial(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SocialController") as! SocialController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func goStores(){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "StoresController") as! StoresController
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

