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
                    NavigationLink(destination: FullScreenView(url: url)) {
                        RoverImage(url: url).overlay(TitleOverlay(text: camera), alignment: .bottomTrailing)
                    }
                    RoverDescription(url: url, date: date, rover: rover, sol: sol, landingDate: landingDate, camera: camera, cameraDescription: cameraDescription)
                }
            }
            .foregroundColor(.white)
            .background(Color.background2)
            .cornerRadius(10)
            .padding()
        }
    }
}

struct FullScreenView: View {
    var url: String

    var body: some View {
        ZStack {Color.background.edgesIgnoringSafeArea(.all)
            ZoomableScrollView {
                ZStack {
                    Color.background.edgesIgnoringSafeArea(.all)
                    KFImage(URL(string: url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct RoverImage: View {
    var url: String
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.1)
            )
            .padding(.bottom, 2)
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
        .foregroundColor(.white)
    }
}
