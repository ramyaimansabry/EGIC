
import UIKit

class ChangeLanguageAlert: UIViewController {
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var arabicSwitch: UISwitch!
    @IBOutlet weak var englishSwitch: UISwitch!
    var buttonAction: ((_ valid: Bool,_ language: String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    override func viewWillAppear(_ animated: Bool) {
        animateView()
    }
    func prepareData(){
        CancelButton.layer.borderWidth = 1
        CancelButton.layer.borderColor = UIColor.mainAppColor().cgColor
        titleLabel.text = "changeLanguage".localized
        CancelButton.setTitle("CancelButton".localized, for: .normal)
        OkButton.setTitle("ChangeLanguageButton".localized, for: .normal)
        
        if "currentLang".localized == "en"{
            englishSwitch.isOn = true
            arabicSwitch.isOn = false
        }else {
            englishSwitch.isOn = false
            arabicSwitch.isOn = true
        }
    }
    @IBAction func switchChanged(_ sender: UISwitch) {
        if sender == englishSwitch {
            arabicSwitch.setOn(!sender.isOn, animated: true)
        }else if sender == arabicSwitch {
            englishSwitch.setOn(!sender.isOn, animated: true)
        }
    }
    func animateView() {
        alertView.alpha = 0
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 40
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.alertView.alpha = 1.0
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 40
        })
    }
    @IBAction func CancelButtonAction(_ sender: UIButton) {
        self.buttonAction?(false,"en")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func OkButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            if self.englishSwitch.isOn == true {
                self.buttonAction?(true,"en")
            }else{
                self.buttonAction?(true,"ar")
            }
        }
        
    }
    
   
}

