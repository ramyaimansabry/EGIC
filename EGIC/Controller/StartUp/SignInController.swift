//
//  SignInController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class SignInController: UIViewController {

    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var languageTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    private let languageDataSource: [[String]] = [["English","en"],["العربية","ar"]]
    var selectedLanguage: String = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpLabel()
        languageTextField.inputView = languagePickerView
      
    }
    
    @IBAction func LoginButtonAction(_ sender: UIButton) {
        
        
    }
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = (label1.text)!
        let range = (text as NSString).range(of: "Sign Up")
        
        if sender.didTapAttributedTextInLabel(label: label1, inRange: range){
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
            self.navigationController?.pushViewController(controller, animated: true)
            return
        }
        
        let text2 = (label2.text)!
        let range2 = (text2 as NSString).range(of: "سجل بياناتك هنا")
        
        if sender.didTapAttributedTextInLabel(label: label2, inRange: range2){
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller2 = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
            self.navigationController?.pushViewController(controller2, animated: true)
       }
        
    }
    func setupSignUpLabel(){
        label1.text = "Don't have account? Sign Up"
        let text = (label1.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "Sign Up")
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.mainAppColor(),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        underlineAttriString.addAttributes(strokeTextAttributes, range: range)
        label1.attributedText = underlineAttriString
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
        label1.addGestureRecognizer(tap)
        label1.isUserInteractionEnabled = true
        
        
        label2.text = "ليس لديك حساب؟ سجل بياناتك هنا"
        let text2 = (label2.text)!
        let underlineAttriString2 = NSMutableAttributedString(string: text2)
        let range2 = (text2 as NSString).range(of: "سجل بياناتك هنا")
        let strokeTextAttributes2: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.mainAppColor(),
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        underlineAttriString2.addAttributes(strokeTextAttributes2, range: range2)
        label2.attributedText = underlineAttriString2
        let tap2 = UITapGestureRecognizer(target: self, action: #selector(tapLabel(_:)))
        label2.addGestureRecognizer(tap2)
        label2.isUserInteractionEnabled = true
        
    }
   
    lazy var languagePickerView: UIPickerView = {
        let pk = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 150))
        pk.backgroundColor = UIColor.white
        pk.delegate = self
        pk.dataSource = self
        return pk
    }()
}

extension SignInController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languageDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languageDataSource[row][0]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = languageDataSource[languagePickerView.selectedRow(inComponent: 0)][1]
        languageTextField.text = languageDataSource[languagePickerView.selectedRow(inComponent: 0)][0]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
}
