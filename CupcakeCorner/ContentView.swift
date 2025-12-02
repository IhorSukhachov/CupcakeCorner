//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 01.12.2025.
//
import CoreHaptics
import SwiftUI


struct ContentView: View {
    @State private var counter: Int = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("tap count \(counter)") {
             counter += 1
        }
       // .sensoryFeedback(.increase, trigger: counter)
    }
    func prepereHaptics() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was en error initializing the haptics engine \(error.localizedDescription)")
        }
    }
    
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else {
            return
        }
        var events = [CHHapticEvent]()
        
    }
}
#Preview {
    ContentView()
}
