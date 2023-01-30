//
//  TimerApp.swift
//  Timer
//
//  Created by junhyeok KANG on 2023/01/19.
//

import SwiftUI
import Firebase

@main
struct TimerApp: App {
    @StateObject var pomodoroModel: PomodoroModel = .init()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pomodoroModel)
            
        }
    }
}
