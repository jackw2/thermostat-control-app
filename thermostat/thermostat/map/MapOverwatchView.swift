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
    @EnvironmentObject var location: LocationModel

    var body: some View {
        let homeCoords = CLLocationCoordinate2D(latitude: settings.homeLatitude, longitude: settings.homeLongitude)
        
        return Map(position: $cameraPosition) {
            UserAnnotation()
            Marker(settings.homeTitle, coordinate: homeCoords)
                .tint(location.inRadius ? .green: .red)
            MapCircle(center: homeCoords, radius: settings.homeRadiusInMeters)
                .stroke(location.inRadius ? Color.green.opacity(0.5) : Color.red.opacity(0.5), lineWidth: 5)
                .foregroundStyle(location.inRadius ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .mapOverlayLevel(level: .aboveLabels)
        }
        .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
    }
}

#Preview {
    struct PreviewWrapper: View {
        @StateObject private var settings: SettingsModel
        @StateObject private var thermostat: ThermostatModel
        @StateObject private var location: LocationModel
        
        init() {
            let settings = SettingsModel.shared
            let thermostat = ThermostatModel(settings: settings)
            let location = LocationModel(settings: settings, thermostat: thermostat)
            
            _settings = StateObject(wrappedValue: settings)
            _thermostat = StateObject(wrappedValue: thermostat)
            _location = StateObject(wrappedValue: location)
        }
        
        var body: some View {
            MapOverwatchView()
                .environmentObject(settings)
                .environmentObject(thermostat)
                .environmentObject(location)
        }
    }
    return PreviewWrapper()
}
