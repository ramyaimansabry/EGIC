
import UIKit
import SVProgressHUD

class SignUpController: UIViewController {
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var jobTextField: UITextField!
    @IBOutlet weak var termsLabel: UILabel!
    private let jobDataSource: [[String]] = [["فني سباكة - Plumber","1"],["مهندس - Engineer","2"],["اخري - Other","3"]]
    var selectedJobId: String = "1"
   var currentAppLanguage: String = "currentLang".localized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
    }
    
    // MARK:- Network
/********************************************************************************/
    func signUp(name: String, email: String = "", phone: String, jobId: String){
        SVProgressHUD.show()
        ApiManager.sharedInstance.signUp(phoneNumber: phone, name: name, email: email, job_id: jobId, language: currentAppLanguage) { (valid, msg) in
            self.dismissRingIndecator()
            if valid {
                UserDefaults.standard.set(true, forKey: "clientLoggedIn")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "SignUpError".localized, buttonTitle: "OK") {
                }
            }
            
        }
    }
    
    @IBAction func RegisterButtonAction(_ sender: UIButton) {
        guard let phone = phoneTextField.text, phoneTextField.text?.count == 11, phoneTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error".localized, message: "SignUpError".localized, buttonTitle: "OK") {
            }
            return
        }
        guard let name = nameTextField.text, nameTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error".localized, message: "SignUpError".localized, buttonTitle: "OK") {
            }
            return
        }
        guard let _ = jobTextField.text, jobTextField.text?.IsValidString() ?? false else {
            self.show1buttonAlert(title: "Error".localized, message: "SignUpError".localized, buttonTitle: "OK") {
            }
            return
        }
        
        view.endEditing(true)
        if emailTextField.text?.isEmpty ?? true {
            signUp(name: name, phone: phone, jobId: selectedJobId)
        }else{
            signUp(name: name, email: emailTextField.text ?? "", phone: phone, jobId: selectedJobId)
        }
    }
    
    
    
    // MARK:- Helper functions
/********************************************************************************/
    func setupComponent(){
        termsLabel.text = "termsOfService".localized
        let text = "termsOfService".localized
        let underlineAttriString = NSMutableAttributedString(string: text)
        let range = (text as NSString).range(of: "termsLabel".localized)
        let strokeTextAttributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        underlineAttriString.addAttributes(strokeTextAttributes, range: range)
        termsLabel.attributedText = underlineAttriString
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(termsLabel(_ :)))
        termsLabel.isUserInteractionEnabled = true
        termsLabel.addGestureRecognizer(tapGesture)
        
        jobTextField.inputView = jobPickerView
        SVProgressHUD.setupView()
        leftButton.setImage(UIImage(named: "BackICON")?.withRenderingMode(.alwaysTemplate).imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        
        nameTextField.delegate = self
        emailTextField.delegate = self
    }
    @objc func termsLabel(_ sender: UITapGestureRecognizer){
        let text = "termsOfService".localized
        let range = (text as NSString).range(of: "termsLabel".localized)
        
        if sender.didTapAttributedTextInLabel(label: termsLabel, inRange: range){
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "TermsOfServiceController") as! TermsOfServiceController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.view.endEditing(true)
        self.navigationController?.popViewController(animated: true)
    }
    private func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
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
