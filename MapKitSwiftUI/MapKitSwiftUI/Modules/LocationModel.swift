//
//  LocationModel.swift
//  MapKitSwiftUI
//
//  Created by Satoritech44 on 19/07/23.
//

import CoreLocation

struct PinAnnotation: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}
