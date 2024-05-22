//
//  MapPanelView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import MapKit
import SwiftUI

struct MapPanelView: View {
    @State private var address: String = ""
    
    var body: some View {
        VStack {
            TextField("Enter your home address", text: $address)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Map {
                Marker("Home", coordinate: CLLocationCoordinate2D(latitude: 40.7063, longitude: -74.1973))
//                let cir = MKCircle(center: CLLocationCoordinate2D(latitude: 40.7063, longitude: -74.1973), radius: 1000               )
//                addOverlay(cir)
            }
            .mapControlVisibility(.hidden)
        }
        //        .onAppear {
        //            getCoordinate(for: address)
        //        }
    }
    
    //    private func getCoordinate(for address: String) {
    //        let geocoder = CLGeocoder()
    //        geocoder.geocodeAddressString(address) { (placemarks, error) in
    //            if let error = error {
    //                print("Geocoding error: \(error.localizedDescription)")
    //            }
    //
    //            if let placemark = placemarks?.first {
    //                let coordinate = placemark.location?.coordinate
    //                if let coordinate = coordinate {
    //                    let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    //                    region = MKCoordinateRegion(center: coordinate, span: span)
    //                }
    //            }
    //        }
    //    }
}

#Preview {
    MapPanelView()
}
