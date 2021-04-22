//
//  RoverDetailViews.swift
//  QuazarV4
//
//  Created by Will on 4/11/21.

import SwiftUI
import Kingfisher

struct RoverDetailView: View {
    var url: String
    var date: String
    var sol: Int
    var rover: String
    var landingDate: String
    var camera: String
    var cameraDescription: String
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: true) {
                VStack {
                    NavigationLink(destination: FullScreenView(url: url, title: cameraDescription)) {
                        ImageView(title: camera, url: url)
                    }
                    RoverDescription(url: url, date: date, rover: rover, sol: sol, landingDate: landingDate, camera: camera, cameraDescription: cameraDescription)
                }
            }
        }
    }
}

struct RoverDescription: View {
    var url: String
    var date: String
    var rover: String
    var sol: Int
    var landingDate: String
    var camera: String
    var cameraDescription: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("●  " + rover + " Rover").padding()
            Text("●  Photographed on: \(date)").padding()
            Text("●  Sol: \(sol)").padding()
            Text("●  Landing Date: \(landingDate)").padding()
            Text("●  \(camera)").padding()
            Text("●  \(cameraDescription)").padding()
        }
        .frame(width: 370)
        .background(Color.background2)
        .cornerRadius(5)
        .padding(10)
        .foregroundColor(.white)
    }
}
