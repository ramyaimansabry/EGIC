
import UIKit
import SVProgressHUD
import WebKit

class ProductDetailsController: UIViewController {
    @IBOutlet weak var webView2: WKWebView!
    @IBOutlet weak var DetailedView: UIView!
    @IBOutlet weak var titleHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var webView1: WKWebView!
    @IBOutlet weak var planImage: UIImageView!
    @IBOutlet weak var viewImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var closeButton: UIButton!
    var bassedProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupComponent()
        setupProductInfo()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        animateView()
    }
    
    func setupProductInfo(){
        segmentControl.selectedSegmentIndex = 0
        
        titleLabel.text = bassedProduct?.title
        
        let stringUrl = bassedProduct?.image
        let downloadURL = stringUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: downloadURL!)
        viewImage.kf.indicatorType = .activity
        viewImage.kf.setImage(with: url)
        
        let stringUrl2 = bassedProduct?.plan
        let downloadURL2 = stringUrl2!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url2 = URL(string: downloadURL2!)
        planImage.kf.indicatorType = .activity
        planImage.kf.setImage(with: url2)
        
        if (bassedProduct?.dimensions.contains(".csv"))!{
            openURL(stringURL: (bassedProduct?.dimensions)!)
        }
        
        if bassedProduct?.x3d != nil {
            if (bassedProduct?.x3d!.contains(".html"))!{
                openURL2(stringURL: (bassedProduct?.x3d)!)
            }
        }
        
    }
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            viewImage.alpha = 1
            planImage.alpha = 0
            webView1.alpha = 0
            webView2.alpha = 0
            break
        case 1:
            viewImage.alpha = 0
            planImage.alpha = 1
            webView1.alpha = 0
            webView2.alpha = 0
            break
        case 2:
            viewImage.alpha = 0
            planImage.alpha = 0
            webView1.alpha = 1
            webView2.alpha = 0
            break
        case 3:
            viewImage.alpha = 0
            planImage.alpha = 0
            webView1.alpha = 0
            webView2.alpha = 1
            break
        default:
            break
        }
    }
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func openURL(stringURL: String){
        let downloadURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: downloadURL!)
        let finalRequest = URLRequest(url: url!)
        webView1.load(finalRequest)
    }
    func openURL2(stringURL: String){
        let downloadURL = stringURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: downloadURL!)
        let finalRequest = URLRequest(url: url!)
        webView2.load(finalRequest)
    }
    
    func setupComponent(){
        titleHeightConstraint.constant = estimateFrameForTitleText((bassedProduct?.title)!).height + 25
        titleLabel.layoutIfNeeded()
        
        SVProgressHUD.setupView()
        
        closeButton.setTitle("closeButton".localized, for: .normal)
        
        segmentControl.apportionsSegmentWidthsByContent = true
        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "View".localized, at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Plan".localized, at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "Spec".localized, at: 2, animated: true)
        segmentControl.insertSegment(withTitle: "3d".localized, at: 3, animated: true)
        
        segmentControl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        segmentControl.tintColor = .clear
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.gray
            ], for: .normal)
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.mainAppColor()
            ], for: .selected)
        
        webView1.navigationDelegate = self
        webView1.scrollView.delegate = self
        webView2.navigationDelegate = self
        webView2.scrollView.delegate = self
        
    }
    func animateView() {
        DetailedView.alpha = 0
        self.DetailedView.frame.origin.y = self.DetailedView.frame.origin.y + 50
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            self.DetailedView.alpha = 1.0
            self.DetailedView.frame.origin.y = self.DetailedView.frame.origin.y - 50
        })
    }
    
    
    // MARK : Text size
    /*****************************************************************************************/
    fileprivate func estimateFrameForTitleText(_ text: String) -> CGRect {
        let width = view.frame.width-80
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: convertToOptionalNSAttributedStringKeyDictionary([convertFromNSAttributedStringKey(NSAttributedString.Key.font): UIFont.boldSystemFont(ofSize: 15)]), context: nil)
    }
    fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
        guard let input = input else { return nil }
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
    }
    fileprivate func convertFromNSAttributedStringKey(_ input: NSAttributedString.Key) -> String {
        return input.rawValue
    }
    
}


extension ProductDetailsController: WKNavigationDelegate, UIScrollViewDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       
    }
}
