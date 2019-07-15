

import UIKit
import SVProgressHUD

class BathroomController: UIViewController {
    @IBOutlet weak var drainageLabel: UILabel!
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var areaTextField: UITextField!
    @IBOutlet weak var drainageTextField: UITextField!
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var calculateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCOmponent()
    }
    
    let drainageArray: [[String]] = [["kessel","kessel"],["shome","Smart Home"]]
    let areaArray: [String] = ["100x180","200x300","300x500","400x600"]
    let collectionArray: [[String]] = [["","B1".localized],
                                       ["","B2".localized],
                                       ["tub","B3".localized],
                                       ["heater","B4".localized],
                                       ["wmachine","B5".localized],
                                       ["bidet","B6".localized],
                                       ["cabin1","B7".localized],
                                       ["cabin2","B8".localized]]
    var selectedItems: [Int] = [1,1,0,0,0,0,0,0]
    
    
    func calculateEstimation(formula: String, drain: String){
        SVProgressHUD.show()
        ApiManager.sharedInstance.calculateBathroom(formula: formula, drain: drain, selectedItems: selectedItems) { (valid, msg, data, code) in
            self.dismissRingIndecator()
            if valid {
                self.showResult(result: data!)
            }else {
                if code == -3 {
                    HelperData.sharedInstance.signOut()
                    self.show1buttonAlert(title: "Error".localized, message: "tokenError".localized, buttonTitle: "OK", callback: {
                        HelperData.sharedInstance.signOut()
                        self.dismiss(animated: true, completion: nil)
                    })
                    
                }else {
                    self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK", callback: {
                    })
                }
            }
        }
    }
    
    func showResult(result: Calculate){
        let storyboard = UIStoryboard(name: "SideMenu", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BillController") as! BillController
        controller.bassedResult = result
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func calculateButtonAction(_ sender: UIButton) {
        let drain = drainageArray[drainagePickerView.selectedRow(inComponent: 0)][1]
        let formula = areaArray[areaPickerView.selectedRow(inComponent: 0)]
        calculateEstimation(formula: formula, drain: drain)
    }
    
    func setupCOmponent(){
        drainageLabel.text = "Drainage".localized
        areaLabel.text = "Area".localized
        calculateButton.setTitle("CalculateButton".localized, for: .normal)
        
        collectionView1.register(UINib(nibName: "CalculateCell", bundle: nil), forCellWithReuseIdentifier: "CalculateCell")
        collectionView1.delegate = self
        collectionView1.dataSource = self
        drainageTextField.inputView = drainagePickerView
        areaTextField.inputView = areaPickerView
        drainageTextField.text = drainageArray[0][0]
        areaTextField.text = areaArray[0]
        
        collectionView1.allowsMultipleSelection = true
        collectionView1.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        collectionView1.selectItem(at: IndexPath(item: 1, section: 0), animated: true, scrollPosition: .top)
        
        SVProgressHUD.setupView()
    }
    
    
    lazy var drainagePickerView: UIPickerView = {
        let pk = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 160))
        pk.backgroundColor = UIColor.white
        pk.delegate = self
        pk.dataSource = self
        return pk
    }()
    lazy var areaPickerView: UIPickerView = {
        let pk = UIPickerView(frame: CGRect(x: 0, y: 0, width: 0, height: 160))
        pk.backgroundColor = UIColor.white
        pk.delegate = self
        pk.dataSource = self
        return pk
    }()
}



extension BathroomController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: CalculateCell = collectionView1.dequeueReusableCell(withReuseIdentifier: "CalculateCell", for: indexPath) as! CalculateCell
      
        cell.label.text = collectionArray[indexPath.row][1]
        cell.makeShadow(cornerRadius: 5)
        if cell.isSelected {
            cell.backgroundColor = UIColor.mainAppColor()
            cell.image.tintColor = UIColor.white
        }else {
            cell.backgroundColor = UIColor.lightGray.withAlphaComponent(0.4)
            cell.image.tintColor = UIColor.mainAppColor()
        }
        
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.isUserInteractionEnabled = false
        }else {
            cell.isUserInteractionEnabled = true
        }
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidth = (view.frame.width-50)/2
        let finalWidth = min(200, cellWidth)
        let cellHeight = 0.37*finalWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView1.cellForItem(at: indexPath)
        if cell?.isSelected == false {
            self.selectedItems[indexPath.row] = 0
        }else {
            self.selectedItems[indexPath.row] = 1
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView1.cellForItem(at: indexPath)
        if cell?.isSelected == false {
            self.selectedItems[indexPath.row] = 0
        }else {
            self.selectedItems[indexPath.row] = 1
        }
    }
    
    
    // MARK:- Picker View
/****************************************************************************************/
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == drainagePickerView {
            return drainageArray.count
        }else {
            return areaArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == drainagePickerView {
          return drainageArray[row][1]
        }else {
            return areaArray[row]
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == drainagePickerView {
          self.drainageTextField.text = drainageArray[drainagePickerView.selectedRow(inComponent: 0)][1]
        }else {
            self.areaTextField.text = areaArray[areaPickerView.selectedRow(inComponent: 0)]
        }
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
}
