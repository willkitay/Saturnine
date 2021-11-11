//
//  AstronautsView.swift
//  Saturnine
//
//  Created by William Kitay on 9/18/21.
//

import SwiftUI
import Kingfisher

struct AstronautsView: View {
    @ObservedObject var viewModel: AstronautVM
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                header
                content
            }
        }
    }
    
    var astronauts: some View {
        LazyVStack {
            if let astronautList = viewModel.astronautList.results {
                ForEach(astronautList, id: \.id) { astronaut in
                    NavigationLink(destination: HorizontalAstronautFeed(title: astronaut.name, viewModel: viewModel, astronaut: astronautList)) {
                        ImageView(title: astronaut.name, url: astronaut.profileImage ?? "no image found FIXME")
                    }
                }
            }
        }
    }
    
    var content: some View {
        VStack {
            if viewModel.fetchSuccess == true {
                astronauts
            } else {
                if viewModel.fetchSuccess == false {
                    Text("No images available.")
                        .foregroundColor(.white)
                        .padding(.top, 40)
                    
                } else {
                    ProgressView()
                        .frame(width: 200, height: 200)
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
            }
        }
    }
    
    var header: some View {
        VStack(alignment: .leading) {
            Image("AstronautBackground")
                .resizable()
                .scaledToFit()
                .padding(.top)
            FeedHeader(title: "Astronauts", text: "Meet the exceptional people that have ventured into space.")
        }
    }
    
//    private func elementOnAppear(_ astronaut: Astronaut) {
//        if viewModel.isLastAstronaut(astronaut: astronaut) {
//            viewModel.loadAstronautList()
//        }
//    }
}

struct HorizontalAstronautFeed: View {
    @ObservedObject var viewModel: AstronautVM
    @State var currentTitle = ""
    var astronautList: [Astronaut]
    
    init(title: String, viewModel: AstronautVM, astronaut: [Astronaut]) {
        _currentTitle = State(initialValue: title)
        self.viewModel = viewModel
        astronautList = astronaut
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
            ForEach(astronautList, id: \.name) { astronaut in
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: FullScreenView(url: astronaut.profileImage ?? "no image found FIXME", title: astronaut.name)) {
                        KFImage(URL(string: astronaut.profileImage ?? "no image found FIXME"))
                            .resizable()
                            .scaledToFit()
                    }
                        .padding(.top, 62)
                    ImageInteractionTab(url: astronaut.profileImage ?? "no image found FIXME", title: astronaut.name, text: astronaut.nationality, date: formatDate(astronaut.dob))
                    PhotoDetailsView(explanation: astronaut.bio, title: astronaut.name)
                        .padding(.bottom, 55)
                }.tag(astronaut.name)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}


