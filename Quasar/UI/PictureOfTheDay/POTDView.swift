//
//  POTDView.swift
//  Quasar
//
//  Created by Will on 3/19/21.
//

import SwiftUI
import Kingfisher

struct POTDView: View {
    @ObservedObject var viewModel: POTDViewModel
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea([.all])
            ScrollView(showsIndicators: true) {
                LazyVStack (alignment: .leading, spacing: 5) {
                    ForEach(viewModel.imageFeed, id: \.title) { photo in
                        if let url = photo.url,
                           let explanation = photo.explanation,
                           let title = photo.title,
                           let date = photo.date {
                            NavigationLink(destination: DetailView(url: url, title: title, explanation: explanation, date: date)) {
                                ImageView(title: title, url: url).onAppear() { elementOnAppear(photo) }
                            }
                            .navigationBarColor(backgroundColor: UIColor.background, titleColor: .white)
                            .navigationBarTitle("Picture of the Day", displayMode: .large)
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
