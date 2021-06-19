//
//  ImageInteractionTab.swift
//  Quasar
//
//  Created by William Kitay on 6/15/21.
//

import SwiftUI

struct ImageInteractionTab: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var isFavorited = false
    var url: String
    var title: String
    var text: String
    var date: String
    
    var body: some View {
        HStack {
            shareButton
            Spacer()
            Text("\(date)")
                .font(.subheadline)
            Spacer()
            favoriteButton
        }
        .foregroundColor(.white)
    }
    
    var favoriteButton: some View {
        Button(action: {
            // TODO: favorites button
            if isFavorited {
                isFavorited.toggle()
                
            }
            if !isFavorited {
                isFavorited.toggle()
                let favorite = Favorites(context: managedObjectContext)
                favorite.url = url
                favorite.date = date
                favorite.title = title
                favorite.text = text
                favorite.favoritedOn = Date()
                do {
                    try managedObjectContext.save()
                } catch {
                    // handle the Core Data error
                    print("Unable to save image to favorites")
                }
            }
            
        }) {
            Image(systemName: isFavorited ? "bookmark.fill" : "bookmark")
                .font(.body)
                .padding(10)
        }
    }
    
    var shareButton: some View {
        Button(action: {
            // TODO: share button
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.body)
                .padding(10)
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        ImageInteractionTab(url: "url", title: "title", text: "text", date: "Jun 11, 2021").background(Color.background)
    }
}
