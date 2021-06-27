//
//  MyWalletApp.swift
//  MyWallet
//
//  Created by PATRICIA S SIQUEIRA on 27/06/21.
//

import SwiftUI

@main
struct MyWalletApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
