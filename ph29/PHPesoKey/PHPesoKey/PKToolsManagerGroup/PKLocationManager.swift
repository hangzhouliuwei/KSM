//
//  PKLocationManager.swift
//  PHPesoKey
//
//  Created by liuwei on 2025/2/12.
//

import UIKit
import CoreLocation

typealias PKNoneBlock = () -> Void
typealias PKBoolBlock = (_ result: Bool) -> Void
typealias PKDicBlock = (_ result: [String: Any]) -> Void
typealias PKStingBlock = (_ result: String) -> Void
typealias PKDoubleBoolBlock = (_ result: Bool,Bool) -> Void
typealias PKJSonBlock = (_ result: JSON) -> Void

class PKLocationManager:NSObject,CLLocationManagerDelegate {
    
    static let shardManager = PKLocationManager()
    private var locationManager = CLLocationManager()
    private var isLocation = false
    private var resultsLoanDataBlock: PKDicBlock?
    private var resultsPermissionBlock: PKBoolBlock?
    var  pklatitude:Double = 0.0
    var  pklongitude: Double  = 0.0
    
    func startLocation(results:@escaping PKBoolBlock){
        isLocation = false
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        resultsPermissionBlock = results
        updataLocationPermissions()
    }
   
    func getlocationInformation(resultsDic:@escaping PKDicBlock) {
        resultsLoanDataBlock = resultsDic
    }
    
    private func positioningResult(dict: [String: Any]) {
        locationManager.stopUpdatingLocation()
        isLocation = false
        resultsLoanDataBlock?(dict)
    }
    
    
    private func updataLocationPermissions(){
        let roots: CLAuthorizationStatus = {
            if #available(iOS 14.0, *) {
                return locationManager.authorizationStatus
            } else {
                return CLLocationManager.authorizationStatus()
            }
        }()
        
        switch roots {
        case .denied, .restricted:
            resultsPermissionBlock?(false)
        case .authorizedWhenInUse, .authorizedAlways:
            resultsPermissionBlock?(true)
        default:
            break
        }
    }
    
//    private func handlePositioningResult(with placemark: CLPlacemark?) {
//           locationManager.stopUpdatingLocation()
//           
//           guard let placemark = placemark else {
//               resultsLoanDataBlock?([:])
//               return
//           }
//           
//           let resultDic: [String: Any] = [
//            "bDCKNWDOccasionalismMmpxUqZ": placemark.administrativeArea ?? "",
//            "yCStZxGInimitableDhqDnCw": placemark.isoCountryCode ?? "",
//            "vfOnmFDLippenPwGCuiI": "\(placemark.thoroughfare ?? "")\(placemark.subThoroughfare ?? "")",
//            "EYKwmOjNumismaticFcLRZjO": self.pklatitude,
//            "gVHCbxOSingularizeOaDpSvj": self.pklongitude,
//            "mlsqAzMRepaidVXBZOxj": placemark.country ?? "",
//            "HzYPdLPWhiffJwKpYKw": placemark.locality ?? "",
//            "nnngqQCLorryQZItaRm": placemark.subAdministrativeArea ?? placemark.subLocality ?? ""
//           ]
//           
//           resultsLoanDataBlock?(resultDic)
//       }
       
    
    //MARK: -  location delegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        guard !isLocation else { return }
        isLocation = true
        
        pklatitude = location.coordinate.latitude
        pklongitude = location.coordinate.longitude
        
        let geocoder = CLGeocoder()
        let locationForGeocoding = CLLocation(latitude: pklatitude, longitude: pklongitude)
        
        geocoder.reverseGeocodeLocation(locationForGeocoding) { [weak self] placemarks, error in
            guard let self = self else { return }
            
    
            if let error = error {
                print("reverseGeocodeLocation Error: \(error.localizedDescription)")
                self.positioningResult(dict: [:])
                return
            }
            
            guard let placemark = placemarks?.first else {
                self.positioningResult(dict: [:])
                return
            }
            
            let resultDic: [String: Any] = [
                "bDCKNWDOccasionalismMmpxUqZ": placemark.administrativeArea ?? "",
                "yCStZxGInimitableDhqDnCw": placemark.isoCountryCode ?? "",
                "vfOnmFDLippenPwGCuiI": "\(placemark.thoroughfare ?? "")\(placemark.subThoroughfare ?? "")",
                "EYKwmOjNumismaticFcLRZjO": self.pklatitude,
                "gVHCbxOSingularizeOaDpSvj": self.pklongitude,
                "mlsqAzMRepaidVXBZOxj": placemark.country ?? "",
                "HzYPdLPWhiffJwKpYKw": placemark.locality ?? "",
                "nnngqQCLorryQZItaRm": placemark.subAdministrativeArea ?? placemark.subLocality ?? ""
            ]
            self.positioningResult(dict: resultDic)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //print("Location Error: \(error.localizedDescription)")
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        updataLocationPermissions()
    }
}
