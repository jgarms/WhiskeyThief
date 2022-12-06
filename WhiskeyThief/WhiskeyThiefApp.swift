//
//  WhiskeyThiefApp.swift
//  WhiskeyThief
//
//  Created by Jess Garms on 12/5/22.
//

import SwiftUI

@main
struct WhiskeyThiefApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
