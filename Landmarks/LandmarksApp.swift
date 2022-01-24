//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by 3456play on 2021/12/1.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @StateObject var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(modelData)
        }
    }
}
