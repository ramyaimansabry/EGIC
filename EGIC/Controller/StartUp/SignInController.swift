//
//  SignInController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import SVProgressHUD

class SignInController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    var selectedLanguage: String = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpLabel()
        SVProgressHUD.setupView()
    }
    
    func login(phone: String){
        SVProgressHUD.show()
        ApiManager.sharedInstance.signIn(phoneNumber: phone, language: selectedLanguage) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                print(msg)
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "LoginError".localized, buttonTitle: "OK") {
                }
            }
        }
        
    }
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        guard let phone = phoneTextField.text, phoneTextField.text?.count == 11, phoneTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error".localized, message: "LoginError".localized, buttonTitle: "OK") {
            }
            return
        }
        login(phone: phone)
    }
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = "dontHaveAccount".localized
        let range = (text as NSString).range(of: "signUpLabel".localized)
        
        if sender.didTapAttributedTextInLabel(label: label1, inRange: range){
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
            controller.selectedLanguage = self.selectedLanguage
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    func setupSignUpLabel(){
        label1.text = "dontHaveAccount".localized
        let text = "dontHaveAccount".localized
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "signUpLabel".localized)
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.mainAppColor(),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        underlineAttriString.addAttributes(strokeTextAttributes, range: range)
        label1.attributedText = underlineAttriString
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
        label1.addGestureRecognizer(tap)
        label1.isUserInteractionEnabled = true
    }
   
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
}

