
import UIKit
import SVProgressHUD

extension UIView {
    
    func fillSuperview() {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    func anchorSize(to view: UIView) {
        widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor?,
                leading: NSLayoutXAxisAnchor?,
                bottom: NSLayoutYAxisAnchor?,
                trailing: NSLayoutXAxisAnchor?,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    
    
    func dropShadow(cornerRadius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.clear.cgColor
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0,height: 0.2)
        layer.shadowRadius = 3.0
        layer.shadowOpacity = 0.2
        layer.masksToBounds = false
    }
}



extension UICollectionViewCell {
    
    func makeShadow(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        contentView.layer.cornerRadius = 1.0
        contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.clear.cgColor
        contentView.layer.masksToBounds = true;
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0,height: 0.3)
        layer.shadowRadius = 6.0
        layer.shadowOpacity = 0.3
        layer.masksToBounds = false
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius:contentView.layer.cornerRadius).cgPath
    }
}

extension SVProgressHUD {
    static func setupView(){
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultAnimationType(.native)
        //        SVProgressHUD.setForegroundColor(UIColor.mainAppPink())
        //        SVProgressHUD.setBackgroundColor(UIColor.darkGray.withAlphaComponent(0.6))
        //        SVProgressHUD.setRingRadius(25)
        //        SVProgressHUD.setRingThickness(5)
        //        SVProgressHUD.setCornerRadius(25)
        //        SVProgressHUD.setMinimumSize(CGSize(width: 30, height: 30))
        //     SVProgressHUD.show()
    }
}

extension UIViewController: UITextFieldDelegate{
    
    func show1buttonAlert(title: String, message: String, buttonTitle: String, callback: @escaping () -> ()){
//       let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { action in
//            callback()
//        }))
//         alert.view.tintColor = UIColor.mainAppColor()
//         self.present(alert, animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "OneButtonAlertController") as! OneButtonAlertController
        controller.alertTitle = title
        controller.alertMessage = message
        controller.alertCancelButtonTitle = buttonTitle
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
    }
    
    
    func show2buttonAlert(title: String, message: String, cancelButtonTitle: String, defaultButtonTitle: String, callback: @escaping (_ defualt: Bool) -> ()) {
//        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: .cancel, handler: {
//            alertAction in
//            callback(false)
//        }))
//
//        alert.addAction(UIAlertAction(title: defaultButtonTitle, style: .default, handler: {
//            alertAction in
//            callback(true)
//        }))
//        alert.view.tintColor = UIColor.mainAppColor()
//        self.present(alert, animated: true, completion: nil)
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "TwoButtonAlertController") as! TwoButtonAlertController
        controller.alertTitle = title
        controller.alertMessage = message
        controller.alertCancelButtonTitle = cancelButtonTitle
        controller.alertDefualtButtonTitle = defaultButtonTitle
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
    }
    
    
     func showLanguageAlert(callback: @escaping (_ valid: Bool,_ language: String) -> ()) {
        let storyboard = UIStoryboard(name: "Alerts", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "ChangeLanguageAlert") as! ChangeLanguageAlert
        controller.buttonAction = callback
        present(controller, animated: true, completion: nil)
    }
    
    
   
    func dismissRingIndecator(){
        DispatchQueue.main.async {
            SVProgressHUD.dismiss()
        }
    }
}



extension UIColor {
    static func mainAppColor() -> UIColor {
        return UIColor(hexString: "#2D6330")
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}


extension String {
    func IsValidString() -> Bool {
        if trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }else { return true }
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}

@IBDesignable extension UIView {
    @IBInspectable var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}


extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize
        
        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                     y: locationOfTouchInLabel.y - textContainerOffset.y);
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
}



