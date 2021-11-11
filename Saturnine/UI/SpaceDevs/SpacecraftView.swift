//
//  SpacecraftView.swift
//  Saturnine
//
//  Created by William Kitay on 9/18/21.
//

import SwiftUI
import Kingfisher

struct SpacecraftView: View {
    @ObservedObject var viewModel: SpacecraftVM
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                header
                if let spacecraftList = viewModel.spacecraftList.results?.sorted(by: { $0.maidenLaunch > $1.maidenLaunch }) {
                    LazyVStack {
                        ForEach(spacecraftList, id: \.id) { craft in
                            NavigationLink(destination: HorizontalSpacecraftFeed(title: craft.name, viewModel: viewModel, spacecraft: spacecraftList)) {
                                ImageView(title: craft.name, url: craft.imageUrl)
                            }
                        }
                    }
                }
            }
        }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Image("Spacecraft")
                .resizable()
                .scaledToFit()
                .padding(.top)
            FeedHeader(title: "Spacecraft", text: "Explore the spacecraft we use to stay in orbit.")
        }
    }
}

struct HorizontalSpacecraftFeed: View {
    @ObservedObject var viewModel: SpacecraftVM
    @State var currentTitle = ""
    var spacecraftList: [Spacecraft]
    
    init(title: String, viewModel: SpacecraftVM, spacecraft: [Spacecraft]) {
        _currentTitle = State(initialValue: title)
        self.viewModel = viewModel
        spacecraftList = spacecraft
    }
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    craftTabViewCell
                }
            }
        }
    }
    
    var craftTabViewCell: some View {
        TabView(selection: $currentTitle) {
            ForEach(spacecraftList, id: \.name) { craft in
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: FullScreenView(url: craft.imageUrl, title: craft.name)) {
                        KFImage(URL(string: craft.imageUrl))
                            .resizable()
                            .scaledToFit()
                    }
                        .padding(.top, 62)
                    ImageInteractionTab(url: craft.imageUrl, title: craft.name, text: craft.agency.description, date: formatDate(craft.maidenLaunch))
                    PhotoDetailsView(explanation: craft.capability, title: craft.name)
                    Explanation(text: craft.agency.description)
                        .padding(.bottom, 55)
                }.tag(craft.name)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}

