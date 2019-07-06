//
//  ViewController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class SplashScreenController: UIViewController {
    
    @IBOutlet weak var LoadingActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     //   fetchHalls()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.ShowViewController()
        }
    }
    
//    func fetchHalls(){
//        LoadingActivityIndicator.startAnimating()
//        ApiManager.sharedInstance.listHalls(limit: 10, offset: 0) { (valid, msg, halls) in
//            self.LoadingActivityIndicator.stopAnimating()
//            if valid{
//                self.ShowViewController(halls: halls)
//            }else{
//                self.show1buttonAlert(title: "Error", message: msg, buttonTitle: "Retry", callback: {
//                    self.fetchHalls()
//                })
//            }
//        }
//    }
    
    
    func ShowViewController(){
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "LanguageController") as! LanguageController
        let loginController = UINavigationController(rootViewController: controller)
        controller.navigationController?.isNavigationBarHidden = true
        present(loginController, animated: true, completion: nil)
        
        
        if firstDownloadDone() {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "HomeController") as! HomeController
//            let homeController = UINavigationController(rootViewController: controller)
//            present(homeController, animated: true, completion: nil)
        }
        else {
//            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
//            let controller = storyboard.instantiateViewController(withIdentifier: "OnBoardingScreens") as! OnBoardingScreens
//            let homeController = UINavigationController(rootViewController: controller)
//            controller.halls = halls
//            homeController.isNavigationBarHidden = true
//            present(homeController, animated: true, completion: nil)
        }
    }
    
    fileprivate func firstDownloadDone() -> Bool {
        if UserDefaults.standard.bool(forKey: "isFirstDownloadDonee"){
            return true
        }
        else {
            return false
        }
    }
    
    
    
    
}

