//
//  EventView.swift
//  Saturnine
//
//  Created by William Kitay on 10/27/21.
//

import SwiftUI

import SwiftUI
import Kingfisher
import AVFoundation

struct EventView: View {
    @ObservedObject var viewModel: EventVM
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                header
                content
            }
        }
    }
    
    var events: some View {
        LazyVStack {
            if let eventList = viewModel.eventList.results {
                ForEach(eventList.sorted(by: { $0.id > $1.id }), id: \.id) { event in
                    NavigationLink(destination: HorizontalEventFeed(id: event.id, viewModel: viewModel, event: eventList)) {
                        ImageView(title: event.name, url: event.url)
                    }
                }
            }
        }
    }
    
    var content: some View {
        VStack {
            if viewModel.fetchSuccess == true {
                events
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
            Image("Event")
                .resizable()
                .scaledToFit()
                .padding(.top)
            FeedHeader(title: "Events", text: "Landings, engine tests, spacewalks, and more.")
        }
    }
}

struct HorizontalEventFeed: View {
    @ObservedObject var viewModel: EventVM
    @State var currentId = 0
    var eventList: [Events]
    
    init(id: Int, viewModel: EventVM, event: [Events]) {
        _currentId = State(initialValue: id)
        self.viewModel = viewModel
        eventList = event
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
        TabView(selection: $currentId) {
            ForEach(eventList.sorted(by: { $0.id > $1.id }), id: \.id) { event in
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: FullScreenView(url: event.url, title: event.name)) {
                        KFImage(URL(string: event.url))
                            .resizable()
                            .scaledToFit()
                    }
                        .padding(.top, 62)
                    ImageInteractionTab(url: event.url, title: event.name, text: event.description, date: formatDateYearToSecondZ(event.date))
                    PhotoDetailsView(explanation: event.description, title: event.name)
                    if let link = event.newsUrl {
                        Link("Explore", destination: URL(string: link)!)
                    }
                }.tag(event.id)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}
