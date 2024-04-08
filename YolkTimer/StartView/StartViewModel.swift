//
//  StartViewModel.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import Foundation

final class StartViewModel: ObservableObject {
    @Published var pickerSelection: EggCookState = .runnyState
    @Published private var timeRemaining: TimeInterval = 180
    @Published var timer: Timer?
    @Published var isRunning: Bool = false
    @Published var isPickerDisabled: Bool = false
    
    func timeFormatted() -> String {
        let minutes = Int(timeRemaining) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
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
    
    func stopTimer() {
        isRunning = false
        timer?.invalidate()
        isPickerDisabled = false
        timeRemaining = 180
    }
    
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
