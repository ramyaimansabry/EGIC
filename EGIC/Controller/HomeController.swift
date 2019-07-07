
import UIKit
import SideMenu
import MOLH

class HomeController: UIViewController {
    let leftMenuController = LeftMenuController()
    var bassedHomeCategories: HomeCategories?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    

    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        
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
}


extension HomeController {
    
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
