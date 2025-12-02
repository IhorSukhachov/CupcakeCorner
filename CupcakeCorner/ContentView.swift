//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Ihor Sukhachov on 01.12.2025.
//
import CoreHaptics
import SwiftUI


struct ContentView: View {
  //  @State private var counter: Int = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Play haptic") {
         //    counter += 1
            complexSuccess( )
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
        
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        let sharpess = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpess], relativeTime: 0)
        events.append(event)
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [] )
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("There was en error \(error.localizedDescription)")
        }
    }
}
#Preview {
    ContentView()
}
