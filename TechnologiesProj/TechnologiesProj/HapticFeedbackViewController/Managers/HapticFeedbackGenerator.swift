import CoreHaptics
import UIKit

class HapticFeedbackGenerator {
    // MARK: - Singleton Instance
    static let shared = HapticFeedbackGenerator()
    
    private var hapticEngine: CHHapticEngine?
    
    private var timer: Timer?
    private var durationTimer: Timer?
    
    // MARK: - Private Initialization
    private init() {
        prepareHapticEngine()
    }
    
    // MARK: - Haptic Engine Preparation
    private func prepareHapticEngine() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic engine failed to start: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Generate Custom Haptic Feedback
    func customVibrationFeedback() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        var events = [CHHapticEvent]()
        var parameterCurves = [CHHapticParameterCurve]()
        
        // Создаем CHHapticEvent для вибрации
        let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1.0)
        
        let startTime = 0.0
        let eventDuration = 1.0
        
        let event = CHHapticEvent(
            eventType: .hapticContinuous,
            parameters: [intensityParameter, sharpnessParameter],
            relativeTime: startTime,
            duration: eventDuration
        )
        events.append(event)
        
        // Создаем кривую для изменения параметра Intensity
        let intensityCurve = CHHapticParameterCurve(
            parameterID: .hapticIntensityControl,
            controlPoints: [
                CHHapticParameterCurve.ControlPoint(relativeTime: 0.0, value: 1.0),
                CHHapticParameterCurve.ControlPoint(relativeTime: 0.5, value: 0.5),
                CHHapticParameterCurve.ControlPoint(relativeTime: 1.0, value: 0.0)
            ],
            relativeTime: 0
        )
        parameterCurves.append(intensityCurve)
        
        // Создаем кривую для изменения параметра Sharpness
        let sharpnessCurve = CHHapticParameterCurve(
            parameterID: .hapticSharpnessControl,
            controlPoints: [
                CHHapticParameterCurve.ControlPoint(relativeTime: 0.0, value: 0.5),
                CHHapticParameterCurve.ControlPoint(relativeTime: 0.5, value: 1.0),
                CHHapticParameterCurve.ControlPoint(relativeTime: 1.0, value: 0.0)
            ],
            relativeTime: 0
        )
        parameterCurves.append(sharpnessCurve)
        
        // Запускаем шаблон
        do {
            let pattern = try CHHapticPattern(events: events, parameterCurves: parameterCurves)
            let player = try hapticEngine?.makePlayer(with: pattern)
            try player?.start(atTime: CHHapticTimeImmediate)
        } catch {
            print("Failed to play haptic pattern: \(error.localizedDescription)")
        }
    }
    
    // MARK: - Generate Custom Haptic Feedback (single pulse, repeated with a timer)
    func datePickerFeedback() {
        self.stopTimers()
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        // Schedule a repeating timer to simulate picker scrolling feedback
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] _ in
            self?.playPickerHaptic()
        }
        
        // Schedule a timer to stop the haptic feedback after 3 seconds
        durationTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { [weak self] _ in
            self?.stopTimers()
        }
    }
    
    // MARK: - Stop the timers
    func stopTimers() {
        // Stop the repeating timer
        timer?.invalidate()
        timer = nil
        
        // Stop the duration timer
        durationTimer?.invalidate()
        durationTimer = nil
    }
    
    // MARK: - Stop the Haptic Engine
    func stopEngine() {
        self.stopTimers()
        
        hapticEngine?.stop(completionHandler: { error in
            if let error = error {
                print("Haptic engine failed to stop: \(error.localizedDescription)")
            }
        })
    }
    
    // MARK: - Private method to create a haptic pattern similar to a picker scroll tick
    private func playPickerHaptic() {
            guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            
            // Create a short haptic event to simulate a "tick" or "click"
            let intensityParameter = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.5)
            let sharpnessParameter = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)
            
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensityParameter, sharpnessParameter],
                relativeTime: 0
            )
            
            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                let player = try hapticEngine?.makePlayer(with: pattern)
                try player?.start(atTime: CHHapticTimeImmediate)
            } catch {
                print("Failed to play haptic pattern: \(error.localizedDescription)")
            }
        }
}
