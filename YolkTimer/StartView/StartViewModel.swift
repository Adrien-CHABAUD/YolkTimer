//
//  StartViewModel.swift
//  YolkTimer
//
//  Created by Adrien CHABAUD on 2024-04-05.
//

import Foundation
import Combine

final class StartViewModel: ObservableObject {
    // UI
    @Published var pickerSelection: EggCookState = .runnyState
    @Published var isPickerDisabled: Bool = false
    @Published var isFactDisabled: Bool = true
    @Published var factDisplay: String = funFacts().facts[0]
    
    // Timer
    private var timeLimit: TimeInterval = TimeInterval(180)
    private var startTime: Date?
    private var accumulatedTime: TimeInterval = 0
    private var timer: Cancellable?
    private var elapsedTime: TimeInterval = 0
    @Published private(set) var remainingTime: TimeInterval = TimeInterval(180)
    
    // Status
    @Published private(set) var isOnHold: Bool = false
    @Published var isRunning = false {
        didSet {
            if self.isRunning {
                self.start()
            } else {
                self.stop()
            }
        }
    }
    
    // Start function
    private func start() -> Void {
        // Disable UI
        self.isPickerDisabled = true
        self.isFactDisabled = false
        
        self.isOnHold = false
        
        // timer allowing to update the UI
        self.timer?.cancel()
        self.timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect().sink { _ in
            self.elapsedTime = self.getElapsedTime()
            if self.checkCompletion() { self.isRunning.toggle() }
            // Update the fact every
            if Int(self.remainingTime) % 20 == 0 {
                self.selectFact()
            }
        }
        
        // Take the start moment of the timer
        self.startTime = Date()
    }
    
    // Stop function
    private func stop() -> Void {
        self.timer?.cancel()
        self.timer = nil
        self.accumulatedTime = self.getElapsedTime()
        self.startTime = nil
        self.isOnHold = true
    }
    
    // Reset function
    func reset() -> Void {
        self.accumulatedTime = 0
        self.elapsedTime = 0
        self.startTime = nil
        self.isRunning = false
        self.remainingTime = self.timeLimit
        
        self.isFactDisabled = true
        self.isPickerDisabled = false
        self.selectTime()
        
        self.isOnHold = false
    }
    
    // Check if the timer run out
    private func checkCompletion() -> Bool {
        self.remainingTime = self.getRemainingTime()
        return self.remainingTime <= 0
    }
    
    /*
     * Compute the difference between time that passed
     * and the set time needed
     */
    private func getRemainingTime() -> TimeInterval {
        return self.timeLimit - self.elapsedTime
    }
    
    // Compute the elapsed time between start and now
    private func getElapsedTime() -> TimeInterval {
        return -(self.startTime?.timeIntervalSinceNow ?? 0) + self.accumulatedTime
    }
    
    // Allow to change the timer
    private func changeTimeLimit(timeInterval: TimeInterval) -> Void {
        self.timeLimit = timeInterval
        self.remainingTime = timeInterval
    }
    
    // Display or not the reset button
    func isResetDisabled() -> Bool {
        // Process is on hold
        if self.isOnHold {
            return false
        } else if self.isRunning { // Timer is running
            return false
        }
        return true
    }
    
    /*
     *  Change the time of the timer according to
     *  what cooking the user selected
     */
    func selectTime() {
        switch pickerSelection {
        case .runnyState:
            // 3 min
            self.changeTimeLimit(timeInterval: TimeInterval(180))
        case .softState:
            // 6 min
            self.changeTimeLimit(timeInterval: TimeInterval(360))
        case .hardState:
            // 9 min
            self.changeTimeLimit(timeInterval: TimeInterval(540))
        }
    }
    
    // Randomly selects fun facts to display
    func selectFact() {
        let number = Int.random(in: 0...funFacts().facts.count-1)
        factDisplay = funFacts().facts[number]
    }
    
    /*
     * Selection of the picture to display according
     * to the selection
     */
    func selectPicture() -> String {
        // Cooking State
        if !self.isResetDisabled() {
            return "SaucePan"
        }
        
        switch self.pickerSelection {
        case .runnyState:
            return "RunnyEgg"
        case .softState:
            return "SoftBoiledEgg"
        case .hardState:
            return "HardBoiledEgg"
        }
    }
}
