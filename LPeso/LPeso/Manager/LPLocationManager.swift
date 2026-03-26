//
//  LPLocationManager.swift
//  LPeso
//
//  Created by Kiven on 2024/10/30.
//

let Location = LPLocationManager.shared

import CoreLocation

class LPLocationManager: NSObject {
    
    static let shared = LPLocationManager()
    private var locationManager = CLLocationManager()
        
    var locationResult:((Bool,[String:Any]?) -> Void)?
    
    var lp_longitude:CGFloat = 0.0
    var lp_latitude:CGFloat = 0.0
    
    //start Location
    func startLocation(){
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.startUpdatingLocation()
    }
    
    //get LocationInfo
    func getLocationInfo(result:@escaping ((Bool,[String:Any]?) -> Void)){
        self.locationResult = result
        currentLocationState()
        startLocation()
    }
    
    private func uploadLocation(info:[String:Any]) {
        locationManager.stopUpdatingLocation()
        self.locationResult?(true,info)
        self.locationResult = nil
    }
    
    private func currentLocationState(){
        var status: CLAuthorizationStatus
        if #available(iOS 14.0, *) {
            status = locationManager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        switch status {
        case .denied,.restricted:
            print("k-- Location denied")
            self.locationResult?(false,nil)
            self.locationResult = nil
        default:
            break;
        }
    }
    
}


// MARK: - CLLocationManagerDelegate
extension LPLocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("didUpdateLocations")
        guard let location = locations.last else { return }
        
        lp_latitude = location.coordinate.latitude
        lp_longitude = location.coordinate.longitude
        
        let geocoder = CLGeocoder()
        let geocoderLocation = CLLocation(latitude: lp_latitude, longitude: lp_longitude)
        geocoder.reverseGeocodeLocation(geocoderLocation) { [weak self] (array, error) in
            guard let `self` = self else { return }
            if let array, !array.isEmpty {
                if let placemark = array.first {
                    let countryCode = placemark.isoCountryCode ?? ""
                    let country = placemark.country ?? ""
                    
                    let city = placemark.locality ?? ""
                    let province = placemark.administrativeArea ?? city
                    let district = placemark.subLocality ?? placemark.locality ?? placemark.administrativeArea ?? ""
                    
                    var street = placemark.thoroughfare ?? ""
                    if let subStreet = placemark.subThoroughfare {
                        street += subStreet
                    }
                    
                    let dic:[String:Any] = ["PTUHangari": province,
                                            "PTULullabyi": countryCode,
                                            "PTULiverishi": country,
                                            "PTUReconfirmationi": street,
                                            "PTUOutfalli": lp_latitude,
                                            "PTUAnisodonti": lp_longitude,
                                            "PTUCytospectrophotometryi": city,
                                            "PTUInfecti": district
                    ]
                    self.uploadLocation(info: dic)
                    
                }
            }
            
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error:\(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("k-- locationManagerDidChangeAuthorization")
        currentLocationState()
    }
}
