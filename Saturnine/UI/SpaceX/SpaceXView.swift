//
//  SpaceXView.swift
//  Saturnine
//
//  Created by Will on 4/21/21.
//

import SwiftUI
import Kingfisher

struct SpaceXView: View {
    @ObservedObject var viewModel: SpaceXViewModel
    let description = "SpaceX is an American aerospace manufacturer that was founded with the goal of enabling the colonization of Mars. SpaceX manufactures the Falcon 9 and Falcon Heavy launch vehicles, rocket engines, and Starlink communications satellites."
    @State private var isGrid = false

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                header
                if isGrid {
                    LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 0), count: 3), spacing: 0) {
                        ForEach(viewModel.launchFeed, id: \.date) { launch in
                            if let url = launch.links.flickr.original?.first {
                                NavigationLink(destination: HorizontalSpaceXFeed(title: launch.name, viewModel: viewModel, launch: launch)) {
                                    GridView(title: launch.name, url: url)
                                }
                            }
                        }
                    }.padding([.leading, .trailing], 5)
                } else {
                    LazyVStack {
                        ForEach(viewModel.launchFeed, id: \.date) { launch in
                            if let url = launch.links.flickr.original?.first {
                                NavigationLink(destination: HorizontalSpaceXFeed(title: launch.name, viewModel: viewModel, launch: launch)) {
                                    ImageView(title: launch.name, url: url)
                                }
                            }
                        }
                    }
                }
            }
        }.toolbar {
            ToolbarItem(placement: .navigationBarTrailing) { columnToGridButton }
        }
    }
    
    var header: some View {
        Group {
            Image("SpaceX")
                .resizable()
                .scaledToFit()
                .padding([.top, .bottom])
                .padding([.leading, .trailing], 40)
            FeedHeader(title: "", text: description)
        }
    }
    
    var columnToGridButton: some View {
        Button(action: {
            withAnimation(.default) {
                isGrid.toggle()
            }
        }) {
            if isGrid {
                Image(systemName: "rectangle.grid.1x2")
            } else {
                Image(systemName: "square.grid.3x3")
            }
        }
    }
}

struct HorizontalSpaceXFeed: View {
    @ObservedObject var viewModel: SpaceXViewModel
    @State var currentTitle = ""
    @State var lastScaleValue: CGFloat = 1.0
    var launch: SpaceX
    
    init(title: String, viewModel: SpaceXViewModel, launch: SpaceX) {
        _currentTitle = State(initialValue: title)
        self.viewModel = viewModel
        self.launch = launch
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            LazyHStack {
                spaceXTabViewCell
            }
        }
    }
    
    var spaceXTabViewCell: some View {
        ScrollView {
            TabView(selection: $currentTitle) {
                ForEach(viewModel.launchFeed, id: \.name) { launch in
                    if (launch.links.flickr.original?.first) != nil {
                        if let images = launch.links.flickr.original,
                           let expl = launch.details {
                            VStack {
                                TabView {
                                    ForEach(images.indices, id: \.self) { index in
                                        ZStack {
                                            ZoomableScrollView {
                                                ZStack {
                                                    Color.background.edgesIgnoringSafeArea(.all)
                                                    KFImage(URL(string: images[index]))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                }
                                            }
                                            VStack {
                                                HStack {
                                                    Spacer()
                                                    Text("\(index+1)/\(images.count)")
                                                        .padding([.leading, .trailing], 8)
                                                        .padding([.top, .bottom], 5)
                                                        .foregroundColor(.white)
                                                        .background(Color.black)
                                                        .opacity(0.7)
                                                        .cornerRadius(15)
                                                        .font(.caption)
                                                }
                                                Spacer()
                                                SpaceXInteractionTab(url: images[index], title: "", text: expl, date: "")
                                            }
                                        }
                                    }
                                }
                                .frame(height: 450)
                                PhotoTitle(title: launch.name)
                                PhotoDate(date: formatDateYearToSecond(launch.date))
                                Explanation(text: expl)
                                Spacer()
                            }
                            .padding([.leading, .trailing])
                            .foregroundColor(.white)
                            .tag(launch.name)
                            
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height+200)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .accentColor(.background)
        }
    }
}

struct SpaceXTabView: View {
    var images: [String]
    var title: String
    var text: String
    var date: String
    var body: some View {
        LazyVStack {
            TabView {
                ForEach(images, id: \.self) { image in
                    KFImage(URL(string: image))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height: 400)
        }.background(Color.background)
    }
}

//struct SpaceXPreviews: PreviewProvider {
//    static var images = [""]
//    static var title = "A Partial Solar Eclipse over Texas"
//    static var date = "April 28, 2021"
//    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
//
//    static var previews: some View {
//        SpaceXPageView(
//    }
//}
