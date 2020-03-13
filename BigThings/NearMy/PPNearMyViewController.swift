//
//  PPNearMyViewController.swift
//  BigThings
//
//  Created by PP on 2019/11/8.
//  Copyright © 2019 PP. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class PPNearMyViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    fileprivate var locationManager = CLLocationManager()
    
    fileprivate var dataSource: [PPThingsVo] = [PPThingsVo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PPThingsVo.queryAllBigThings {[weak self] (value) in
            self?.dataSource = value
            self?.addAnnotation()
        }
        setupMapView()
        locationManager.delegate = self
        requestLocation()
    }
    
    fileprivate func setupMapView() {
        mapView.mapType = MKMapType.standard
        mapView.showsUserLocation = true
        mapView.userTrackingMode  = MKUserTrackingMode.followWithHeading
    }
    
    fileprivate func addAnnotation() {
        for item in dataSource {
            let annotation = MKPointAnnotation()
            annotation.title = item.name ?? ""
            annotation.subtitle = item.status ?? ""
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(item.latitude ?? "0") ?? 0.0, CLLocationDegrees(item.longitude ?? "") ?? 0.0)
            annotation.coordinate = coordinate
            mapView.addAnnotation(annotation)
        }
    }
    
    fileprivate func requestLocation() {
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        
        let status = CLLocationManager.authorizationStatus()
        
        switch status {
            
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            PromptView.show(message: "Has No Location Authorization")
        case .denied:
            PromptView.show(message: "Has No Location Authorization")
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
}

extension PPNearMyViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation.location!) { (placemarks: [CLPlacemark]?, error: Error?) in
            userLocation.title = placemarks?.last?.locality
            userLocation.subtitle = placemarks?.last?.name
        }
    }
}

extension PPNearMyViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .restricted:
            PromptView.show(message: "Has No Location Authorization")
        case .denied:
            PromptView.show(message: "Has No Location Authorization")
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

    }
}
