//
//  Challenge4App.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/01/25.
//

import SwiftUI

@main
struct Challenge4App: App {
    let persistenceController =  PersistenceController.persistencia
    let pressaoViewModel = PressaoViewModel()
    var body: some Scene {
        WindowGroup {
            TabBarComponent(pressaoViewModel: pressaoViewModel)
        }
    }
}
