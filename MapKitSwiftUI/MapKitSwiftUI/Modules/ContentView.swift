//
//  ContentView.swift
//  MapKitSwiftUI
//
//  Created by Satoritech44 on 19/07/23.
//

import SwiftUI

import MapKit

struct ContentView: View {
    @StateObject private var manager=LocationManager()
    @State private var userTrackingMode: MapUserTrackingMode = .follow
    var body: some View {
        VStack {
            Map(coordinateRegion: $manager.region, interactionModes: .all, showsUserLocation: true, userTrackingMode: $userTrackingMode,annotationItems: manager.pins){ pin in
               MapMarker(coordinate: pin.coordinate,tint: .black)
            }.onAppear{
                    userTrackingMode = .follow
            }
           
            Button(action: {
                userTrackingMode = .follow
                manager.startUpdatingLocation()
                
            }) {
                Image(systemName: "location.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
