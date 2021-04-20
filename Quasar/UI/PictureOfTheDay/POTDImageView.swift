//
//  POTDImageView.swift
//  QuazarV4
//
//  Created by Will on 3/19/21.
//

import SwiftUI
import Kingfisher

struct POTDImageView: View {
    var photo: PictureOfTheDay
    var body: some View {
        if let title = photo.title {
            ZStack(alignment: .bottomTrailing) {
                KFImage(URL(string: photo.url!))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.1)
                    )
                    .padding(.leading)
                    .padding(.bottom, 2)
                    .overlay(TitleOverlay(text: title), alignment: .bottomTrailing).padding(.trailing)
            }
        }
    }
}



