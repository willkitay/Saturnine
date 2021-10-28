//
//  FavoriteView.swift
//  Quasar
//
//  Created by William Kitay on 6/17/21.
//

import SwiftUI
import Kingfisher

struct FavoriteView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favorites.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorites.favoritedOn, ascending: false)]
    ) var favorites: FetchedResults<Favorites>
    
    var body: some View {
        if favorites.isEmpty {
            EmptyView()
        } else {
            favoriteGridView
        }
    }
    
    var favoriteGridView: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 1), count: 3), spacing: 1) {
            ForEach(favorites.reversed(), id: \.self) { favorite in
                NavigationLink(destination: HorizontalFavoriteFeed(title: favorite.title ?? "error")) {
                    GridView(title: favorite.title ?? "error", url: favorite.url ?? "error")
                }.contextMenu {
                    Button { managedObjectContext.delete(favorite) } label: {
                        Label("Delete", systemImage: "globe")
                    }
                    Button { shareSheet(url: favorite.url ?? "error: could not share image") } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
            }
        }
    }
}

struct HorizontalFavoriteFeed: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favorites.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorites.favoritedOn, ascending: false)]
    ) var favorites: FetchedResults<Favorites>
    @State var currentTitle = ""
    
    init(title: String) {
        _currentTitle = State(initialValue: title)
    }
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack {
                    favoriteTabViewCell
                }
            }
        }
    }
    
    var favoriteTabViewCell: some View {
        TabView(selection: $currentTitle) {
            ForEach(favorites.reversed(), id: \.url) { favorite in
                let url = favorite.url ?? "url error"
                let title = favorite.title ?? "title error"
                let text = favorite.text ?? "text error"
                let date = favorite.date ?? "date error"
                ScrollView(showsIndicators: false) {
                    NavigationLink(destination: FullScreenView(url: url, title: title)) {
                        KFImage(URL(string: url))
                            .resizable()
                            .scaledToFit()
                    }
                        .padding(.top, 63)
                    HStack {
                        ShareButton(url: url).padding(.leading)
                        Spacer()
                        Text("\(date)")
                            .font(.subheadline)
                            .foregroundColor(.white)
                        Spacer()
                        Image(systemName: "bookmark").foregroundColor(.background).font(.body).padding(10)
                    }
                    
                    PhotoDetailsView(explanation: text, title: title)
                        .padding(.bottom, 55)
                }.tag(title)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .tabViewStyle(PageTabViewStyle())
    }
}

struct ShareButton: View {
    var url: String
    var body: some View {
        Button(action: {
            shareSheet(url: url)
        }) {
            Image(systemName: "square.and.arrow.up")
                .font(.body)
                .padding(10)
                .foregroundColor(.white)
        }
    }
}

struct EmptyView: View {
    var body: some View {
        Spacer()
        VStack {
            Image(systemName: "face.smiling.fill")
                .padding(.top, 75)
                .foregroundColor(.white)
                .font(.system(size: 72))
                .padding()
                VStack {
                    Text("Tap \(Image(systemName: "bookmark")) and the images will show up here.")
                        .foregroundColor(.white)
                        .font(.caption)
                }
        } .frame(width: UIScreen.main.bounds.width)
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView().background(Color.background)
    }
}
