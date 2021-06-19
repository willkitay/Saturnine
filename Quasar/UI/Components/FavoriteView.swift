//
//  FavoriteView.swift
//  Quasar
//
//  Created by William Kitay on 6/17/21.
//

import SwiftUI

struct FavoriteView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
        entity: Favorites.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Favorites.title, ascending: true)]
    ) var favorites: FetchedResults<Favorites>
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 1), count: 3), spacing: 1) {
            favoritesGrid
        }
    }
    
    var favoritesGrid: some View {
        ForEach(favorites, id: \.self) { favorite in
            GridView(title: favorite.title ?? "error", url: favorite.url ?? "error")
                .contextMenu {
                    Button {
                        managedObjectContext.delete(favorite)
                        PersistenceController.shared.save()
                    } label: {
                        Label("Unfavorite", systemImage: "heart.slash")
                    }
                    
                    Button {
                        
                    } label: {
                        Label("Share", systemImage: "square.and.arrow.up")
                    }
                }
        }
    }
}
