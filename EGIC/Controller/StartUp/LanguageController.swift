//
//  LanguageController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/6/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class LanguageController: UIViewController {
    @IBOutlet weak var languageTextField: UITextField!
    private let languageDataSource: [[String]] = [["English","en"],["العربية","ar"]]
    var selectedLanguage: String = "en"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageTextField.inputView = languagePickerView
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        languageTextField.text = languageDataSource[0][0]
    }
    
    func changeLanguage(language: String){
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SignInController") as! SignInController
        controller.selectedLanguage = self.selectedLanguage
        navigationController?.pushViewController(controller, animated: true)
        
        
        
    }
    
    @IBAction func continueButtonAction(_ sender: UIButton) {
        guard let language = languageTextField.text, languageTextField.text?.isEmpty == false else {
            self.show1buttonAlert(title: "خطا - Error", message: "اختر اللغة - Choose language", buttonTitle: "OK") {
            }
            return
        }
        
        changeLanguage(language: language)
    }
    lazy var languagePickerView: UIPickerView = {
        let pk = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 150))
        pk.backgroundColor = UIColor.white
        pk.delegate = self
        pk.dataSource = self
        return pk
    }()
}


extension LanguageController: UIPickerViewDelegate,UIPickerViewDataSource {
    
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
