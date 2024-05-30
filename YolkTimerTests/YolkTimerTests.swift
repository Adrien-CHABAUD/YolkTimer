//
//  YolkTimerTests.swift
//  YolkTimerTests
//
//  Created by Adrien CHABAUD on 2024-05-30.
//

import XCTest
import Combine
@testable import YolkTimer

final class YolkTimerTests: XCTestCase {

//    func test_methodName_withCircumstances_shouldExpectation() throws {
//
//    }
    var startViewModel: StartViewModel!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        
        // Initialize the StartViewModel before each test
        startViewModel = StartViewModel()
    }
    
    override func tearDown() {
        // Clean up after each test
        startViewModel = nil
        cancellables = []
        super.tearDown()
    }
    
    //MARK: - Timer Functionalities
    
    func test_settingTimeFor_RunnyYolk() throws {
        // Given
        let expectedRunnyYolkTime = 180 // 3 minutes in seconds
        startViewModel.pickerSelection = .runnyState // Select the runny state
        
        // When
        startViewModel.selectTime()
        
        // Then
        XCTAssertEqual(Int(startViewModel.remainingTime), expectedRunnyYolkTime, "Runny yolk timer should be set to 3 minutes.")
    }
    
    func test_settingTimeFor_SoftEgg() throws {
        //Given
        let expectedSoftEggTime = 360 // 6 minutes in seconds
        startViewModel.pickerSelection = .softState
        
        // When
        startViewModel.selectTime()
        
        // Then
        XCTAssertEqual(Int(startViewModel.remainingTime), expectedSoftEggTime, "Soft egg timer should be set to 6 minutes.")
    }
    
    func test_settingTimeFor_HardEgg() throws {
        // Given
        let expectedHardEggTime = 540 // 9 minutes in seconds
        startViewModel.pickerSelection = .hardState
        
        // When
        startViewModel.selectTime()
        
        // Then
        XCTAssertEqual(Int(startViewModel.remainingTime), expectedHardEggTime, "Hard egg timer should be set to 9 minutes.")
    }
    
    func test_TimerCountdown() throws {
        // Given
        startViewModel.pickerSelection = .runnyState // 3 minutes in seconds
        startViewModel.selectTime()
        
        // When
        startViewModel.isRunning = true
        print("Timer started with remaining time: \(startViewModel.remainingTime)")
        
        // Set up expectation
        let expectation = self.expectation(description: "Timer should countdown")
        
        // Subscribe to changes in remainingTime
        startViewModel.$remainingTime
            .dropFirst() // Ignore the initial value
            .sink { remainingTime in
                if remainingTime < 180 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 2, handler: nil)
        XCTAssertLessThan(startViewModel.remainingTime, 180, "Timer should count down.")
    }
    
    func test_TimerCompletion() {
        // Given
        let timeInterval: TimeInterval = 5 // Setting a short time interval for testing
        startViewModel.setTimeLimit(timeInterval)
        startViewModel.setRemainingTime(timeInterval)
        startViewModel.isRunning = true
        
        let expectation = self.expectation(description: "Timer should complete.")
        var completionCheck = false
        
        // Subscribe to changes in remainingTime
        startViewModel.$remainingTime
            .dropFirst()
        // Creating a weak reference to self inside the closure to avoid a retain cycle
            .sink { [weak self] remainingTime in
                // Attempt to unwrap self inside the closure, if deallocated returns early
                guard self != nil else { return }
                if remainingTime <= 0 {
                    // Ensure that 'fulfill' is only called once
                    if !completionCheck {
                        expectation.fulfill()
                        completionCheck = true
                    }
                }
            }
            .store(in: &cancellables)
        
        // When
        waitForExpectations(timeout: timeInterval + 1) { error in
            // Then
            XCTAssertNil(error, "Expectation should not fail.")
            XCTAssertTrue(completionCheck, "Expectation should be fulfilled.")
            XCTAssertTrue(self.startViewModel.checkCompletion(), "checkCompletion should be true.")
            XCTAssertFalse(self.startViewModel.isRunning, "Timer should stop running.")
        }
    }
    
    func test_RapidTimerChangesBeforeTesting() throws {
        // Given
        let initialTimeInterval: TimeInterval = 5
        startViewModel.setTimeLimit(initialTimeInterval)
        startViewModel.setRemainingTime(initialTimeInterval)
        
        let expectation = self.expectation(description: "Rapid timer changes before starting should not cause errors.")
        
        // Rapidly change the timer duration
        let changeIntervals: [TimeInterval] = [10, 20, 30, 5, 15]
        var finalInterval: TimeInterval = 15
        
        for interval in changeIntervals {
            startViewModel.setTimeLimit(interval)
            startViewModel.setRemainingTime(interval)
            finalInterval = interval
        }
        
        // Ensure the timer is not running initially
        XCTAssertFalse(startViewModel.isRunning)
        
        // Subscribe to changes in remainingTime
        startViewModel.$remainingTime
            .dropFirst()
            .sink { remainingTime in
                if remainingTime <= 0 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        // When
        startViewModel.isRunning = true
        
        // Wait for the timer to complete
        waitForExpectations(timeout: finalInterval + 1) { error in
            // Then
            XCTAssertNil(error, "Expectation should not fail.")
            XCTAssertLessThanOrEqual(self.startViewModel.remainingTime, 0, "Remaining time should be equal to 0.")
        }
    }
}
