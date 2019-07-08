import UIKit
import MapKit
import SVProgressHUD


extension StoresController: CLLocationManagerDelegate, MKMapViewDelegate {
    
    // MARK: - Map delegete
    /**************************************************************************************************/
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
        let size = CGSize(width: 35, height: 35)
        UIGraphicsBeginImageContext(size)
        pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        annotationView?.image = resizedImage
        annotationView!.canShowCallout = true
        annotationView!.rightCalloutAccessoryView = UIButton(type: .infoDark)
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        
        guard let annotation = view.annotation as? CustomPointAnnotation else {
            return
        }
        
        self.show2buttonAlert(title: "OpenExternalMap".localized, message: annotation.title ?? " ", cancelButtonTitle: "Cancel", defaultButtonTitle: "OK") { (defualt) in
            if defualt {
                
                let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                
                let StoreLocationCoordinates = CLLocationCoordinate2D(latitude: annotation.coordinate.latitude, longitude: annotation.coordinate.longitude)
                
                let placemark = MKPlacemark(coordinate: StoreLocationCoordinates, addressDictionary: nil)
                let mapItem = MKMapItem(placemark: placemark)
                mapItem.name = annotation.title
                mapItem.openInMaps(launchOptions: launchOptions)
            }
        }
    }
    
    
    
    
    // MARK: - Location delegete
    /**************************************************************************************************/
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        locationManager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        checkLocationAuthorization()
    }
    
    
    // MARK: - Location Authurization
    /*******************************************************************************************/
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
            centerLocationButton.isEnabled = true
        }
        else{ }
    }
    func setupLocationManager(){
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus(){
        case .authorizedAlways:
            break
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            centerViewOnUserLocation()
            break
        case .denied:
            self.show1buttonAlert(title: "Error".localized, message: "LocationError".localized, buttonTitle: "OK", callback: {
            })
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            self.show1buttonAlert(title: "Error".localized, message: "LocationError".localized, buttonTitle: "OK", callback: {
            })
            break
        }
    }
}
