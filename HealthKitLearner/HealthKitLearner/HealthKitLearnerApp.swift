//
//  HealthKitLearnerApp.swift
//  HealthKitLearner
//
//  Created by Angela on 3/7/24.
//

import SwiftUI

@main
struct HealthKitLearnerApp: App {
    @StateObject var manager = HealthManager()
    var body: some Scene {
        WindowGroup {
            BeActivTabView()
                .environmentObject(manager)
        }
    }
}
