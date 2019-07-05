//
//  SignUpController.swift
//  EGIC
//
//  Created by Ramy Ayman Sabry on 7/5/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    private let jobDataSource: [[String]] = [["فني سباكة - Plumber","1"],["مهندس - Engineer","2"],["اخري - Other","3"]]
    var selectedJobId: String = "1"
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTermsLabel()
        jobTextField.inputView = jobPickerView
    }
    

    @IBAction func RegisterButtonAction(_ sender: UIButton) {
        
        
    }
    func setupTermsLabel(){
        termsLabel.text = "By pressing register button, you are agree to our Terms & Conditions"
        let text = (termsLabel.text)!
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "Terms & Conditions")
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        underlineAttriString.addAttributes(strokeTextAttributes, range: range)
        termsLabel.attributedText = underlineAttriString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsLabel(_ :)))
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(tapGesture)
    }
    @objc func termsLabel(_ sender: UITapGestureRecognizer){
        let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfServiceController") as! TermsOfServiceController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    
    
    lazy var jobPickerView: UIPickerView = {
        let pk = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 160))
        pk.backgroundColor = UIColor.white
        pk.delegate = self
        pk.dataSource = self
        return pk
    }()
}


extension SignUpController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return jobDataSource.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return jobDataSource[row][0]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedJobId = jobDataSource[jobPickerView.selectedRow(inComponent: 0)][1]
        jobTextField.text = jobDataSource[jobPickerView.selectedRow(inComponent: 0)][0]
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 35
    }
}
