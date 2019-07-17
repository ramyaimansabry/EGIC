//
//  AboutController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/8/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import SVProgressHUD

class AboutController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchData()
    }
    func fetchData(){
        SVProgressHUD.show()
        ApiManager.sharedInstance.loadAbout { (valid, msg, code) in
            self.dismissRingIndecator()
            if valid {
                let style = NSMutableParagraphStyle()
                style.lineSpacing = 4
                style.alignment = NSTextAlignment.center
                let atributes = [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]

                self.textView.attributedText = NSAttributedString(string: msg, attributes: atributes)
                self.textView.textColor = .white
            }else {
                if code == -3 {
                    HelperData.sharedInstance.signOut()
                    self.show1buttonAlert(title: "Error".localized, message: "tokenError".localized, buttonTitle: "Retry".localized, callback: {
                       HelperData.sharedInstance.signOut()
                       self.dismiss(animated: true, completion: nil)
                    })
                    
                }else {
                    self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "Retry".localized, callback: {
                        
                    })
                }
            }
        }
    }
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "About".localized
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        SVProgressHUD.setupView()
        
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
