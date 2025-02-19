//
//  PaperClipApp.swift
//  PaperClip
//
//  Created by Tiago Antunes on 16/02/2025.
//

import SwiftUI

@main
struct PaperClipApp: App {
    @StateObject var appCoordinator = AppCoordinator()

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $appCoordinator.path) {
                appCoordinator.build(.home)
                    .navigationDestination(for: Screen.self) { screen in
                        appCoordinator.build(screen)
                    }
            }
            .environmentObject(appCoordinator)
        }
    }
}
