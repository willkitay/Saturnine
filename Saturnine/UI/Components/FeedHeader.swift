//
//  FeedHeader.swift
//  Saturnine
//
//  Created by Will on 5/6/21.
//

import SwiftUI

struct FeedHeader: View {
    let title: String
    let text: String
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(title)
                    .font(.largeTitle).bold()
                    .foregroundColor(.white)
                    .padding([.leading, .trailing])
                    .padding(.trailing, 50)
                    .padding(.bottom, 2.5)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                Text(text)
                    .multilineTextAlignment(.leading)
                    .font(.callout)
                    .foregroundColor(.white)
                    .padding([.leading, .trailing])
            }
            GrayDivider()
        }
    }
}

struct FeedHeader_Previews: PreviewProvider {
    static var previews: some View {
        Image("NASA")
            .resizable()
            .scaledToFit()
            .padding([.leading, .trailing], 40)
        FeedHeader(title: "Picture of the Day", text: "testestettstststsjldjvs;hsklfsjfsdljldsjflsdj;flsjfksdjkjsdklgjdskjs")
    }
}
