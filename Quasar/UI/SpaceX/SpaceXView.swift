//
//  SpaceXView.swift
//  Quasar
//
//  Created by Will on 4/21/21.
//

import SwiftUI
import Kingfisher

struct SpaceXView: View {
    @ObservedObject var viewModel: SpaceXViewModel

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                LazyVStack (alignment: .leading) {
                    ForEach(viewModel.launchFeed, id: \.date) { launch in
                        if let image = launch.links?.flickr?.original?.first,
                           let explanation = launch.details,
                           let date = launch.date,
                           let title = launch.name {
                            NavigationLink(destination: SpaceXDetailView(url: image, title: title, explanation: explanation, date: date)) {
                                SpaceXImageView(title: title, url: image)
                            }
                        }
                    }
                }
            }
        }.navigationBarTitle("SpaceX Rocket Launches", displayMode: .automatic)
    }
}

struct SpaceXImageView: View {
    var title: String
    var url: String
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            KFImage(URL(string: url))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 0.1)
                )
                .padding(.leading)
                .padding(.bottom, 2)
                .overlay(TitleOverlay(text: title), alignment: .bottomTrailing).padding(.trailing)
        }
    }
}

