//
//  MapOverwatchView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import SwiftUI
import MapKit
struct MapOverwatchView: View {
    @State private var cameraPosition: MapCameraPosition = .automatic
    
    @EnvironmentObject var settings: SettingsModel
    var locationManager = CLLocationManager()

    var body: some View {
        let homeCoords = CLLocationCoordinate2D(latitude: settings.homeLatitude, longitude: settings.homeLongitude)
        
        return Map(position: $cameraPosition) {
            UserAnnotation()
            if let lastCoord = locationManager.location?.coordinate {
                Marker("Last Updated Location", coordinate: lastCoord)
            }
            
            Marker(settings.homeTitle, coordinate: homeCoords)
                .tint(.blue)
            MapCircle(center: homeCoords, radius: settings.homeRadiusInMeters)
                .stroke(.blue.opacity(0.5), lineWidth: 5)
                .foregroundStyle(.white.opacity(0.2))
                .mapOverlayLevel(level: .aboveLabels)
        }
        .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
        .onAppear() {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

#Preview {
    struct PreviewWrapper: View {
        @StateObject private var settings = SettingsModel.shared
        
        var body: some View {
            MapOverwatchView()
                .environmentObject(settings)
        }
    }
    return PreviewWrapper()
}
