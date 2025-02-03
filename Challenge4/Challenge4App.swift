//
//  Challenge4App.swift
//  Challenge4
//
//  Created by GUILHERME MATEUS SOUSA SANTOS on 29/01/25.
//

import SwiftUI
import UserNotifications

@main
struct Challenge4App: App {
    let persistenceController = PersistenceController.persistencia
    let pressaoViewModel = PressaoViewModel()

    init() {
        requestNotificationPermission()
    }

    var body: some Scene {
        WindowGroup {
            TabBarComponent(pressaoViewModel: pressaoViewModel)
        }
    }

    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permissão concedida para notificações")
            } else {
                print("Permissão negada para notificações")
            }
        }
    }
}
