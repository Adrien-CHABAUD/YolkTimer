//
//  StartViewModel.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import Foundation

final class StartViewModel: ObservableObject {
    @Published var pickerSelection: EggCookState = .runnyState
    @Published var isRunning: Bool = false
    @Published var isPickerDisabled: Bool = false
    @Published var isFactDisabled: Bool = true
    @Published private var timeRemaining: TimeInterval = 180
    @Published var factDisplay: String = funFacts().facts[0]
    
    
    private var timer: Timer?
    
    // Format the remaining time to be displayed
    func timeFormatted() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Starts the timer
    func startTimer() {
        isPickerDisabled = true
        isFactDisabled = false
                
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
                
                // Update the fact every 20secs.
                if Int(self.timeRemaining) % 20 == 0 {
                    self.selectFact()
                }
            } else {
                self.stopTimer()
            }
        })
    }
    
    // Stops the timer
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        isPickerDisabled = false
        isFactDisabled = true
        selectTime()
    }
    
    /*
     *  Change the time of the timer according to
     *  what cooking the user selected
     */
    func selectTime() {
        switch pickerSelection {
        case .runnyState:
            timeRemaining = 180
        case .softState:
            timeRemaining = 360
        case .hardState:
            timeRemaining = 540
        }
    }
    
    // Randomly selects fun facts to display
    func selectFact() {
        let number = Int.random(in: 0...funFacts().facts.count-1)
        factDisplay = funFacts().facts[number]
    }
    
    func selectPicture() -> String {
        // Cooking State
        if isRunning {
            return "SaucePan"
        }
        
        switch pickerSelection {
        case .runnyState:
            return "RunnyEgg"
        case .softState:
            return "SoftBoiledEgg"
        case .hardState:
            return "HardBoiledEgg"
        }
    }
}
