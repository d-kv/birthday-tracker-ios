//
//  birthday_tracker_iosApp.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 28.02.2022.
//

import SwiftUI

@main
struct birthday_tracker_iosApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            AuthUIView()
        }
    }
}
