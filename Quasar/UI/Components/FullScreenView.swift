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

