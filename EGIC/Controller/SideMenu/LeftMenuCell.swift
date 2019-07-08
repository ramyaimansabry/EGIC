

import UIKit


class LeftMenuCell: UICollectionViewCell{
    override init(frame: CGRect){
        super.init(frame: frame)
        setupViews()
    }
    func setupViews(){
        addSubview(iconImage)
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        iconImage.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
        iconImage.widthAnchor.constraint(equalToConstant: 19).isActive = true
        iconImage.heightAnchor.constraint(equalToConstant: 19).isActive = true
        
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        
        if "currentLang".localized == "en" {
            iconImage.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width/16).isActive = true
            titleLabel.leftAnchor.constraint(equalTo: iconImage.rightAnchor, constant: frame.width/18).isActive = true
            
        }else {
            iconImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -frame.width/16).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: iconImage.leftAnchor, constant: -frame.width/18).isActive = true
        }
        

        addSubview(lineView)
        lineView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,size: CGSize(width: 0, height: 0.6))
    }
    let iconImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "logo1")?.withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.black
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = UIColor.clear
        return iv
    }()
    let titleLabel: UILabel = {
        let titleL = UILabel()
        titleL.text = "Label"
        titleL.font = UIFont.systemFont(ofSize: 14)
        titleL.textColor = UIColor.black
        titleL.textAlignment = .center
        titleL.numberOfLines = 0
        titleL.backgroundColor = UIColor.clear
        return titleL
    }()
    let lineView: UIView = {
        let li = UIView()
        li.backgroundColor = UIColor.gray
        return li
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


