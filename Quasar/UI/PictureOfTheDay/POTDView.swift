//
//  POTDView.swift
//  Quasar
//
//  Created by Will on 3/19/21.
//

import SwiftUI
import Kingfisher

struct VerticalPOTDView: View {
    @ObservedObject var viewModel: POTDViewModel
    private let description = "Each day a different image or photograph of our fascinating universe is featured, along with a brief explanation written by a professional astronomer."
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                Image("NASA")
                    .resizable()
                    .scaledToFit()
                    .padding([.leading, .trailing], 40)
                FeedHeader(title: "Picture of the Day", text: description)
                LazyVStack (alignment: .leading, spacing: 5) {
                    ForEach(viewModel.imageFeed, id: \.title) { photo in
                        NavigationLink(destination: HorizontalPOTDFeed(title: photo.title, viewModel: viewModel)) {
                            ImageView(title: photo.title, url: photo.url).onAppear() { elementOnAppear(photo) }
                        }
                    }
                }
            }
        }
    }
    
    private func elementOnAppear(_ photo: PictureOfTheDay) {
        if viewModel.isLastPOTD(photo: photo) {
            viewModel.loadPicturesOfTheDay()
        }
    }
}

struct HorizontalPOTDFeed: View {
    @ObservedObject var viewModel: POTDViewModel
    @State var currentTitle = ""
    
    init(title: String, viewModel: POTDViewModel) {
        _currentTitle = State(initialValue: title)
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: true) {
            LazyHStack {
                PageView(viewModel: viewModel, currentTitle: currentTitle)
            }
        }
    }
}

struct PageView: View {
    @ObservedObject var viewModel: POTDViewModel
    @State var currentTitle: String
    
    var body: some View {
        TabView(selection: $currentTitle) {
            ForEach(viewModel.imageFeed, id: \.title) { photo in
                let url = photo.url
                let title = photo.title
                let explanation = photo.explanation
                let date = photo.date
                ScrollView {
                    ScrollViewReader { value in
                        NavigationLink(destination: FullScreenView(url: url, title: title)) {
                            KFImage(URL(string: url)).resizable().scaledToFit()
                        }
                            .onAppear() { elementOnAppear(photo) }
                            .padding(.top, 63)
                        PhotoDetailsView(explanation: explanation, date: formatDate(date), title: title)
                            .padding(.bottom, 55)
                    }
                }.tag(title)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
    
    private func elementOnAppear(_ photo: PictureOfTheDay) {
        if viewModel.isLastPOTD(photo: photo) {
            viewModel.loadPicturesOfTheDay()
        }
    }
    
    private func formatDate(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")

        guard let date = dateFormatter.date(from: date) else { return "error: date is nil" }
        
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

struct POTDViewPreviews: PreviewProvider {
    static var url = "https://apod.nasa.gov/apod/image/1509/TexasEclipse_Westlake_2642.jpg"
    static var title = "A Partial Solar Eclipse over Texas"
    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
    static var copyright = "Jimmy WestlakeColorado Mountain College"
    static var date = "April 28, 2021"
    static var previews: some View {
        DetailView(url: url, title: title, explanation: explanation, date: date)
    }
}