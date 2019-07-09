
import UIKit

class CategoriesCell: UICollectionViewCell {
    var category: Categories? {
        didSet{
            guard let bassedCategory = category else { return }
            
            self.title.text = bassedCategory.title
            let stringUrl = bassedCategory.image
            let downloadURL = stringUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let url = URL(string: downloadURL!)
            image.kf.indicatorType = .activity
            image.kf.setImage(with: url)
        }
    }
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}
