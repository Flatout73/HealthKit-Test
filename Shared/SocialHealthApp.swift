//
//  SocialHealthApp.swift
//  Shared
//
//  Created by Leonid Liadveikin on 17.04.2021.
//

import SwiftUI

@main
struct SocialHealthApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self)
    var appDelegate

    @StateObject
    var healthService = HealthService()

    var body: some Scene {
        WindowGroup {
            TabView {
                FeedView(healthService: healthService)
                .tabItem { Text("Лента") }
                SearchView()
                .tabItem { Text("Поиск") }
                ProfileView(profile: $healthService.profile)
                    .tabItem { Text("Профиль") }
            }
        }
    }
}
