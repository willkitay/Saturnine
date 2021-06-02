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
                Image("SpaceX")
                    .resizable()
                    .scaledToFit()
                    .padding([.top, .bottom])
                    .padding([.leading, .trailing], 40)
                FeedHeader(title: "", text: description)
                LazyVStack {
                    ForEach(viewModel.launchFeed, id: \.date) { launch in
                        if let url = launch.links.flickr.original?.first,
                           let images = launch.links.flickr.original,
                           let explanation = launch.details {
                            NavigationLink(destination: SpaceXDetailView(images: images, explanation: explanation, date: formatDate(launch.date), title: launch.name)) {
                                ImageView(title: launch.name, url: url)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct SpaceXDetailView: View {
    var images: [String]
    var explanation: String
    var date: String
    var title: String
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                VStack {
                    TabView {
                        ForEach(images, id: \.self) { image in
                            KFImage(URL(string: image))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                        .tabViewStyle(PageTabViewStyle())
                        .frame(height: 400)
                }
                VStack {
                    PhotoTitle(title: title)
                    PhotoDate(date: date)
                    Explanation(text: explanation)
                }
                    .background(Color.background2)
                    .cornerRadius(5)
                    .padding([.leading, .trailing, .bottom], 10)
                    .foregroundColor(.white)
                    .transition(.opacity)
                Spacer()
            }
        }
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

struct SpaceXPreviews: PreviewProvider {
    static var images = [""]
    static var title = "A Partial Solar Eclipse over Texas"
    static var date = "April 28, 2021"
    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
    
    static var previews: some View {
        SpaceXDetailView(images: images, explanation: explanation, date: date, title: title)
    }
}
