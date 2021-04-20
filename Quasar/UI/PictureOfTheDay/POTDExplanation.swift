//
//  POTDExplanation.swift
//  Quasar
//
//  Created by Will on 4/19/21.
//

import SwiftUI

struct PhotoExplanation: View {
    var photo: PictureOfTheDay
    var body: some View {
        if let explanation = photo.explanation {
            VStack {
                Text(explanation)
                    .padding()
                    .lineSpacing(6)
                    .cornerRadius(5)
                HStack {
                    PhotoCopyright(photo: photo)
                        .padding()
                }
                PhotoDate(photo: photo)
                    .padding(.bottom)
            }
            .background(Color.background2)
            .cornerRadius(5)
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct PhotoCopyright: View {
    var photo: PictureOfTheDay
    var body: some View {
        VStack(alignment: .center) {
            if let copyright = photo.copyright {
                Text("by " + copyright)
            }
        }
    }
}

struct PhotoDate: View {
    var photo: PictureOfTheDay
    var body: some View {
        if let date = photo.date {
            Text(date)
                .foregroundColor(.white)
        }
    }
}
