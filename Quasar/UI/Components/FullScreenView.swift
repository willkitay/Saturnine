//
//  FullScreenView.swift
//  Quasar
//
//  Created by Will on 4/21/21.
//

import SwiftUI
import Kingfisher

struct FullScreenView: View {
    var url: String
    var title: String
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            ZoomableScrollView {
                ZStack {
                    Color.background.edgesIgnoringSafeArea(.all)
                    KFImage(URL(string: url))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

struct FullScreenView_Previews: PreviewProvider {
    static var url = "https://apod.nasa.gov/apod/image/1509/TexasEclipse_Westlake_2642.jpg"
    static var title = "A Partial Solar Eclipse over Texas"
    static var previews: some View {
        FullScreenView(url: url, title: title)
    }
}

