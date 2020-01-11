//
//  MapView.swift
//  Pandino
//
//  Created by Dani Tox on 25/12/2019.
//  Copyright © 2019 Dani Tox. All rights reserved.
//

import SwiftUI
import MapKit

struct ShitMap: View {
    @EnvironmentObject var mapAgent: MapAgent
    @EnvironmentObject var teslaLocationManager: TeslaLocationManager
        
    var body: some View {
        GeometryReader { geo in
            ZStack {
                MapView(mapAgent: self.mapAgent, teslaLocationManager: self.teslaLocationManager)
                
                VStack {
                    Spacer()
                    
                    HStack {
                        Button(action: {
                            self.teslaLocationManager.animateToUserLocation.toggle()
                        }) {
                            Image(systemName: "person.circle")
                            .resizable()
                                .accentColor(Color(UIColor.secondaryLabel))
                            .frame(width: 30, height: 30)
                        }
                        
                        Picker(selection: self.$mapAgent.mapTypeInteger, label: Text("Tipo:")) {
                            ForEach(0..<self.mapAgent.tipiStrings.count) {
                                Text(self.mapAgent.tipiStrings[$0]).tag($0)
                                    .font(.custom("Futura", size: 20))
                                
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: geo.size.width / 2.1)
                        
                    
                    }.offset(x: 0, y: -30)
                }
            }
        }
        
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    //let mapType: MKMapType
    var mapAgent: MapAgent
    var teslaLocationManager: TeslaLocationManager
    //var showUserLocation: Bool
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
        let map = MKMapView()
        map.showsUserLocation = true
        return map
    }
    
    func updateUIView(_ uiView: MapView.UIViewType, context: UIViewRepresentableContext<MapView>) {
        if teslaLocationManager.animateToUserLocation {
            guard let locValue:CLLocationCoordinate2D = self.teslaLocationManager.lm.location?.coordinate else { return }

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                let coordinate = CLLocationCoordinate2D(
                    latitude: locValue.latitude, longitude: locValue.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                uiView.setRegion(region, animated: true)
                
                print("Animating")
            }
            teslaLocationManager.animateToUserLocation = false
        }
        
        uiView.mapType = self.mapAgent.mapType
    }
    
}
