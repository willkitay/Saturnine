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
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                LazyVStack (alignment: .leading, spacing: 5) {
                    ForEach(viewModel.imageFeed, id: \.title) { photo in
                        if let url = photo.url,
                           let title = photo.title {
                            NavigationLink(destination: HorizontalPOTDFeed(viewModel: viewModel)) {
                                ImageView(title: title, url: url).onAppear() { elementOnAppear(photo) }
                            }
                            .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
                            .navigationBarTitle("Picture of the Day", displayMode: .inline)
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
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    PageView(viewModel: viewModel)
                }
            }
        }
    }
}

struct PageView: View {
    @ObservedObject var viewModel: POTDViewModel

    var body: some View {
        TabView {
            ForEach(viewModel.imageFeed, id: \.title) { photo in
                if let title = photo.title,
                   let explanation = photo.explanation,
                   let date = photo.date,
                   let url = photo.url {
                    ScrollView {
                        NavigationLink(destination: FullScreenView(url: url, title: title)) {
                            KFImage(URL(string: url))
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                        }.onAppear() { elementOnAppear(photo) }
                            .padding(.top, 63)
                        PhotoDetailsView(explanation: explanation, date: date, title: title)
                            .padding(.bottom, 55)
                    }
                }
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
}

struct HorizontalImageView: View {
    let url: String
    let explanation: String
    let title: String
    let date: String
    
    var body: some View {
        VStack {
            KFImage(URL(string: url))
                .resizable()
                .scaledToFit()
                .frame(width: 390, height: 800)
            Spacer()
        }
    }
}

//struct HorizontalPOTDFeedPreview: PreviewProvider {
//    static var url = "https://apod.nasa.gov/apod/image/1509/TexasEclipse_Westlake_2642.jpg"
//    static var title = "A Partial Solar Eclipse over Texas"
//    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
//    static var copyright = "Jimmy WestlakeColorado Mountain College"
//    static var date = "2015-09-13"
//    static var previews: some View {
//        HorizontalPOTDFeed(viewModel: <#T##POTDViewModel#>)
//    }
//}

struct POTDViewPreviews: PreviewProvider {
    static var url = "https://apod.nasa.gov/apod/image/1509/TexasEclipse_Westlake_2642.jpg"
    static var title = "A Partial Solar Eclipse over Texas"
    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
    static var copyright = "Jimmy WestlakeColorado Mountain College"
    static var date = "2015-09-13"
    static var previews: some View {
        DetailView(url: url, title: title, explanation: explanation, date: date)
    }
}
