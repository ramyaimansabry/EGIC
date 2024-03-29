
import UIKit
import SVProgressHUD

class SplashScreenController: UIViewController {
    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setupView()
        LoadingActivityIndicator.startAnimating()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ShowViewController()
    }
    
    func ShowViewController(){
        if loggedInClient() == true {
            LoadingActivityIndicator.startAnimating()
            self.LoadingActivityIndicator.isHidden = false
            HelperData.sharedInstance.loggedInClient.language = "currentLang".localized
            HelperData.sharedInstance.loggedInClient.login()
            ApiManager.sharedInstance.loadHomeCategories { (valid, msg, homeCategories, code) in
                self.LoadingActivityIndicator.stopAnimating()
                self.LoadingActivityIndicator.isHidden = true
                if valid {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
                    let homeController = UINavigationController(rootViewController: controller)
                    controller.navigationController?.isNavigationBarHidden = false
                    controller.bassedHomeCategories = homeCategories
                    self.present(homeController, animated: true, completion: nil)
                }else {
                    if code == -3 {
                        HelperData.sharedInstance.signOut()
                        self.show1buttonAlert(title: "Error".localized, message: "tokenError".localized, buttonTitle: "Retry".localized, callback: {
                            self.ShowViewController()
                        })
                        
                    }else {
                        self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "Retry".localized, callback: {
                            self.ShowViewController()
                        })
                    }
                }
            }
        }else {
            self.LoadingActivityIndicator.stopAnimating()
            if choosedLanguage() {
                let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "SignInController") as! SignInController
                let loginController = UINavigationController(rootViewController: controller)
                controller.navigationController?.isNavigationBarHidden = true
                present(loginController, animated: true, completion: nil)
            }else {
                let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "LanguageController") as! LanguageController
                let loginController = UINavigationController(rootViewController: controller)
                controller.navigationController?.isNavigationBarHidden = true
                present(loginController, animated: true, completion: nil)
            }
        }
    }
    
    fileprivate func loggedInClient() -> Bool {
        if UserDefaults.standard.bool(forKey: "clientLoggedIn"){
            return true
        }
        else {
            return false
        }
    }
    
    fileprivate func choosedLanguage() -> Bool {
        if UserDefaults.standard.bool(forKey: "choosedLanguageDone"){
            return true
        }
        else {
            return false
        }
    }
    
    
}

