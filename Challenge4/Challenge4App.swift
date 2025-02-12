/*
 By:
 
 Alissa Yoshioka
 Amanda Rodrigues
 Guilherme Sousa
 João V. Teixeira
 Maria M. Rodrigues
 */

import SwiftUI
import UserNotifications

@main
struct Challenge4App: App {
    let persistenceController = PersistenceController.persistencia
    let pressaoViewModel = PressaoViewModel()

    init() {
        NotificationManager.shared.requestNotificationPermission()
    }

    var body: some Scene {
        WindowGroup {
            SplashScreenView()
        }
        .modelContainer(for: PressaoModel.self)
    }
}

