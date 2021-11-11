//
//  SaturnineApp.swift
//  Saturnine
//
//  Created by Will on 4/19/21.
//

import SwiftUI

@main
struct SaturnineApp: App {
    @Environment(\.scenePhase) var scenePhase
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            persistenceController.save()
        }
    }
}
