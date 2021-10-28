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
    @State private var isGrid = false
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(showsIndicators: true) {
                header
                if isGrid {
                    gridView
                } else {
                    stackView
                }
            }
        }.toolbar { ToolbarItem(placement: .navigationBarTrailing) { columnToGridButton } }
    }
    
    var header: some View {
        Group {
            Image("NASA")
                .resizable()
                .scaledToFit()
                .padding([.leading, .trailing], 40)
            FeedHeader(title: "Picture of the Day", text: description)
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
    
    var gridView: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 1), count: 3), spacing: 1) {
            ForEach(viewModel.imageFeed, id: \.title) { photo in
                NavigationLink(destination: HorizontalPOTDFeed(title: photo.title, viewModel: viewModel)) {
                    GridView(title: photo.title, url: photo.url).onAppear() { elementOnAppear(photo) }
                }
            }
        }.padding([.leading, .trailing], 5)
    }
    
    var stackView: some View {
        LazyVStack(alignment: .leading, spacing: 5) {
            ForEach(viewModel.imageFeed, id: \.title) { photo in
                NavigationLink(destination: HorizontalPOTDFeed(title: photo.title, viewModel: viewModel)) {
                    ImageView(title: photo.title, url: photo.url).onAppear() { elementOnAppear(photo) }
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
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    potdTabViewCell
                }
            }
        }
    }
    
    var potdTabViewCell: some View {
        TabView(selection: $currentTitle) {
            ForEach(viewModel.imageFeed, id: \.title) { photo in
                let url = photo.url
                let title = photo.title
                let explanation = photo.explanation
                let date = photo.date
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: FullScreenView(url: url, title: title)) {
                        KFImage(URL(string: url))
                            .resizable()
                            .scaledToFit()
                    }
                        .onAppear() { elementOnAppear(photo) }
                        .padding(.top, 63)
                    ImageInteractionTab(url: url, title: title, text: explanation, date: formatDate(date))
                    PhotoDetailsView(explanation: explanation, title: title)
                        .padding(.bottom, 55)
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
        guard let date = dateFormatter.date(from: date) else { return "error: POTD date is nil" }
        dateFormatter.dateStyle = .medium
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

//struct POTDViewPreviews: PreviewProvider {
//    static var url = "https://apod.nasa.gov/apod/image/1509/TexasEclipse_Westlake_2642.jpg"
//    static var title = "A Partial Solar Eclipse over Texas"
//    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
//    static var copyright = "Jimmy WestlakeColorado Mountain College"
//    static var date = "April 28, 2021"
//    static var previews: some View {
//        DetailView(url: url, title: title, explanation: explanation, date: date)
//    }
//}
