
import UIKit
import Kingfisher
import SVProgressHUD

class LeftMenuController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    weak var homeController: HomeController?
    let cellId = "cellId"
    let settingOptions: [[String]] = [
        ["Home".localized,"LeftMenu0"],
        ["Products".localized,"LeftMenu1"],
        ["Calculate".localized,"LeftMenu2"],
        ["Stores".localized,"LeftMenu3"],
        ["Social".localized,"LeftMenu4"],
        ["About".localized,"LeftMenu5"],
        ["Contact".localized,"LeftMenu6"],
        ["lang".localized, "LeftMenu7"],
        ["Logout".localized,"LeftMenu8"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadUserInfo()
    }
    
    // MARK :- Collectionview Methods
    /********************************************************************************************/
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settingOptions.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! LeftMenuCell
        
        cell.titleLabel.text = settingOptions[indexPath.item][0]
        cell.iconImage.image = UIImage(named: "\(settingOptions[indexPath.item][1])")?.withRenderingMode(.alwaysTemplate)
        cell.iconImage.tintColor = UIColor.black
        cell.backgroundColor = UIColor(hexString: "#F1F1F1")
        cell.layer.cornerRadius = 0
        
        if indexPath.item == settingOptions.count-1 {
            cell.lineView.isHidden = true
        }else {
            cell.lineView.isHidden = false
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let x = min(view.frame.height/12, 80)
        let cellHeight = max(x, 50)
        let finalCellHeight = min(cellHeight, 70)
        return CGSize(width: view.frame.width, height: finalCellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.item {
        case 0:
            self.dismiss(animated: true) {
                self.homeController?.goHome()
            }
            return
        case 1:
            self.dismiss(animated: true) {
                self.homeController?.goCategories()
            }
            return
        case 2:
            
            
       
            return
        case 3:
            self.dismiss(animated: true) {
                self.homeController?.goStores()
            }
            return
        case 4:
            self.dismiss(animated: true) {
                self.homeController?.goSocial()
            }
            return
        case 5:
             self.dismiss(animated: true) {
                self.homeController?.goAboutUs()
             }
            return
        case 6:
             self.dismiss(animated: true) {
               self.homeController?.goContactUs()
             }
            return
        case 7:
            self.dismiss(animated: true) {
               self.homeController?.changeLanguage()
            }
            return
        case 8:
            self.dismiss(animated: true) {
                self.homeController?.signOut()
            }
            return
        default:
            return
        }
    }
    
    //   MARK :- Helper Methods
/**********************************************************************************************/
    func loadUserInfo(){
        if (UserDefaults.standard.object(forKey: "loggedInClient") != nil) {
            nameLabel.text = HelperData.sharedInstance.loggedInClient.name
        }
    }
    func setupNavigationBar(){
        self.navigationController?.isNavigationBarHidden = true
        view.backgroundColor = UIColor.white
    }
    
    //   MARK :- Components
    /**********************************************************************************************/
    private func setupViews(){
        guard let window = UIApplication.shared.keyWindow else { return }
        let topPadding =  window.safeAreaInsets.top
        let bottomPadding = window.safeAreaInsets.bottom
        let viewHeight = window.frame.height-topPadding-bottomPadding
        SVProgressHUD.setupView()
        
        let x = min(viewHeight/8, 350)
        let headerHeight = max(x, 140)
        let finalHeaderHeight = min(headerHeight, 200)
        view.addSubview(headerView)
        headerView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor,size: CGSize(width: 0, height: finalHeaderHeight))
        
        headerView.addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
      
        
        iconImage.topAnchor.constraint(equalTo: headerView.topAnchor, constant: topPadding).isActive = true
        iconImage.centerXAnchor.constraint(equalTo: headerView.centerXAnchor, constant: 0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 75).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        
        headerView.addSubview(stackview)
        stackview.anchor(top: nil, leading: headerView.leadingAnchor, bottom: headerView.bottomAnchor, trailing: headerView.trailingAnchor, padding: .init(top: 0, left: 10, bottom: headerHeight/10, right: 10))
        
        stackview.addArrangedSubview(nameLabel)
        
        nameLabel.anchor(top: nil, leading: stackview.leadingAnchor, bottom: nil, trailing: stackview.trailingAnchor)
    
        
        
        view.addSubview(collectionView)
        collectionView.anchor(top: headerView.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        collectionView.register(LeftMenuCell.self, forCellWithReuseIdentifier: cellId)
    }
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionHeadersPinToVisibleBounds = false
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor(hexString: "#F1F1F1")
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = false
        cv.showsVerticalScrollIndicator = false
        cv.showsHorizontalScrollIndicator = false
        cv.alwaysBounceVertical = true
        return cv
    }()
    let headerView: UIView = {
        let iv = UIView()
        iv.backgroundColor = UIColor.mainAppColor()
        return iv
    }()
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "ProfileICON777")
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let stackview: UIStackView = {
        let sv = UIStackView()
        sv.axis  = NSLayoutConstraint.Axis.vertical
        sv.distribution  = UIStackView.Distribution.equalCentering
        sv.alignment = UIStackView.Alignment.center
        sv.spacing = 3
        return sv
    }()
    let nameLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Name Name Name"
        titleL.font = UIFont.boldSystemFont(ofSize: 15)
        titleL.textColor = UIColor.white
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    
}


