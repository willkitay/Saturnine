//
//  ImageInteractionTab.swift
//  Quasar
//
//  Created by William Kitay on 6/15/21.
//

import SwiftUI
import UIKit
import Kingfisher

struct ImageInteractionTab: View {
    var url: String
    var title: String
    var text: String
    var date: String
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favorites.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorites.favoritedOn, ascending: false)]
    ) var favorites: FetchedResults<Favorites>
    @State var isFavorited = false
    @State private var showShareSheet = false

    var body: some View {
        HStack {
            shareButton
            Spacer()
            Text("\(date)")
                .font(.subheadline)
            Spacer()
            favoriteButton
        }
        .onAppear {
            for favorite in favorites {
                if favorite.url == url {
                    isFavorited = true
                    
                }
            }
        }
        .foregroundColor(.white)
    }
    
    var favoriteButton: some View {
        Button(action: {
            if isFavorited {
                for favorite in favorites {
                    if favorite.url == url {
                        managedObjectContext.delete(favorite)
                        do {
                            try managedObjectContext.save()
                        } catch {
                            // handle the Core Data error
                            print("Unable to delete image from favorites")
                        }
                    }
                }
                isFavorited.toggle()
            } else {
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
            shareSheet(url: url)
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.body)
                .padding(10)
        }
    }
}

struct SpaceXInteractionTab: View {
    var url: String
    var title: String
    var text: String
    var date: String
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favorites.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorites.favoritedOn, ascending: false)]
    ) var favorites: FetchedResults<Favorites>
    @State var isFavorited = false
    @State private var showShareSheet = false

    var body: some View {
        HStack {
            shareButton
            Spacer()
            Text("\(date)")
                .font(.subheadline)
            Spacer()
            favoriteButton
        }
        .onAppear {
            for favorite in favorites {
                if favorite.url == url {
                    isFavorited = true
                    
                }
            }
        }
        .foregroundColor(.white)
    }
    
    var favoriteButton: some View {
        Button(action: {
            if isFavorited {
                for favorite in favorites {
                    if favorite.url == url {
                        managedObjectContext.delete(favorite)
                        do {
                            try managedObjectContext.save()
                        } catch {
                            // handle the Core Data error
                            print("Unable to delete image from favorites")
                        }
                    }
                }
                isFavorited.toggle()
            } else {
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
                .font(.system(size: 16.0))
                .padding([.trailing, .bottom], 15)
        }
    }
    
    var shareButton: some View {
        Button(action: {
            shareSheet(url: url)
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.system(size: 16.0))
                .padding([.leading, .bottom], 15)
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        ImageInteractionTab(url: "url", title: "title", text: "text", date: "Jun 11, 2021").background(Color.background)
    }
}
