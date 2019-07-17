
import UIKit
import MapKit
import SVProgressHUD

class ContactUsController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var collectionView1: UICollectionView!
    @IBOutlet weak var mapView1: MKMapView!

    lazy var EGICLocationCoordinates = CLLocationCoordinate2D(latitude: CLLocationDegrees(EGICLatitude), longitude: CLLocationDegrees(EGICLongitude))
    var EGICLongitude: Float = -0.1275
    var EGICLatitude: Float = 51.507222
    var name: String = "EGICName".localized
    var Address: String = "EGICAddress".localized
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
         centerMapOnLocation()
         addAnnotation()
    }
    
    let array: [Contact] = {
        let contact1 = Contact(title: "Hotline".localized, color: UIColor.orange, number: "19678", image: "ContactUs1")
        let contact2 = Contact(title: "Tel".localized, color: UIColor.gray, number: "20223666500", image: "ContactUs2")
        let contact3 = Contact(title: "Email".localized, color: UIColor.blue, number: "info@egic.com.eg", image: "ContactUs3")
        return [contact1, contact2, contact3]
    }()
    
    func call(number: String){
        let encodedPhoneNumber = number.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let number = URL(string: "tel://" + "\(encodedPhoneNumber!)")
        UIApplication.shared.open(number!)
    }
    
    func email(email: String){
        let emailURL = URL(string: "mailto:\(email)")
        UIApplication.shared.open(emailURL!)
    }
    
    func setupNavigationBar(){
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Contact".localized
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.darkGray]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        SVProgressHUD.setupView()
        
        collectionView1.delegate = self
        collectionView1.dataSource = self
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
    
    
    // MARK-: Maps Functions
    /******************************************************************************/
    @objc func centerMapOnLocation() {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0100, longitudeDelta: 0.0100)
        let region = MKCoordinateRegion.init(center: EGICLocationCoordinates, span: span)
        mapView1.setRegion(region, animated: true)
    }
    func addAnnotation(){
        let hallAnnotation = CustomPointAnnotation()
        hallAnnotation.title = self.name
        hallAnnotation.subtitle = self.Address
        hallAnnotation.coordinate = EGICLocationCoordinates
        mapView1.addAnnotation(hallAnnotation)
        hallAnnotation.imageName = UIImage(named: "HallLocationICON777")
    }
    
    func openInExternalMaps(){
        let regionDistance:CLLocationDistance = 10000
        let regionSpan = MKCoordinateRegion(center: EGICLocationCoordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: EGICLocationCoordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = self.name
        mapItem.openInMaps(launchOptions: options)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is CustomPointAnnotation else { return nil }
        let reuseId = "Location"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            annotationView!.canShowCallout = true
        }
        else {
            annotationView!.annotation = annotation
        }
        
        let pinImage = UIImage(named: "EGICLocationICON")
        let size = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        annotationView!.canShowCallout = true
        return annotationView
    }

}

