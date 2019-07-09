
import UIKit
import SVProgressHUD
import WebKit

class ProductDetailsController: UIViewController {
    @IBOutlet weak var webView1: WKWebView!
    var bassedUrl: String?
    
    @IBOutlet weak var webView2: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        webView1.navigationDelegate = self
        webView1.scrollView.delegate = self
        openURL()
    }
    
    func openURL(){
        let downloadURL = bassedUrl!.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: downloadURL!)
        let finalRequest = URLRequest(url: url!)
        //   webView1.load(finalRequest)
        
        webView2.loadRequest(finalRequest)
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Products".localized
        SVProgressHUD.setupView()

        let leftButton = UIButton(type: .custom)
        leftButton.setImage(UIImage(named: "BackICON")?.withRenderingMode(.alwaysTemplate).imageFlippedForRightToLeftLayoutDirection(), for: .normal)
        leftButton.tintColor = UIColor.mainAppColor()
        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        leftButton.addTarget(self, action: #selector(leftButtonAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftButton)
    }
    @objc func leftButtonAction(){
        navigationController?.popViewController(animated: true)
    }
}


extension ProductDetailsController: WKNavigationDelegate, UIScrollViewDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       
    }
}
