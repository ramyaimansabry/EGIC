import UIKit
import SVProgressHUD
import MapKit


class StoresController: UIViewController {
    @IBOutlet weak var centerLocationButton: UIButton!
    @IBOutlet weak var mapView1: MKMapView!
    let locationManager = CLLocationManager()
    var storesArray = [Store]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        fetchStores()
    }
    func fetchStores(){
        SVProgressHUD.show()
        ApiManager.sharedInstance.loadStores { (valid, msg, stores) in
            self.dismissRingIndecator()
            if valid {
                self.storesArray = stores
                self.addAnnotations()
                self.checkLocationServices()
            }else {
                self.show1buttonAlert(title: "Error".localized, message: "LoadingHomeError".localized, buttonTitle: "OK", callback: {
                })
            }
        }
    }
    
    func addAnnotations(){
        for location in storesArray {
            if location.longitude.count != 1 && location.latitude.count != 1 {
                let annotation = CustomPointAnnotation()
                annotation.title = location.store
                annotation.subtitle = location.store
                annotation.imageName = UIImage(named: "EGICLocationICON")
                annotation.coordinate = CLLocationCoordinate2D(latitude: Double(location.latitude)!, longitude: Double(location.longitude)!)
                mapView1.addAnnotation(annotation)
            }
        }
    }
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let span = MKCoordinateSpan.init(latitudeDelta: 0.0200, longitudeDelta: 0.0200)
            let region = MKCoordinateRegion.init(center: location, span: span)
            mapView1.setRegion(region, animated: true)
        }
    }
    
    @IBAction func CenterLocationButtonAction(_ sender: UIButton) {
        centerViewOnUserLocation()
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Stores".localized
        SVProgressHUD.setupView()
        
        mapView1.delegate = self
        
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
