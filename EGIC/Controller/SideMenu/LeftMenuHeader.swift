//
//
//import UIKit
//
//class LeftMenuHeader: UICollectionViewCell {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        
//        addSubview(backgroundImage)
//        backgroundImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
//        
//        addSubview(iconImage)
//        iconImage.translatesAutoresizingMaskIntoConstraints = false
//        iconImage.topAnchor.constraint(equalTo: topAnchor, constant: frame.height/6).isActive = true
//        iconImage.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
//        iconImage.widthAnchor.constraint(equalToConstant: 75).isActive = true
//        iconImage.heightAnchor.constraint(equalToConstant: 75).isActive = true
//        
//        addSubview(nameLabel)
//        nameLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: frame.height/6, right: 10))
//    }
//    let iconImage: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "ProfileICON777")
//        iv.contentMode = .scaleAspectFit
//        iv.backgroundColor = UIColor.clear
//        return iv
//    }()
//    let backgroundImage: UIImageView = {
//        let iv = UIImageView()
//        iv.image = UIImage(named: "SideMenuImage")
//        iv.contentMode = .scaleAspectFill
//        iv.backgroundColor = UIColor.clear
//        return iv
//    }()
//    let nameLabel: UILabel = {
//        let titleL = UILabel()
//        titleL.text = "Name Name Name"
//        titleL.font = UIFont.boldSystemFont(ofSize: 15)
//        titleL.textColor = UIColor.white
//        titleL.textAlignment = .center
//        titleL.numberOfLines = 0
//        titleL.backgroundColor = UIColor.clear
//        return titleL
//    }()
//    
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
//
//
//
