
import UIKit
import SVProgressHUD

class SignInController: UIViewController {
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    var currentAppLanguage: String = "currentLang".localized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
    }
    
    // MARK:- Network
/********************************************************************************/
    func login(phone: String){
        SVProgressHUD.show()
        ApiManager.sharedInstance.signIn(phoneNumber: phone, language: currentAppLanguage) { (valid, msg, code) in
            self.dismissRingIndecator()
            if valid {
                UserDefaults.standard.set(true, forKey: "clientLoggedIn")
                UserDefaults.standard.synchronize()
                self.dismiss(animated: true, completion: nil)
            }else {
                if code  == -4 {
                    self.show1buttonAlert(title: "Error".localized, message: "LoginError".localized, buttonTitle: "OK") {
                    }
                }else {
                    self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK") {
                    }
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
        phoneTextField.endEditing(true)
        login(phone: phone)
    }
    
    
    
    // MARK:- Helper functions
/********************************************************************************/
    @objc func tapLabel(_ sender: UITapGestureRecognizer) {
        let text = "dontHaveAccount".localized
        let range = (text as NSString).range(of: "signUpLabel".localized)
        
        if sender.didTapAttributedTextInLabel(label: label1, inRange: range){
            let storyboard = UIStoryboard(name: "LoginBoard", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "SignUpController") as! SignUpController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    func setupComponent(){
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
        
        SVProgressHUD.setupView()
        phoneTextField.keyboardType = .asciiCapableNumberPad
    }
    
}

