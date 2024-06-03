//
//  MapOverwatchView.swift
//  thermostat
//
//  Created by Jack Wesolowski on 6/3/24.
//

import Foundation

//struct MapPanelView: View {
//    @State private var homeAddress = CLLocationCoordinate2D(latitude: 39.947039, longitude: -82.980115)
//    @State private var locationManager = CLLocationManager()
//
//    var body: some View {
//        Map() {
//                    Annotation("Parking", coordinate: .parking) {
//                        ZStack {
//                            RoundedRectangle(cornerRadius: 5)
//                                .fill(.background)
//                            RoundedRectangle(cornerRadius: 5)
//                                .stroke(.secondary, lineWidth: 5)
//                            Image(systemName: "car")
//                                .padding(5)
//                        }
//                    }
//                    .annotationTitles(.hidden) // hide the title, icon only

//        VStack {
//            Map {
//                Marker("Home", coordinate: homeAddress)
//                    .tint(.blue)
//                MapCircle(center: homeAddress, radius: 1000)
//                    .stroke(.blue.opacity(0.5), lineWidth: 5)
//                    .foregroundStyle(.white.opacity(0.2))
//                    .mapOverlayLevel(level: .aboveLabels)
//
//            }
//            .mapControls {
//                MapUserLocationButton()
//            }
//            .mapControlVisibility(.hidden)
//            .mapStyle(.standard(elevation: .flat, emphasis: .muted, pointsOfInterest: .excludingAll, showsTraffic: false))
//        }
//        .onAppear {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//}
