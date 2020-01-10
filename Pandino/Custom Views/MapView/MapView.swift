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
    
    @State var selectedMapType: Int = 0
    @State var tipi: [String] = ["Mappa", "Satellite", "Ibrido"]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                MapView()
                
                VStack {
                    Spacer()
                    
                    HStack {
//                        Spacer()
                        
                        Picker(selection: self.$selectedMapType, label: Text("Tipo:")) {
                            ForEach(0..<self.tipi.count) {
                                Text(self.tipi[$0]).tag($0)
                                    .font(.custom("Futura", size: 20))
                                
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .frame(maxWidth: geo.size.width / 2.1)
                    .offset(x: 0, y: -30)
                    
                    }
                }
            }
        }
        
    }
}

struct MapView: UIViewRepresentable {
    typealias UIViewType = MKMapView

    //let mapType: MKMapType
    
    
    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MapView.UIViewType {
        return MKMapView()
    }
    
    func updateUIView(_ uiView: MapView.UIViewType, context: UIViewRepresentableContext<MapView>) {
        
    }
    
}
