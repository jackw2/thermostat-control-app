//
//  AddressSearchView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 5/19/24.
//

import CoreLocation
import MapKit
import SwiftUI

struct AddressSearchView: View {
    @State private var position = MapCameraPosition.automatic
    @State private var searchResults = [SearchResult]()
    @State private var selectedLocation: SearchResult?
    @State private var isSheetPresented: Bool = true
    @State private var scene: MKLookAroundScene?
    @State private var didSetAddress = false
    @Environment(SettingsModel.self) private var settingsModel
    
    var body: some View {
        Map(position: $position, selection: $selectedLocation) {
            ForEach(searchResults) { result in
                Marker(result.title, image: "mappin", coordinate: result.location)
                .tag(result)
            }
        }
        .ignoresSafeArea()
        .overlay(alignment: .bottom) {
            VStack {
                if didSetAddress == true {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .font(.largeTitle)
                        .opacity(didSetAddress ? 1 : 0)
                        .animation(.easeIn, value: 30)
                }
                if let selectedLocation = selectedLocation {
                    Button(action: {
                        settingsModel.homeTitle = selectedLocation.title
                        settingsModel.homeLatitude = selectedLocation.location.latitude
                        settingsModel.homeLongitude = selectedLocation.location.longitude
                    }) {
                        Text("Save as Home Address")
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                Color.blue
                            )
                            .cornerRadius(10)
                    }
                    .padding()
                }
            }
        }
        .onChange(of: selectedLocation) {
            if let selectedLocation {
                Task {
                    scene = try? await fetchScene(for: selectedLocation.location)
                }
            }
            isSheetPresented = selectedLocation == nil
        }
        .onChange(of: searchResults) {
            if let firstResult = searchResults.first, searchResults.count == 1 {
                selectedLocation = firstResult
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            SearchResultsView(searchResults: $searchResults)
        }
    }

    private func fetchScene(for coordinate: CLLocationCoordinate2D) async throws
        -> MKLookAroundScene?
    {
        let lookAroundScene = MKLookAroundSceneRequest(coordinate: coordinate)
        return try await lookAroundScene.scene
    }
}


#Preview {
    struct PreviewWrapper: View {
        @State private var settingsModel = SettingsModel.standard
        var body: some View {
            AddressSearchView()
                .environment(settingsModel)
        }
    }
    return PreviewWrapper()
}
