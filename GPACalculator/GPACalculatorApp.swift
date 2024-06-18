//
//  GPACalculatorApp.swift
//  GPACalculator
//
//  Created by Mehmet Alp Sönmez on 18/06/2024.
//
import SwiftData
import SwiftUI

@main
struct GPACalculatorApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(result: 5.0)
        }
        .modelContainer(for: Grade.self)
    }
}
