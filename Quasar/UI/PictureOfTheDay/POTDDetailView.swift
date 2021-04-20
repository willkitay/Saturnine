//
//  POTDDetailView.swift
//  QuazarV4
//
//  Created by Will on 3/23/21.
//

import SwiftUI
import Kingfisher
//import ImageScrollView
import WebKit

struct POTDDetailView: View {
    var photo: PictureOfTheDay

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack() {
                    VStack {
                        NavigationLink(destination: POTDFullScreenView(photo: photo)) {
                            if photo.media_type == "image" {
                                KFImage(URL(string: photo.url!))
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
                    }
                    PhotoExplanation(photo: photo)
                }
            }
            .navigationBarColor(backgroundColor: .background, titleColor: .white)
            .navigationTitle(photo.title!)
        }
    }
}

struct POTDFullScreenView: View {
    var photo: PictureOfTheDay
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(.all)
            if let url = photo.url, let title = photo.title {
                ZoomableScrollView {
                    ZStack {
                        Color.black.ignoresSafeArea(.all)
                        KFImage(URL(string: url))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .navigationTitle("\(title)")
                    }
                }
            }
        }
    }
}
