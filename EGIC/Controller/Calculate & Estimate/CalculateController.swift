
import UIKit
import SVProgressHUD

class CalculateController: UIViewController {
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var bathView: UIView!
    @IBOutlet weak var kitchenView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupComponent()
    }
    
    func setupComponent(){
        SVProgressHUD.setupView()
        segmentControl.removeAllSegments()
        segmentControl.insertSegment(withTitle: "Bath".localized, at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "Kit".localized, at: 1, animated: true)
        segmentControl.apportionsSegmentWidthsByContent = true
        segmentControl.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        segmentControl.tintColor = .clear
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 15),
            NSAttributedString.Key.foregroundColor: UIColor.gray
            ], for: .normal)
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 16),
            NSAttributedString.Key.foregroundColor: UIColor.mainAppColor()
            ], for: .selected)
    }
    @IBAction func segmentControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            bathView.alpha = 1
            kitchenView.alpha = 0
            break
        case 1:
            bathView.alpha = 0
            kitchenView.alpha = 1
            break
        default:
            break
        }
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Calculate".localized
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
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
