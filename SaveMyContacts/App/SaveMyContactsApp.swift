//
//  SaveMyContactsApp.swift
//  SaveMyContacts
//
//  Created by Isaias Cuvula on 26.11.21.
//

import SwiftUI

@main
struct SaveMyContactsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
