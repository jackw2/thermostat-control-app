//
//  MapOverwatchView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI
import MapKit

struct MapOverwatchView: View {
    var locationManager = CLLocationManager()
    @State private var cameraPosition: MapCameraPosition = .automatic
    @AppStorage("homeTitle") private var homeTitle: String = "The White House"
    @AppStorage("homeLatitude") private var homeLatitude: Double = 38.897957
    @AppStorage("homeLongitude") private var homeLongitude: Double = -77.036560
    @State private var homeAddress:CLLocationCoordinate2D? = nil
    
    var body: some View {
        Map(position: $cameraPosition) {
            UserAnnotation()
            if let homeAddress = homeAddress {
                Marker(homeTitle, coordinate: homeAddress)
                    .tint(.blue)
                MapCircle(center: homeAddress, radius: 1000)
                    .stroke(.blue.opacity(0.5), lineWidth: 5)
                    .foregroundStyle(.white.opacity(0.2))
                    .mapOverlayLevel(level: .aboveLabels)
            }
        }
        .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
        .onAppear() {
            locationManager.requestAlwaysAuthorization()
            homeAddress = CLLocationCoordinate2D(latitude: homeLatitude, longitude: homeLongitude)
        }
    }
}

#Preview {
    MapOverwatchView()
}

