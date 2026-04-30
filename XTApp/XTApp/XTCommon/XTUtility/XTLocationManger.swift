//
//  XTLocationManger.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import CoreLocation
import Foundation

@objcMembers
@objc(XTLocationManger)
class XTLocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = XTLocationManager()
    private var managerStorage: CLLocationManager?

    dynamic var xt_latitude: String?
    dynamic var xt_longitude: String?

    @objc(LBSBlock)
    dynamic var lbsBlock: XTBlock?

    @objc(LBSInfoBlock)
    dynamic var lbsInfoBlock: (([AnyHashable: Any], Bool) -> Void)?

    @objc class func xt_share() -> XTLocationManager {
        shared
    }

    @objc func xt_canLocation() -> Bool {
        let denied = CLLocationManager.locationServicesEnabled() && CLLocationManager.authorizationStatus() == .denied
        return !denied
    }

    @objc func xt_startLocation() -> Bool {
        guard xt_canLocation() else {
            return false
        }
        if manager.responds(to: #selector(CLLocationManager.requestAlwaysAuthorization)) {
            NSLog("requestAlwaysAuthorization")
            manager.requestAlwaysAuthorization()
        }
        if manager.responds(to: #selector(CLLocationManager.requestWhenInUseAuthorization)) {
            NSLog("requestAlwaysAuthorization")
            manager.requestWhenInUseAuthorization()
        }
        manager.startUpdatingLocation()
        return true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        managerStorage?.stopUpdatingLocation()
        managerStorage?.delegate = nil
        managerStorage = nil

        guard let location = locations.last else {
            lbsBlock?()
            lbsInfoBlock?([:], false)
            return
        }

        let coordinate = location.coordinate
        xt_latitude = String(format: "%f", coordinate.latitude)
        xt_longitude = String(format: "%f", coordinate.longitude)
        lbsBlock?()

        guard lbsInfoBlock != nil else {
            return
        }

        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] placemarks, _ in
            guard let self else { return }
            for placemark in placemarks ?? [] {
                let province = self.xtLocationString(placemark.administrativeArea)
                let city = self.xtLocationString(placemark.locality)
                let dic: [AnyHashable: Any] = [
                    "XTCountry": self.xtLocationString(placemark.country),
                    "XTCountryCode": self.xtLocationString(placemark.isoCountryCode),
                    "XTProvince": province.isEmpty ? city : province,
                    "XTCity": city.isEmpty ? province : city,
                    "XTRegion": self.xtLocationString(placemark.subLocality),
                    "XTStreet": self.xtLocationString(placemark.name),
                    "XTLatitude": self.xtLocationString(self.xt_latitude),
                    "XTLongitude": self.xtLocationString(self.xt_longitude)
                ]
                self.lbsInfoBlock?(dic, true)
                return
            }
            self.lbsInfoBlock?([:], false)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        lbsBlock?()
        lbsInfoBlock?([:], false)
    }

    private var manager: CLLocationManager {
        if managerStorage == nil {
            let locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            managerStorage = locationManager
        }
        return managerStorage!
    }

    private func xtLocationString(_ value: Any?) -> String {
        guard let value, !(value is NSNull) else { return "" }
        if let string = value as? String {
            return string
        }
        return "\(value)"
    }
}
