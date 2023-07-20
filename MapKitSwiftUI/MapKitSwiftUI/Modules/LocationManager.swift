//
//  LocationManager.swift
//  MapKitSwiftUI
//
//  Created by Satoritech44 on 19/07/23.
//

import Foundation
import MapKit
class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    var region=MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 0, longitude: 0), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    var current:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var pins:[PinAnnotation]=[]
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    

    func startUpdatingLocation() {
        checkLocationAuthorization()
        locationManager.startUpdatingLocation()
    }
    private func checkLocationAuthorization() {
        switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied:
                // Handle restricted or denied authorization
                break
            case .authorizedWhenInUse, .authorizedAlways:
                break
            @unknown default:
                break
            }
        }



    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }
    
    func getCurrent()->CLLocationCoordinate2D{
        return self.current
    }

}
extension LocationManager:CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        // Do something with the location
        current = location.coordinate
        region=MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.latitude), span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
        pins.append(PinAnnotation(coordinate: location.coordinate))
        
        stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // Handle location update errors
    }
        func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
            checkLocationAuthorization()
        }
}
