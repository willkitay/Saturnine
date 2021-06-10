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
    let description = "SpaceX is an American aerospace manufacturer that was founded with the goal of enabling the colonization of Mars. SpaceX manufactures the Falcon 9 and Falcon Heavy launch vehicles, rocket engines, and Starlink communications satellites."

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                header
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
}

struct HorizontalSpaceXFeed: View {
    @ObservedObject var viewModel: SpaceXViewModel
    @State var currentTitle = ""
    var launch: SpaceX
    
    init(title: String, viewModel: SpaceXViewModel, launch: SpaceX) {
        _currentTitle = State(initialValue: title)
        self.viewModel = viewModel
        self.launch = launch
    }

    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    spaceXTabViewCell
                }
            }
        }
    }
    
    
    var spaceXTabViewCell: some View {
        ScrollView {
            TabView(selection: $currentTitle) {
                ForEach(viewModel.launchFeed, id: \.name) { launch in
                    if let first = launch.links.flickr.original?.first {
                        if let images = launch.links.flickr.original,
                           let expl = launch.details {
                            VStack {
                                SpaceXTabView(images: images).padding(.bottom)
                                VStack {
                                    PhotoTitle(title: launch.name)
                                    PhotoDate(date: formatDate(launch.date))
                                    Explanation(text: expl)
                                }
                                .background(Color.background2)
                                .cornerRadius(5)
                            }
                            .padding([.leading, .trailing])
                            .foregroundColor(.white)
                            .tag(first)
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
    }
}

struct SpaceXTabView: View {
    var images: [String]
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

private func formatDate(_ date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")

    guard let date = dateFormatter.date(from: date) else { return "error: date is nil" }
    
    dateFormatter.dateStyle = .medium
    let formattedDate = dateFormatter.string(from: date)
    return formattedDate
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
