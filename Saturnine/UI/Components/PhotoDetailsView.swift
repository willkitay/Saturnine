//
//  POTDExplanation.swift
//  Saturnine
//
//  Created by Will on 4/19/21.
//
import SwiftUI
import Kingfisher

struct ImageView: View {
    var title: String
    var url: String
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
            .scaledToFit()
            .cornerRadius(10)
            .padding([.leading, .trailing], 10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 0.1)
                    .padding([.leading, .trailing], 10)
            )
            .overlay(TitleOverlay(text: title).padding([.leading, .trailing], 10), alignment: .bottomTrailing)
    }
}

struct GridView: View {
    var title: String
    var url: String
    
    var body: some View {
        KFImage(URL(string: url))
            .resizable()
            .frame(minWidth: 100, maxWidth: 150, minHeight: 100, maxHeight: 150)
            .scaledToFill()
    }
}

struct PhotoDetailsView: View {
    var explanation: String
    var title: String
    
    var body: some View {
        VStack {
            PhotoTitle(title: title).padding([.leading, .trailing])
            Explanation(text: explanation)
        }
        .foregroundColor(.white)
    }
}
    
struct PhotoCopyright: View {
    var copyright: String
    var body: some View {
        VStack(alignment: .center) {
            Text(copyright)
                .padding(.bottom)
        }
    }
}

struct Explanation: View {
    var text: String
    var body: some View {
        VStack {
            Text("\n\(text)")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .padding([.leading, .trailing, .bottom])
                .lineSpacing(8)
                .cornerRadius(5)
                .lineLimit(nil)
                .foregroundColor(.white)
        }
    }
}

struct PhotoDate: View {
    var date: String
    var body: some View {
        Text(date)
            .foregroundColor(.white)
    }
}

struct PhotoTitle: View {
    var title: String
    var body: some View {
        HStack {
            Text(title)
                .font(.largeTitle)
                .minimumScaleFactor(0.01)
                .lineLimit(1)
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.top)
                .padding(.bottom, 10)
        }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var url = "https://apod.nasa.gov/apod/image/1509/TexasEclipse_Westlake_2642.jpg"
    static var title = "A Partial Solar Eclipse over Texas"
    static var previews: some View {
        ScrollView {
            VStack(spacing: 5) {
                ImageView(title: title, url: url)
                ImageView(title: title, url: url)
                ImageView(title: title, url: url)
                ImageView(title: title, url: url)
            }
        }
    }
}

struct PhotoDetailsView_Previews: PreviewProvider {
    static var url = "https://imgsrc.hubblesite.org/hvi/uploads/feed_post/thumbnail/25112/MATLAS2021.jpg"
    static var explanation = "It was a typical Texas sunset except that most of the Sun was missing.  The location of the missing piece of the Sun was not a mystery -- it was behind the Moon.  Featured here is one of the more interesting images taken of a partial solar eclipse that occurred in 2012, capturing a temporarily crescent Sun setting in a reddened sky behind brush and a windmill. The image was taken about 20 miles west of Sundown, Texas, USA, just after the ring of fire effect was broken by the Moon moving away from the center of the Sun.  Today a new partial solar eclipse of the Sun will be visible from Earth.  Unfortunately for people who live in Texas, today's eclipse can only be seen from southern Africa and Antarctica."
    static var date = "2015-09-13"
    static var title = "A Partial Solar Eclipse over Texas"
    static var previews: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    ImageView(title: title, url: url)
                }
                PhotoDetailsView(explanation: explanation, title: title)
            }
        }
    }
}
