//
//  spinev4App.swift
//  spinev4
//
//  Created by Ailidh Kinney on 20/07/2022.
//

import SwiftUI
import Firebase

@main
struct spinev4App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(ViewModel())
        }
    }
}
