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
    @Published private var timeRemaining: TimeInterval = 180
    
    private var timer: Timer?
    
    // Format the remaining time to be displayed
    func timeFormatted() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // Starts the timer
    func startTimer() {
        self.isPickerDisabled = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { _ in
            if self.timeRemaining > 0 {
                self.timeRemaining -= 1
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
    
}
