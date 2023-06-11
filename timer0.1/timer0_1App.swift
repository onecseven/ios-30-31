//
//  timer0_1App.swift
//  timer0.1
//
//  Created by Tatiana Talavera on 06-06-23.
//

import SwiftUI

@main
struct timer0_1App: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct Task {
    var name: String
    var duration: Int

}

var pollo = TimerTask(name: "pollo", seconds: 2, icon: "po", color: "lol", remaining: 1)
