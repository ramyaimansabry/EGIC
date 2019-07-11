
import UIKit

class TwoButtonAlertController: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var msgTextView: UITextView!
    @IBOutlet weak var CancelButton: UIButton!
    @IBOutlet weak var OkButton: UIButton!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    var alertTitle: String = "Error"
    var alertMessage: String = ""
    var alertCancelButtonTitle: String = "Cancel"
    var alertDefualtButtonTitle: String = "OK"
    var buttonAction: ((_ defualt: Bool) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareData()
    }
    override func viewWillAppear(_ animated: Bool) {
        animateView()
    }
    func prepareData(){
        CancelButton.setTitle(self.alertCancelButtonTitle, for: .normal)
        CancelButton.layer.borderWidth = 1
        CancelButton.layer.borderColor = UIColor.mainAppColor().cgColor
        OkButton.setTitle(self.alertDefualtButtonTitle, for: .normal)
        titleLabel.text = self.alertTitle
        msgTextView.text = self.alertMessage
        let alertHeight = estimateFrameForTitleText(self.alertMessage).height + 110
        heightConstraint.constant = alertHeight
        self.view.layoutIfNeeded()
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
        self.dismiss(animated: true) {
             self.buttonAction?(false)
        }
    }
    @IBAction func OkButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.buttonAction?(true)
        }
    }
    
    
    // MARK : Text size
    /*****************************************************************************************/
    fileprivate func estimateFrameForTitleText(_ text: String) -> CGRect {
        let width = 240
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.systemFont(ofSize: 16)]), context: nil)
    }
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }
}

